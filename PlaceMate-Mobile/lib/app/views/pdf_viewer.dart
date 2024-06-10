import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfPdfViewer.network(path),
      ),
    );
  }
}
