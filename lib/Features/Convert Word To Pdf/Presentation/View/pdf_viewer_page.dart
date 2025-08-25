import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

const String API_BASE = 'http://127.0.0.1:5000';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key, required String path});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  bool loading = false;
  String statusText = 'Upload a Word file to convert it into PDF';

  Future<void> _pickAndConvert() async {
    try {
      final res = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['docx', 'doc', 'rtf', 'odt'],
        withData: true,       
        withReadStream: true, 
      );
      if (res == null) return;

      final f = res.files.single;

   
      File? localFile;
      if (f.path != null) {
        localFile = File(f.path!);
      } else if (f.bytes != null) {
        final tmpDir = await getTemporaryDirectory();
        final ext = (f.extension?.isNotEmpty ?? false) ? '.${f.extension}' : '';
        final tmpPath =
            '${tmpDir.path}/picked_${DateTime.now().millisecondsSinceEpoch}$ext';
        final tmp = File(tmpPath);
        await tmp.writeAsBytes(f.bytes!);
        localFile = tmp;
      } else {
        throw Exception('Cannot read picked file (no path nor bytes)');
      }

      setState(() {
        loading = true;
        statusText = 'Uploading & converting...';
      });

     
      final uri = Uri.parse('$API_BASE/convert');
      final req = http.MultipartRequest('POST', uri);

      if (f.readStream != null && f.size != null) {
        req.files.add(http.MultipartFile(
          'file',
          f.readStream!,
          f.size!,
          filename: f.name,
        ));
      } else {
        req.files.add(await http.MultipartFile.fromPath('file', localFile.path));
      }

      final resp = await req.send();

      if (resp.statusCode != 200) {
        final err = await resp.stream.bytesToString();
        throw Exception('Server ${resp.statusCode}: $err');
      }

      final bytes = await resp.stream.toBytes();
      if (bytes.isEmpty) throw Exception('Empty PDF response');

      
      final docs = await getApplicationDocumentsDirectory();
      final outPath =
          '${docs.path}/converted_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final outFile = File(outPath);
      await outFile.writeAsBytes(bytes);

      setState(() {
        loading = false;
        statusText = 'Converted! Saved at:\n$outPath';
      });

      
      final r = await OpenFilex.open(outPath);
      if (r.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved but no viewer found. Path: $outPath')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
          statusText = 'Error: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Word → PDF')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.picture_as_pdf_rounded, size: 64, color: cs.primary),
              const SizedBox(height: 12),
              Text(
                statusText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: loading ? null : _pickAndConvert,
                icon: const Icon(Icons.cloud_upload_rounded),
                label: Text(loading ? 'Converting...' : 'Upload Word (.docx)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
