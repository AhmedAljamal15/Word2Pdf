import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// لو بتستخدم USB + adb reverse: خلّيها 127.0.0.1
/// لو شبكة Wi-Fi: استخدم IP الكمبيوتر (مثال: 192.168.1.11)
const String kApiBase = 'https://word2pdf-production-5dc8.up.railway.app';

class ConvertApi {
  static Future<String> convertFromMultipart(http.MultipartFile file) async {
    final uri = Uri.parse('$kApiBase/convert');
    final req = http.MultipartRequest('POST', uri)..files.add(file);
    final resp = await req.send();

    if (resp.statusCode != 200) {
      final err = await resp.stream.bytesToString();
      throw Exception('Server ${resp.statusCode}: $err');
    }
    final bytes = await resp.stream.toBytes();
    if (bytes.isEmpty) throw Exception('Empty PDF response');

    final dir = await getApplicationDocumentsDirectory();
    final out = '${dir.path}/converted_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final f = File(out);
    await f.writeAsBytes(bytes);

    await _pushToHistory(out);
    return out;
  }

  static Future<void> _pushToHistory(String path) async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList('history') ?? <String>[];
    list.insert(0, path); // الأحدث أولاً
    // خلي السجل آخر 20 ملف بس
    if (list.length > 20) list.removeRange(20, list.length);
    await sp.setStringList('history', list);
  }

  static Future<List<String>> loadHistory() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList('history') ?? <String>[];
  }

  static Future<void> clearHistory() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('history');
  }
}
