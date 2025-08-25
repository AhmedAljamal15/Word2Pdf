import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:word_2_pdf/core/Services/api.dart';
import 'pdf_viewer_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await ConvertApi.loadHistory();
    setState(() => items = list);
  }

  Future<void> _clear() async {
    await ConvertApi.clearHistory();
    setState(() => items = []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converted Files'),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              tooltip: 'Clear history',
              onPressed: _clear,
              icon: const Icon(Icons.delete_sweep_rounded),
            ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('No files yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemBuilder: (_, i) {
                final p = items[i];
                final name = p.split(Platform.pathSeparator).last;
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf_rounded),
                  title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(p, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PdfViewerPage(path: p)));
                  },
                  trailing: Wrap(spacing: 4, children: [
                    IconButton(
                      tooltip: 'Open',
                      onPressed: () => OpenFilex.open(p),
                      icon: const Icon(Icons.open_in_new_rounded),
                    ),
                    IconButton(
                      tooltip: 'Share',
                      onPressed: () => Share.shareXFiles([XFile(p)], text: 'Converted PDF'),
                      icon: const Icon(Icons.share_rounded),
                    ),
                  ]),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: items.length,
            ),
    );
  }
}
