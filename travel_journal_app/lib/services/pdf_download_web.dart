import 'dart:html' as html;
import 'dart:typed_data';

Future<void> savePdfBytes(Uint8List bytes, String filename) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  try {
    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
  } finally {
    html.Url.revokeObjectUrl(url);
  }
}
