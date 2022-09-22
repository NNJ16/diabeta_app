import 'dart:typed_data';

import "package:flutter/material.dart";
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintLogScreen extends StatelessWidget {
  const PrintLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logbook")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return (pw.Container());
        }));
    return pdf.save();
  }
}
