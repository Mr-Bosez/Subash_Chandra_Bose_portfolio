import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/app constants/AppConstants.dart';


class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool mouseEntered = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        final horizontalPadding = isMobile ? 20.0 : 40.0;
        final verticalPadding = isMobile ? 20.0 : 40.0;
        final titleFontSize = isMobile ? 28.0 : 35.0;
        final expPadding = isMobile ? 15.0 : 20.0;

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            width: double.infinity,
            color: AppConstants.baseColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Experience",
                  style: TextStyle(
                    color: AppConstants.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 40),
                _expContainer(isMobile, expPadding),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _expContainer(bool isMobile, double padding) {
    // Only use MouseRegion for desktop to enable hover effects
    final expCard = Container(
      padding: EdgeInsets.all(padding),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: mouseEntered ? AppConstants.secondaryColor : Colors.transparent,
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppConstants.tertiaryColor, width: 2, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20.0, // horizontal spacing
            runSpacing: 5.0, // vertical spacing when wrapped
            children: [
              Text(
                "Mobile App Development Intern",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 16 : 20,
                ),
              ),
              Text(
                "NativeSoftTech [ May-Jul 2025 ]",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 16 : 20,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 5 : 10),
          Text(
            "Developed mobile applications (To-Do, E-Commerce, Weather) using Flutter, integrating RESTful APIs and Firebase for real-time functionality. Implemented state management with Riverpod/Bloc and built responsive, cross-platform UIs for scalable app architecture.",
            style: TextStyle(color: Colors.black, fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );

    // Only wrap with MouseRegion on non-mobile devices
    if (!isMobile) {
      return MouseRegion(
        onHover: (_) {
          setState(() {
            mouseEntered = true;
          });
        },
        onExit: (_) {
          setState(() {
            mouseEntered = false;
          });
        },
        child: expCard,
      );
    }
    return expCard;
  }
}