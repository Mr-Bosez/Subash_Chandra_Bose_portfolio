import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        final horizontalPadding = isMobile ? 10.0 : 20.0;
        final verticalPadding = isMobile ? 10.0 : 10.0;
        final fontSize = isMobile ? 12.0 : 14.0;
        final mainAxisAlignment = isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly;
        final crossAxisAlignment = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
        final footerHeight = isMobile ? 100.0 : 50.0;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          color: Colors.grey,
          width: double.infinity,
          height: footerHeight,
          child: isMobile
              ? Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Text(
                "© 2025. All Rights Reserved",
                style: TextStyle(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              Text(
                "Designed and Built by Subash Chandra Bose",
                style: TextStyle(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
              Text(
                "Crafted with Flutter ❤️",
                style: TextStyle(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ],
          )
              : Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 20,
          runSpacing: 5,
          children: [
            Text(
              "© 2025. All Rights Reserved",
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              "Designed and Built by Subash Chandra Bose",
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              "Crafted with Flutter ❤️",
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
        );
      },
    );
  }
}