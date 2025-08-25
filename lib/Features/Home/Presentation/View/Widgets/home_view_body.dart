// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:word_2_pdf/Features/UploadCard/Presentation/View/upload_card.dart';


// enum ConvertState { idle, picked, converting, done, error }


// class HomePageBody extends StatefulWidget {
//   const HomePageBody({super.key});

//   @override
//   State<HomePageBody> createState() => _HomePageBodyState();
// }

// class _HomePageBodyState extends State<HomePageBody> with TickerProviderStateMixin {
//   late final AnimationController _cardCtrl;
//   late final Animation<Offset> _slide;
//   late final Animation<double> _fade;
//   bool _pressing = false; 
//   ConvertState _state = ConvertState.idle;
//   String? _pickedFileName;
//   @override

//   void initState() {
//     super.initState();
//     _cardCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
//     _slide = Tween(begin: const Offset(0, 0.06), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic));
//     _fade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOut);
//     _cardCtrl.forward();
//   }

//   @override
//   void dispose() {
//     _cardCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickFile() async {
//     try {
//       final res = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['docx', 'doc'],
//       );
//       if (res == null || res.files.single.path == null) return;
//       final file = File(res.files.single.path!);
//       setState(() {
//         _pickedFileName = file.path.split(Platform.pathSeparator).last;
//         _state = ConvertState.picked;
//       });

//       // لسه ما فيش تحويل حقيقي — هنحاكي تقدّم بسيط
//       await Future.delayed(const Duration(milliseconds: 500));
//       setState(() => _state = ConvertState.converting);

//       await Future.delayed(const Duration(seconds: 2)); // محاكاة تحويل
//       setState(() => _state = ConvertState.done);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File converted (demo)! PDF preview coming soon')),
//         );
//       }
//     } catch (e) {
//       setState(() => _state = ConvertState.error);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }


// @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Scaffold(
//       appBar: AppBar(title: const Text('Word → PDF')),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: SlideTransition(
//               position: _slide,
//               child: FadeTransition(
//                 opacity: _fade,
//                 child: UploadCard(
//                   state: _state,
//                   fileName: _pickedFileName,
//                   onPick: _pickFile,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: Listener(
//         onPointerDown: (_) => setState(() => _pressing = true),
//         onPointerUp: (_) => setState(() => _pressing = false),
//         child: AnimatedScale(
//           scale: _pressing ? 0.95 : 1.0,
//           duration: const Duration(milliseconds: 120),
//           curve: Curves.easeOut,
//           child: FloatingActionButton.extended(
//             backgroundColor: cs.primary,
//             foregroundColor: Colors.white,
//             onPressed: _pickFile,
//             icon: const Icon(Icons.upload_file_rounded),
//             label: const Text('Choose Word file'),
//           ),
//         ),
//       ),
//     );
//   }
// }

//    void onPickTap(BuildContext context) {
//     // هنا لاحقًا هنضيف منطق اختيار الملف والتحويل
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Pick a .docx file (logic coming next step)')),
//     );
//   }



 


