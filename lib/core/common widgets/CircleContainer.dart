
import 'package:flutter/material.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';

class CircleContainer extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const CircleContainer({
    super.key,
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  State<CircleContainer> createState() => _CircleContainerState();
}

class _CircleContainerState extends State<CircleContainer>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppConstants.secondaryColor, AppConstants.baseColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.9],
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor,
            blurRadius: 15,
            spreadRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child:CircleAvatar(
          radius: widget.width*0.45,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/AdobeStock_76695594-1024x683-removebg-preview.png"),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:portfolio/core/app%20constants/AppConstants.dart';
//
// class CircleContainer extends StatefulWidget {
//   final double width;
//   final double height;
//   final Color color;
//
//   const CircleContainer({
//     super.key,
//     required this.color,
//     required this.height,
//     required this.width,
//   });
//
//   @override
//   State<CircleContainer> createState() => _CircleContainerState();
// }
//
// class _CircleContainerState extends State<CircleContainer>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => _controller.forward(),
//       onExit: (_) => _controller.reverse(),
//       child: ScaleTransition(
//         scale: _animation,
//         child: Container(
//           width: widget.width,
//           height: widget.height,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: LinearGradient(
//               colors: [AppConstants.secondaryColor, AppConstants.baseColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               stops: [0.1, 0.9],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppConstants.primaryColor.withOpacity(0.7),
//                 blurRadius: 15,
//                 spreadRadius: 6,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//           ),
//           child: Center(
//             child:CircleAvatar(
//               radius: widget.width*0.45,
//               backgroundColor: Colors.transparent,
//               backgroundImage: AssetImage("assets/AdobeStock_76695594-1024x683-removebg-preview.png"),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
