import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;

/// Corner order: top-left, top-right, bottom-right, bottom-left.
class TicketCorners {
  final Offset tl;
  final Offset tr;
  final Offset br;
  final Offset bl;
  final double confidence;

  TicketCorners({
    required this.tl,
    required this.tr,
    required this.br,
    required this.bl,
    this.confidence = 1.0,
  });

  List<Offset> get ordered => [tl, tr, br, bl];
}

class _Component {
  int minX = 0, minY = 0, maxX = 0, maxY = 0;
  int area = 0;
}

class _RotRect {
  final Offset tl;
  final Offset tr;
  final Offset br;
  final Offset bl;
  final double area;

  _RotRect(this.tl, this.tr, this.br, this.bl, this.area);
}

/// Pure-Dart image processing for ticket scans. Works on every platform
/// (web included). Detection is a best-effort geometric heuristic; callers
/// fall back to manual cropping when it returns null / low confidence.
class TicketImageProcessor {
  static const double _maxDetectDim = 480;

  // ===================== DETECTION =====================

  static TicketCorners? detectCorners(Uint8List bytes) {
    final src = img.decodeImage(bytes);
    if (src == null) return null;

    final scale = math.min(1.0, _maxDetectDim / math.max(src.width, src.height));
    final w = math.max(1, (src.width * scale).round());
    final h = math.max(1, (src.height * scale).round());
    final small = img.copyResize(src, width: w, height: h, interpolation: img.Interpolation.average);

    final lum = _luminance(small);
    final otsu = _otsuThreshold(lum);

    TicketCorners? best;    for (final invert in [false, true]) {
      final binary = _binarize(lum, w, h, otsu, invert);
      final components = _connectedComponents(binary, w, h);
      components.sort((a, b) => b.area.compareTo(a.area));
      for (final comp in components.take(3)) {
        final cand = _candidateFromComponent(comp, binary, w, h);
        if (cand == null) continue;
        if (best == null || cand.confidence > best.confidence) best = cand;
      }
    }

    if (best == null || best.confidence < 0.55) return null;

    Offset scalePoint(Offset p) => Offset(p.dx / scale, p.dy / scale);
    return TicketCorners(
      tl: scalePoint(best.tl),
      tr: scalePoint(best.tr),
      br: scalePoint(best.br),
      bl: scalePoint(best.bl),
      confidence: best.confidence,
    );
  }

  static double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  static List<List<double>> _luminance(img.Image image) {
    final h = image.height;
    final w = image.width;
    final lum = List.generate(h, (_) => List<double>.filled(w, 0));
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final p = image.getPixel(x, y);
        lum[y][x] = 0.299 * p.r + 0.587 * p.g + 0.114 * p.b;
      }
    }
    return lum;
  }

  static int _otsuThreshold(List<List<double>> lum) {
    final hist = List<int>.filled(256, 0);
    var total = 0;
    for (final row in lum) {
      for (final v in row) {
        hist[v.round().clamp(0, 255).toInt()]++;
        total++;
      }
    }
    if (total == 0) return 128;
    var sum = 0.0;
    for (var i = 0; i < 256; i++) {
      sum += i * hist[i];
    }
    var sumB = 0.0;
    var wB = 0;
    var maxVar = -1.0;
    var threshold = 128;
    for (var i = 0; i < 256; i++) {
      wB += hist[i];
      if (wB == 0) continue;
      final wF = total - wB;
      if (wF == 0) break;
      sumB += i * hist[i];
      final mB = sumB / wB;
      final mF = (sum - sumB) / wF;
      final between = wB.toDouble() * wF.toDouble() * (mB - mF) * (mB - mF);
      if (between > maxVar) {
        maxVar = between;
        threshold = i;
      }
    }
    return threshold;
  }

  static List<List<bool>> _binarize(
      List<List<double>> lum, int w, int h, int threshold, bool invert) {
    final binary = List.generate(h, (_) => List<bool>.filled(w, false));
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final isBright = lum[y][x] >= threshold;
        binary[y][x] = invert ? !isBright : isBright;
      }
    }
    return binary;
  }

  static List<_Component> _connectedComponents(
      List<List<bool>> binary, int w, int h) {
    final visited = List.generate(h, (_) => List<bool>.filled(w, false));
    final comps = <_Component>[];
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        if (!binary[y][x] || visited[y][x]) continue;
        final comp = _Component()
          ..minX = x
          ..minY = y
          ..maxX = x
          ..maxY = y
          ..area = 0;
        final queue = [(x, y)];
        visited[y][x] = true;
        while (queue.isNotEmpty) {
          final (cx, cy) = queue.removeLast();
          comp.area++;
          if (cx < comp.minX) comp.minX = cx;
          if (cx > comp.maxX) comp.maxX = cx;
          if (cy < comp.minY) comp.minY = cy;
          if (cy > comp.maxY) comp.maxY = cy;
          for (var dy = -1; dy <= 1; dy++) {
            for (var dx = -1; dx <= 1; dx++) {
              if (dx == 0 && dy == 0) continue;
              final nx = cx + dx;
              final ny = cy + dy;
              if (nx < 0 || ny < 0 || nx >= w || ny >= h) continue;
              if (!visited[ny][nx] && binary[ny][nx]) {
                visited[ny][nx] = true;
                queue.add((nx, ny));
              }
            }
          }
        }
        if (comp.area > 40) comps.add(comp);
      }
    }
    return comps;
  }

  static TicketCorners? _candidateFromComponent(
      _Component comp, List<List<bool>> binary, int w, int h) {
    final cw = comp.maxX - comp.minX + 1;
    final ch = comp.maxY - comp.minY + 1;
    final compFrac = comp.area / (cw * ch);
    final frameFrac = comp.area / (w * h);

    if (frameFrac > 0.92) return null; // object fills the frame
    if (frameFrac < 0.02) return null; // too small to be a ticket
    if (compFrac < 0.55) return null; // too sparse/irregular

    // Collect the component's pixels into a hull.
    final points = <math.Point<int>>[];
    final stride = math.max(1, comp.area ~/ 4000);
    var count = 0;
    for (var y = comp.minY; y <= comp.maxY; y++) {
      for (var x = comp.minX; x <= comp.maxX; x++) {
        if (binary[y][x]) {
          count++;
          if (count % stride == 0) {
            points.add(math.Point(x, y));
          }
        }
      }
    }
    if (points.length < 4) return null;

    final hull = _convexHull(points);
    if (hull.length < 3) return null;

    final rect = _minAreaRect(hull);
    if (rect == null) return null;

    final hullArea = _polygonArea(hull);
    final rectArea = rect.area;
    if (rectArea <= 0) return null;
    final rectFrac = rectArea / (w * h);
    if (rectFrac < 0.03 || rectFrac > 0.92) return null;

    final fill = hullArea / rectArea;
    final confidence = 0.6 * compFrac + 0.4 * fill;
    if (confidence < 0.55) return null;

    return TicketCorners(
      tl: rect.tl,
      tr: rect.tr,
      br: rect.br,
      bl: rect.bl,
      confidence: confidence,
    );
  }

  static List<math.Point<int>> _convexHull(List<math.Point<int>> pts) {
    final p = List<math.Point<int>>.from(pts)
      ..sort((a, b) => a.x != b.x ? a.x.compareTo(b.x) : a.y.compareTo(b.y));
    if (p.length <= 2) return p;

    math.Point<int> cross(math.Point<int> o, math.Point<int> a, math.Point<int> b) =>
        math.Point((a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x), 0);

    final lower = <math.Point<int>>[];
    for (final pt in p) {
      while (lower.length >= 2 &&
          cross(lower[lower.length - 2], lower[lower.length - 1], pt).x <= 0) {
        lower.removeLast();
      }
      lower.add(pt);
    }
    final upper = <math.Point<int>>[];
    for (final pt in p.reversed) {
      while (upper.length >= 2 &&
          cross(upper[upper.length - 2], upper[upper.length - 1], pt).x <= 0) {
        upper.removeLast();
      }
      upper.add(pt);
    }
    lower.removeLast();
    upper.removeLast();
    return [...lower, ...upper];
  }

  static double _polygonArea(List<math.Point<int>> pts) {
    var area = 0.0;
    for (var i = 0; i < pts.length; i++) {
      final j = (i + 1) % pts.length;
      area += pts[i].x * pts[j].y - pts[j].x * pts[i].y;
    }
    return area.abs() / 2;
  }

  static _RotRect? _minAreaRect(List<math.Point<int>> hull) {
    var bestArea = double.infinity;
    Offset? bestTL, bestTR, bestBR, bestBL;

    for (var i = 0; i < hull.length; i++) {
      final a = hull[i];
      final b = hull[(i + 1) % hull.length];
      var ex = (b.x - a.x).toDouble();
      var ey = (b.y - a.y).toDouble();
      final len = math.sqrt(ex * ex + ey * ey);
      if (len < 1e-6) continue;
      ex /= len;
      ey /= len;
      // normal
      final nx = -ey;
      final ny = ex;

      var minAlong = double.infinity;
      var maxAlong = -double.infinity;
      var minNorm = double.infinity;
      var maxNorm = -double.infinity;
      for (final p in hull) {
        final along = (p.x - a.x) * ex + (p.y - a.y) * ey;
        final norm = (p.x - a.x) * nx + (p.y - a.y) * ny;
        if (along < minAlong) minAlong = along;
        if (along > maxAlong) maxAlong = along;
        if (norm < minNorm) minNorm = norm;
        if (norm > maxNorm) maxNorm = norm;
      }
      final wRect = maxAlong - minAlong;
      final hRect = maxNorm - minNorm;
      final area = wRect * hRect;
      if (area < bestArea) {
        bestArea = area;
        Offset corner(double along, double norm) => Offset(
              a.x + along * ex + norm * nx,
              a.y + along * ey + norm * ny,
            );
        bestTL = corner(minAlong, minNorm);
        bestTR = corner(maxAlong, minNorm);
        bestBR = corner(maxAlong, maxNorm);
        bestBL = corner(minAlong, maxNorm);
      }
    }
    if (bestTL == null || bestTR == null || bestBR == null || bestBL == null) {
      return null;
    }
    return _RotRect(bestTL, bestTR, bestBR, bestBL, bestArea);
  }

  // ===================== PERSPECTIVE WARP =====================

  static Uint8List? perspectiveWarp(Uint8List bytes, TicketCorners corners,
      {int maxDim = 1400}) {
    final src = img.decodeImage(bytes);
    if (src == null) return null;

    final c = corners;
    final width = math.max(
        _distance(c.tl, c.tr), _distance(c.bl, c.br));
    final height = math.max(_distance(c.tl, c.bl), _distance(c.tr, c.br));

    final scale = math.min(1.0, maxDim / math.max(width, height));
    final outW = math.max(1, (width * scale).round());
    final outH = math.max(1, (height * scale).round());

    final h = _homography(
      srcOut: [c.tl, c.tr, c.br, c.bl],
      dstOut: [
        const Offset(0, 0),
        Offset(outW.toDouble() - 1, 0),
        Offset(outW.toDouble() - 1, outH.toDouble() - 1),
        Offset(0, outH.toDouble() - 1),
      ],
    );
    if (h == null) return null;

    final out = img.Image(width: outW, height: outH, numChannels: 3);
    for (var y = 0; y < outH; y++) {
      for (var x = 0; x < outW; x++) {
        final srcPt = _applyH(h, x.toDouble(), y.toDouble());
        final sx = srcPt.dx;
        final sy = srcPt.dy;
        if (sx < 0 || sy < 0 || sx > src.width - 1 || sy > src.height - 1) {
          out.setPixelRgb(x, y, 255, 255, 255);
          continue;
        }
        final x0 = sx.floor();
        final y0 = sy.floor();
        final x1 = math.min(x0 + 1, src.width - 1);
        final y1 = math.min(y0 + 1, src.height - 1);
        final fx = sx - x0;
        final fy = sy - y0;
        final p00 = src.getPixel(x0, y0);
        final p10 = src.getPixel(x1, y0);
        final p01 = src.getPixel(x0, y1);
        final p11 = src.getPixel(x1, y1);
        final r = (p00.r * (1 - fx) + p10.r * fx) * (1 - fy) +
            (p01.r * (1 - fx) + p11.r * fx) * fy;
        final g = (p00.g * (1 - fx) + p10.g * fx) * (1 - fy) +
            (p01.g * (1 - fx) + p11.g * fx) * fy;
        final b = (p00.b * (1 - fx) + p10.b * fx) * (1 - fy) +
            (p01.b * (1 - fx) + p11.b * fx) * fy;
        out.setPixelRgb(x, y, r.round().clamp(0, 255),
            g.round().clamp(0, 255), b.round().clamp(0, 255));
      }
    }
    return img.encodePng(out);
  }

  static List<double>? _homography({
    required List<Offset> srcOut,
    required List<Offset> dstOut,
  }) {
    final a = List.generate(8, (_) => List<double>.filled(8, 0));
    final b = List<double>.filled(8, 0);
    for (var i = 0; i < 4; i++) {
      final x = srcOut[i].dx;
      final y = srcOut[i].dy;
      final u = dstOut[i].dx;
      final v = dstOut[i].dy;
      a[i * 2][0] = x;
      a[i * 2][1] = y;
      a[i * 2][2] = 1;
      a[i * 2][3] = 0;
      a[i * 2][4] = 0;
      a[i * 2][5] = 0;
      a[i * 2][6] = -u * x;
      a[i * 2][7] = -u * y;
      b[i * 2] = u;
      a[i * 2 + 1][0] = 0;
      a[i * 2 + 1][1] = 0;
      a[i * 2 + 1][2] = 0;
      a[i * 2 + 1][3] = x;
      a[i * 2 + 1][4] = y;
      a[i * 2 + 1][5] = 1;
      a[i * 2 + 1][6] = -v * x;
      a[i * 2 + 1][7] = -v * y;
      b[i * 2 + 1] = v;
    }
    final sol = _solveLinear(a, b);
    if (sol == null) return null;
    return [sol[0], sol[1], sol[2], sol[3], sol[4], sol[5], sol[6], sol[7], 1.0];
  }

  static Offset _applyH(List<double> h, double x, double y) {
    final w = h[6] * x + h[7] * y + h[8];
    if (w.abs() < 1e-9) return const Offset(-1, -1);
    final u = (h[0] * x + h[1] * y + h[2]) / w;
    final v = (h[3] * x + h[4] * y + h[5]) / w;
    return Offset(u, v);
  }

  static List<double>? _solveLinear(
      List<List<double>> a, List<double> b) {
    final n = b.length;
    final m = List.generate(n, (i) => List<double>.from(a[i])..add(b[i]));
    for (var col = 0; col < n; col++) {
      var piv = col;
      for (var r = col + 1; r < n; r++) {
        if (m[r][col].abs() > m[piv][col].abs()) piv = r;
      }
      if (m[piv][col].abs() < 1e-12) return null;
      final tmp = m[col];
      m[col] = m[piv];
      m[piv] = tmp;
      final div = m[col][col];
      for (var j = col; j <= n; j++) {
        m[col][j] /= div;
      }
      for (var r = 0; r < n; r++) {
        if (r == col) continue;
        final factor = m[r][col];
        for (var j = col; j <= n; j++) {
          m[r][j] -= factor * m[col][j];
        }
      }
    }
    return List.generate(n, (i) => m[i][n]);
  }

  // ===================== BACKGROUND REMOVAL =====================

  static Uint8List? removeBackground(Uint8List bytes,
      {double tolerance = 28}) {
    final src = img.decodeImage(bytes);
    if (src == null) return null;

    final out = img.Image.from(src);
    final w = src.width;
    final h = src.height;
    final visited = List.generate(h, (_) => List<bool>.filled(w, false));
    final queue = <(int, int)>[];

    void seed(int x, int y) {
      if (visited[y][x]) return;
      visited[y][x] = true;
      queue.add((x, y));
    }

    for (var x = 0; x < w; x++) {
      seed(x, 0);
      seed(x, h - 1);
    }
    for (var y = 0; y < h; y++) {
      seed(0, y);
      seed(w - 1, y);
    }

    while (queue.isNotEmpty) {
      final (cx, cy) = queue.removeLast();
      final p = src.getPixel(cx, cy);
      out.setPixelRgba(cx, cy, p.r.toInt(), p.g.toInt(), p.b.toInt(), 0);
      for (var dy = -1; dy <= 1; dy++) {
        for (var dx = -1; dx <= 1; dx++) {
          if (dx == 0 && dy == 0) continue;
          final nx = cx + dx;
          final ny = cy + dy;
          if (nx < 0 || ny < 0 || nx >= w || ny >= h) continue;
          if (visited[ny][nx]) continue;
          final n = src.getPixel(nx, ny);
          final dist = (p.r - n.r) * (p.r - n.r) +
              (p.g - n.g) * (p.g - n.g) +
              (p.b - n.b) * (p.b - n.b);
          if (dist <= tolerance * tolerance) {
            visited[ny][nx] = true;
            queue.add((nx, ny));
          }
        }
      }
    }
    return img.encodePng(out);
  }
}
