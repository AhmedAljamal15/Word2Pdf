import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_2_pdf/Features/Home/Presentation/View/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) 
    {
      return const Word2PdfApp();
    },),
  );
}

class Word2PdfApp extends StatelessWidget {
  const Word2PdfApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF4F46E5); 
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Word → PDF',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
        ).copyWith(surface: const Color(0xFFF6F7FB)),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      home: const HomePage(),
    );
  }
}
