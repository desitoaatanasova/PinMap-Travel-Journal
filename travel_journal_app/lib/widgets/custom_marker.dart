import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travel_journal_app/models/map_marker.dart';

class CustomMarker extends StatelessWidget {
  final MapMarker marker;
  final double size;

  const CustomMarker({
    super.key,
    required this.marker,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: marker.color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            marker.icon,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
        // Triangle pointer
        ClipPath(
          clipper: _TriangleClipper(),
          child: Container(
            width: 12,
            height: 8,
            color: marker.color,
          ),
        ),
      ],
    );
  }
}

class _TriangleClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final path = ui.Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

// Helper: Convert MapMarker to flutter_map Marker
Marker buildMapMarker(MapMarker marker) {
  return Marker(
    point: marker.position,
    width: 80,
    height: 60,
    child: CustomMarker(marker: marker, size: 36),
  );
}

// Helper: Build multiple markers
List<Marker> buildMapMarkers(List<MapMarker> markers) {
  return markers.map((m) => buildMapMarker(m)).toList();
}
