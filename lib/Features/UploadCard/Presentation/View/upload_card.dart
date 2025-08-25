// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:word_2_pdf/Features/Home/Presentation/View/Widgets/home_view_body.dart';

// class UploadCard extends StatelessWidget {
//   const UploadCard({super.key, 
//     required this.onPick,
//     required this.state,
//     required this.fileName,
//   });
//   final VoidCallback onPick;
//   final ConvertState state;
//   final String? fileName;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 520),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [BoxShadow(blurRadius: 24, color: Color(0x1A000000), offset: Offset(0, 10))],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // رأس الكارت: أنيميشن تتغير حسب الحالة
//           SizedBox(
//             height: 160,
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 350),
//               switchInCurve: Curves.easeOutCubic,
//               switchOutCurve: Curves.easeInCubic,
//               child: _buildAnimatedTop(state, key: ValueKey(state)),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text('Convert Word to PDF', style: Theme.of(context).textTheme.headlineMedium),
//           const SizedBox(height: 8),
//           Text(
//             _subtitleFor(state, fileName),
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: cs.primary,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 elevation: 0,
//               ),
//               onPressed: onPick,
//               icon: const Icon(Icons.cloud_upload_rounded),
//               label: const Text('Upload Word (.docx)'),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Soft colors • Smooth animations • Easy UX',
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xFF64748B)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnimatedTop(ConvertState s, {Key? key}) {
//     switch (s) {
//       case ConvertState.idle:
//         return _LottieBox(key: key, asset: 'assets/animations/upload.json', hint: 'Ready to upload');
//       case ConvertState.picked:
//         return _LottieBox(key: key, asset: 'assets/animations/upload.json', hint: 'File selected');
//       case ConvertState.converting:
//         return _LottieBox(key: key, asset: 'assets/animations/upload.json', hint: 'Converting...');
//       case ConvertState.done:
//         return _IconBox(key: key, icon: Icons.check_circle_rounded, color: Colors.green, hint: 'Done!');
//       case ConvertState.error:
//         return _IconBox(key: key, icon: Icons.error_rounded, color: Colors.redAccent, hint: 'Error');
//     }
//   }

//   String _subtitleFor(ConvertState s, String? name) {
//     switch (s) {
//       case ConvertState.idle:
//         return 'Upload a .docx file and get a clean PDF in seconds.';
//       case ConvertState.picked:
//         return 'Selected: ${name ?? 'file.docx'}';
//       case ConvertState.converting:
//         return 'Converting your file...';
//       case ConvertState.done:
//         return 'Converted successfully (demo). PDF preview coming next.';
//       case ConvertState.error:
//         return 'Something went wrong. Please try again.';
//     }
//   }
// }

// class _LottieBox extends StatelessWidget {
//   const _LottieBox({super.key, required this.asset, required this.hint});
//   final String asset;
//   final String hint;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       key: key,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [cs.primary.withOpacity(.12), cs.primary.withOpacity(.04)],
//           begin: Alignment.topLeft, end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Lottie.asset(asset, height: 110, repeat: true),
//           const SizedBox(height: 6),
//           Text(hint, style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }

// class _IconBox extends StatelessWidget {
//   const _IconBox({super.key, required this.icon, required this.color, required this.hint});
//   final IconData icon;
//   final Color color;
//   final String hint;

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [cs.primary.withOpacity(.12), cs.primary.withOpacity(.04)],
//           begin: Alignment.topLeft, end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 68, color: color),
//           const SizedBox(height: 6),
//           Text(hint, style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }
