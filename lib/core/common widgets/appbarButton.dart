// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';

class Appbarbutton extends StatefulWidget {
  final VoidCallback scrollToSection;
  final String name;
  const Appbarbutton({super.key,required this.scrollToSection,required this.name});

  @override
  State<Appbarbutton> createState() => _AppbarbuttonState();
}

class _AppbarbuttonState extends State<Appbarbutton> {
  bool isHover=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onHover: (hovering){
          setState(() {
            isHover=hovering;
          });
        },
        onPressed: () {
          widget.scrollToSection();
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // remove default padding if you want tight border
        ),
        child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:isHover? AppConstants.baseColor: Colors.transparent,  // bottom border color
                width: 2.0,         // bottom border thickness
              ),
            ),
          ),
          child: Text(
            widget.name,
            style: const TextStyle(
              color: AppConstants.baseColor,
              fontSize: 16,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
