import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

// لو عندك الصفحات دي فعلاً:
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:word_2_pdf/Features/Convert%20Word%20To%20Pdf/Presentation/View/history_page.dart';
import 'package:word_2_pdf/Features/Convert%20Word%20To%20Pdf/Presentation/View/pdf_viewer_page.dart';
import 'package:word_2_pdf/core/Services/api.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  String? lastPdfPath;
  String status = 'Upload a Word file (.docx) to convert it into PDF';

  Future<void> pickAndConvert(BuildContext context) async {
    try {
      final res = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['docx','doc','rtf','odt'],
        withReadStream: true,
        withData: true,
      );
      if (res == null) return;
      final f = res.files.single;

      setState(() {
        loading = true;
        status = 'Uploading & converting...';
      });

      http.MultipartFile multipart;
      if (f.readStream != null && f.size != null) {
        multipart = http.MultipartFile('file', f.readStream!, f.size!, filename: f.name);
      } else if (f.bytes != null) {
        multipart = http.MultipartFile.fromBytes('file', f.bytes!, filename: f.name);
      } else if (f.path != null) {
        multipart = await http.MultipartFile.fromPath('file', f.path!);
      } else {
        throw Exception('No stream/bytes/path available');
      }

      final savedPath = await ConvertApi.convertFromMultipart(multipart);

      if (!mounted) return;
      setState(() {
        lastPdfPath = savedPath;
        status = 'Converted! Saved at:\n$savedPath';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Converted and saved: $savedPath')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => status = 'Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word → PDF'),
        actions: [
          IconButton(
            tooltip: 'History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryPage()),
              );
            },
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 560),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 24,
                color: Color(0x1A000000),
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/animations/upload.json",),
              // Icon(Icons.picture_as_pdf_rounded, size: 64, color: cs.primary),
              const SizedBox(height: 10),
              Text(
                'Convert Word to PDF',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(status, textAlign: TextAlign.center),
              const SizedBox(height: 16),

              
              ElevatedButton.icon(
                onPressed: loading ? null : () => pickAndConvert(context),
                icon: const Icon(Icons.cloud_upload_rounded),
                label: Text(loading ? 'Converting...' : 'Upload Word (.docx)'),
              ),

              if (lastPdfPath != null) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final r = await OpenFilex.open(lastPdfPath!);
                        if (r.type != ResultType.done && mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PdfViewerPage(path: lastPdfPath!),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text('Open'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PdfViewerPage(path: lastPdfPath!),
                          ),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf_rounded),
                      label: const Text('Preview in-app'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Share / History'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
