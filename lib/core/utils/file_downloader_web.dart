// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadDartFile({
  required String content,
  required String fileName,
}) async {
  final blob = html.Blob([content], 'text/plain', 'native');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
}
