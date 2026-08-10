import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/connectivity_service.dart';
import 'package:pinmap_travel_journal/services/image_compressor.dart';
import 'package:pinmap_travel_journal/services/local_ticket_store.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

class ImageUploadResult {
  final int? journalId; // server id when known
  final int? pageId;
  final int? elementId;
  final String? imageUrl;
  final String? localPath;
  final bool queuedOffline;

  ImageUploadResult({
    this.journalId,
    this.pageId,
    this.elementId,
    this.imageUrl,
    this.localPath,
    this.queuedOffline = false,
  });
}

/// Uploads a journal photo (e.g. picked from the gallery/camera) by reusing
/// the ticket upload endpoint with `elementType: 'image'`. Falls back to the
/// offline queue when the device is offline or the upload fails.
class ImageUploadService {
  static Future<ImageUploadResult> upload({
    required int journalId,
    required String journalTitle,
    required int countryId,
    required int? pageId,
    required String elementKey,
    required Uint8List imageBytes,
    required double xPosition,
    required double yPosition,
    required double width,
    required double height,
    required double scale,
    required double rotation,
    int zIndex = 1,
  }) async {
    final compressed =
        await ImageCompressor.compressJpeg(imageBytes, quality: 85);
    final localPath = await LocalTicketStore.saveTicketBytes(
      compressed,
      journalId,
      original: true,
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
          processedBytes: compressed,
          xPosition: xPosition,
          yPosition: yPosition,
          width: width,
          height: height,
          scale: scale,
          rotation: rotation,
          zIndex: zIndex,
        );
        return ImageUploadResult(
          journalId: data['journalId'] as int? ?? journalId,
          pageId: data['pageId'] as int?,
          elementId: data['elementId'] as int?,
          imageUrl: data['processedImageUrl'] as String?,
          localPath: localPath,
          queuedOffline: false,
        );
      } catch (e) {
        debugPrint('ImageUploadService.upload failed, queueing offline: $e');
      }
    }

    final originalBase64 = _embedForQueue(compressed, localPath);

    await SyncQueueService.enqueue(SyncAction(
      type: SyncActionType.addTicketScan,
      data: {
        'journalId': journalId,
        'journalTitle': journalTitle,
        'countryId': countryId,
        'pageId': pageId,
        'backgroundRemoved': false,
        'xPosition': xPosition.round(),
        'yPosition': yPosition.round(),
        'width': width.round(),
        'height': height.round(),
        'scale': scale,
        'rotation': rotation,
        'zIndex': zIndex,
        'elementType': 'image',
        'elementKey': elementKey,
        'localProcessedPath': localPath,
        'processedBase64': originalBase64,
      },
      timestamp: DateTime.now(),
    ));

    return ImageUploadResult(
      journalId: journalId,
      localPath: localPath,
      queuedOffline: true,
    );
  }

  static String? _embedForQueue(Uint8List bytes, String? localPath) {
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
    required Uint8List processedBytes,
    required double xPosition,
    required double yPosition,
    required double width,
    required double height,
    required double scale,
    required double rotation,
    required int zIndex,
  }) async {
    final data = await ApiClient.uploadMultipart(
      '/tickets',
      fields: {
        'journalId': '$journalId',
        'journalTitle': journalTitle,
        'countryId': '$countryId',
        'pageId': pageId == null ? '' : '$pageId',
        'backgroundRemoved': 'false',
        'xPosition': xPosition.round().toString(),
        'yPosition': yPosition.round().toString(),
        'width': width.round().toString(),
        'height': height.round().toString(),
        'scale': scale.toStringAsFixed(2),
        'rotation': rotation.toStringAsFixed(2),
        'zIndex': zIndex.toString(),
        'elementType': 'image',
        'elementKey': elementKey,
      },
      files: [
        MultipartFileSpec(
          field: 'processed',
          bytes: processedBytes,
          filename: 'photo.jpg',
          contentType: 'image/jpeg',
        ),
      ],
    );
    return Map<String, dynamic>.from(data as Map);
  }
}
