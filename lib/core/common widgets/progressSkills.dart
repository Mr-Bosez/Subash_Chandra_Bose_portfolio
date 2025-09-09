

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ProgressSkills extends StatelessWidget {
  const ProgressSkills({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidCircularProgressIndicator(
      value: 0.25, // Defaults to 0.5.
      valueColor: AlwaysStoppedAnimation(Colors.pink), // Defaults to the current Theme's accentColor.
      backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
      borderColor: Colors.red,
      borderWidth: 5.0,
      direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
      center: Text("Loading..."),
    );
  }
}

// Skill Circle Widget
// Widget _skillCircle(Map<String, dynamic> skill) {
//   return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: SizedBox(
//         height: 100,
//         width: 100,
//         child: ClipOval(
//           child: LiquidCircularProgressIndicator(
//             value: skill["value"],
//             valueColor: AlwaysStoppedAnimation(skill["color"]),
//             backgroundColor: Colors.black,
//             borderColor: Colors.greenAccent,
//             borderWidth: 2,
//             direction: Axis.vertical,
//             center: Text(
//               skill["name"],
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ));
// }

