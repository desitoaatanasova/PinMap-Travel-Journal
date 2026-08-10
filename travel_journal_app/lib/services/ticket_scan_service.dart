import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/camera_capture_screen.dart';
import 'package:pinmap_travel_journal/services/captured_image.dart';
import 'package:pinmap_travel_journal/services/connectivity_service.dart';
import 'package:pinmap_travel_journal/services/image_compressor.dart';
import 'package:pinmap_travel_journal/services/local_ticket_store.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';
import 'package:pinmap_travel_journal/services/ticket_boundary_detector.dart';
import 'package:pinmap_travel_journal/services/ticket_image_processor.dart';

class TicketSaveResult {
  final int? journalId; // server id when known
  final int? pageId;
  final int? ticketId;
  final String? imageUrl;
  final String? localPath;
  final String? elementKey;
  final bool queuedOffline;

  TicketSaveResult({
    this.journalId,
    this.pageId,
    this.ticketId,
    this.imageUrl,
    this.localPath,
    this.elementKey,
    this.queuedOffline = false,
  });
}

class TicketScanService {
  static Future<CapturedImage?> capture(BuildContext context) async {
    if (!await requestCameraPermission()) {
      throw TicketScanException('Camera permission was not granted.');
    }
    if (!context.mounted) return null;
    final image = await captureTicketPhoto(context);
    if (image == null) {
      throw TicketScanCancelledException();
    }
    return image;
  }

  static Future<TicketCorners?> detect(Uint8List bytes) {
    return TicketBoundaryDetector.detect(bytes);
  }

  static Future<Uint8List?> crop(Uint8List bytes, TicketCorners corners) {
    return Future.value(TicketImageProcessor.perspectiveWarp(bytes, corners));
  }

  /// Applies background removal (-> transparent PNG) or keeps the original
  /// image, then compresses while keeping good quality.
  static Future<Uint8List> process({
    required Uint8List cropped,
    required bool removeBackground,
  }) async {
    if (removeBackground) {
      final removed = TicketImageProcessor.removeBackground(cropped);
      if (removed != null) {
        return ImageCompressor.compressPng(removed);
      }
    }
    return ImageCompressor.compressJpeg(cropped, quality: 88);
  }

  static Future<TicketSaveResult> save({
    required int journalId,
    required String journalTitle,
    required int countryId,
    required int? pageId,
    required String elementKey,
    required Uint8List originalBytes,
    required Uint8List processedBytes,
    required bool backgroundRemoved,
    required double xPosition,
    required double yPosition,
    required double width,
    required double height,
    required double scale,
    required double rotation,
    int zIndex = 0,
  }) async {
    // Never lose the original: persist locally first (mobile keeps real files).
    final localOriginal = await LocalTicketStore.saveTicketBytes(
      originalBytes,
      journalId,
      original: true,
    );
    final localProcessed = await LocalTicketStore.saveTicketBytes(
      processedBytes,
      journalId,
      original: false,
    );

    final online = await ConnectivityService().isCurrentlyOnline;
    if (online) {
      try {
        final data = await _upload(
          journalId: journalId,
          journalTitle: journalTitle,
          countryId: countryId,
          pageId: pageId,
          elementKey: elementKey,
          originalBytes: originalBytes,
          processedBytes: processedBytes,
          backgroundRemoved: backgroundRemoved,
          xPosition: xPosition,
          yPosition: yPosition,
          width: width,
          height: height,
          scale: scale,
          rotation: rotation,
          zIndex: zIndex,
        );
        return TicketSaveResult(
          journalId: data['journalId'] as int? ?? journalId,
          pageId: data['pageId'] as int?,
          ticketId: data['ticketId'] as int?,
          imageUrl: data['processedImageUrl'] as String?,
          localPath: localProcessed,
          elementKey: elementKey,
          queuedOffline: false,
        );
      } catch (e) {
        debugPrint('TicketScanService.upload failed, queueing offline: $e');
      }
    }

    // Offline (or upload failure): keep the image locally and queue a retry.
    final originalBase64 = await _embedForQueue(originalBytes, localOriginal);
    final processedBase64 = await _embedForQueue(processedBytes, localProcessed);

    await SyncQueueService.enqueue(SyncAction(
      type: SyncActionType.addTicketScan,
      data: {
        'journalId': journalId,
        'journalTitle': journalTitle,
        'countryId': countryId,
        'pageId': pageId,
        'backgroundRemoved': backgroundRemoved,
        'elementKey': elementKey,
        'xPosition': xPosition.round(),
        'yPosition': yPosition.round(),
        'width': width.round(),
        'height': height.round(),
        'scale': scale,
        'rotation': rotation,
        'zIndex': zIndex,
        'localOriginalPath': localOriginal,
        'localProcessedPath': localProcessed,
        'originalBase64': originalBase64,
        'processedBase64': processedBase64,
      },
      timestamp: DateTime.now(),
    ));

    return TicketSaveResult(
      journalId: journalId,
      localPath: localProcessed,
      elementKey: elementKey,
      queuedOffline: true,
    );
  }

  static Future<String?> _embedForQueue(
      Uint8List bytes, String? localPath) async {
    if (localPath != null) return null; // file exists locally, no need to embed
    if (bytes.length > 2 * 1024 * 1024) return null; // too large for prefs
    return base64Encode(bytes);
  }

  static Future<Map<String, dynamic>> _upload({
    required int journalId,
    required String journalTitle,
    required int countryId,
    required int? pageId,
    required String elementKey,
    required Uint8List originalBytes,
    required Uint8List processedBytes,
    required bool backgroundRemoved,
    required double xPosition,
    required double yPosition,
    required double width,
    required double height,
    required double scale,
    required double rotation,
    int zIndex = 0,
  }) async {
    final data = await ApiClient.uploadMultipart(
      '/tickets',
      fields: {
        'journalId': '$journalId',
        'journalTitle': journalTitle,
        'countryId': '$countryId',
        'pageId': pageId == null ? '' : '$pageId',
        'backgroundRemoved': '$backgroundRemoved',
        'xPosition': xPosition.round().toString(),
        'yPosition': yPosition.round().toString(),
        'width': width.round().toString(),
        'height': height.round().toString(),
        'scale': scale.toStringAsFixed(2),
        'rotation': rotation.toStringAsFixed(2),
        'zIndex': zIndex.toString(),
        'elementType': 'ticket',
        'elementKey': elementKey,
      },
      files: [
        MultipartFileSpec(
          field: 'original',
          bytes: originalBytes,
          filename: 'original.png',
          contentType: 'image/png',
        ),
        MultipartFileSpec(
          field: 'processed',
          bytes: processedBytes,
          filename: 'processed.png',
          contentType: 'image/png',
        ),
      ],
    );
    return Map<String, dynamic>.from(data as Map);
  }
}

class TicketScanException implements Exception {
  final String message;
  TicketScanException(this.message);
  @override
  String toString() => message;
}

class TicketScanCancelledException implements Exception {
  @override
  String toString() => 'Scan cancelled';
}
