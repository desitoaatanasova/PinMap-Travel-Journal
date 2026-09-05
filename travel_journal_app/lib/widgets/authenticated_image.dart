import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/api_config.dart';
import 'package:pinmap_travel_journal/theme/app_theme.dart';

class AuthenticatedCachedImage extends StatelessWidget {
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

  bool get _isUpload => imageUrl.startsWith('/uploads/');

  @override
  Widget build(BuildContext context) {
    final url = ApiConfig.assetUrl(imageUrl);
    if (!_isUpload) {
      return CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: placeholder,
        errorWidget: errorWidget,
      );
    }
    return FutureBuilder<Map<String, String>>(
      future: ApiClient.authHeadersForImage(),
      builder: (context, snapshot) {
        final headers = snapshot.data ?? {};
        return CachedNetworkImage(
          imageUrl: url,
          httpHeaders: headers,
          width: width,
          height: height,
          fit: fit,
          placeholder: placeholder,
          errorWidget: errorWidget ??
              (context, url, error) => Container(
                    width: width,
                    height: height,
                    color: AppTheme.lightGray,
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
        );
      },
    );
  }
}
