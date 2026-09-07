import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class AuthenticatedCachedImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  const AuthenticatedCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<AuthenticatedCachedImage> createState() => _AuthenticatedCachedImageState();
}

class _AuthenticatedCachedImageState extends State<AuthenticatedCachedImage> {
  bool get _isUpload => widget.imageUrl.startsWith('/uploads/');
  late Future<Map<String, String>> _headersFuture;

  @override
  void initState() {
    super.initState();
    _headersFuture = _loadHeaders();
  }

  @override
  void didUpdateWidget(covariant AuthenticatedCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _headersFuture = _loadHeaders();
    }
  }

  Future<Map<String, String>> _loadHeaders() {
    if (!_isUpload) return Future.value(const {});
    return ApiClient.authHeadersForImage();
  }

  @override
  Widget build(BuildContext context) {
    final url = ApiConfig.assetUrl(widget.imageUrl);
    if (!_isUpload) {
      return CachedNetworkImage(
        imageUrl: url,
        width: widget.width,
        height: widget.height,
        memCacheWidth: widget.width != null ? (widget.width! * 3).round() : null,
        memCacheHeight: widget.height != null ? (widget.height! * 3).round() : null,
        maxWidthDiskCache: widget.width != null ? (widget.width! * 3).round() : null,
        maxHeightDiskCache: widget.height != null ? (widget.height! * 3).round() : null,
        fit: widget.fit,
        placeholder: widget.placeholder,
        errorWidget: widget.errorWidget,
      );
    }
    return FutureBuilder<Map<String, String>>(
      future: _headersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (widget.placeholder != null) return widget.placeholder!(context, url);
          return Container(
            width: widget.width,
            height: widget.height,
            color: AppTheme.lightGray,
            child: const SizedBox(),
          );
        }
        final headers = snapshot.data ?? {};
        return CachedNetworkImage(
          imageUrl: url,
          httpHeaders: headers,
          width: widget.width,
          height: widget.height,
          memCacheWidth: widget.width != null ? (widget.width! * 3).round() : null,
          memCacheHeight: widget.height != null ? (widget.height! * 3).round() : null,
          maxWidthDiskCache: widget.width != null ? (widget.width! * 3).round() : null,
          maxHeightDiskCache: widget.height != null ? (widget.height! * 3).round() : null,
          fit: widget.fit,
          placeholder: widget.placeholder,
          errorWidget: widget.errorWidget ??
              (context, url, error) => Container(
                    width: widget.width,
                    height: widget.height,
                    color: AppTheme.lightGray,
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
        );
      },
    );
  }
}
