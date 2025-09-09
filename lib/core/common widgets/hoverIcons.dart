// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../app constants/AppConstants.dart';
class HoverIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HoverIconButton({super.key, required this.icon, required this.onPressed}) ;

  @override State<HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: IconButton(
        hoverColor: Colors.transparent,
        onPressed: widget.onPressed,
        icon: Icon(
          widget.icon,
          size: 30,
          color: _isHovering
              ? AppConstants.secondaryColor
              : AppConstants.tertiaryColor,
        ),
      ),
    );
  }
}
