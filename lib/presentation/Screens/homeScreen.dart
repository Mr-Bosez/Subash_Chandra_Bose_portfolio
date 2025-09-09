import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:portfolio/core/common%20widgets/hoverIcons.dart';
import 'package:portfolio/core/common%20widgets/CircleContainer.dart';
import 'package:portfolio/data/apiCalls.dart';
import 'package:responsive_builder/responsive_builder.dart';


class HomeViewScreen extends StatelessWidget {
  HomeViewScreen({super.key});

  final apiCalls = ApiCalls();
  final ValueNotifier<bool> _isHoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return DefaultTextStyle.merge(
          style: GoogleFonts.iceberg(
            color: AppConstants.secondaryColor,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height, // ✅ full screen height
            // constraints: const BoxConstraints(minHeight: 600, maxHeight: 700),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConstants.baseColor,
              border: Border(
                top: BorderSide(color: AppConstants.tertiaryColor, width: 3),
              ),
            ),
            child: Builder(builder: (context) {
              if (sizingInformation.isDesktop || sizingInformation.isTablet) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Center( // ✅ Horizontally & vertically center the Row
                    child: Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Intro Section (vertically centered)
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInLeft(child: _buildIntroductionSection(context)),
                              ],
                            ),
                          ),

                           const SizedBox(width: 40), // space between

                          /// Rotating Image Section (vertically centered)
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildImageSection(sizingInformation),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                // ✅ Mobile Layout - Column
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIntroductionSection(context, isMobile: true),
                      const SizedBox(height: 30),
                      _buildImageSection(sizingInformation),
                    ],
                  ),
                );
              }
            }),

          ),
        );
      },
    );
  }

  /// ✅ Intro Section
  Widget _buildIntroductionSection(BuildContext context,
      {bool isMobile = false}) {
    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text("Hi , "),
        Text(
          "I am Subash Chandra Bose",
          style: TextStyle(
            color: AppConstants.secondaryColor,
            fontSize: isMobile ? 24 : 35,
            fontWeight: FontWeight.bold,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        AnimatedTextKit(
          isRepeatingAnimation: true,
          animatedTexts: [
            TypewriterAnimatedText("Flutter Mobile App Developer",
                cursor: '_',
                curve: Curves.fastEaseInToSlowEaseOut,
                speed: Duration(milliseconds: 70),
                textStyle: TextStyle(fontSize: isMobile ? 18 : null)),
            TypewriterAnimatedText("Automation & Workflow Builder",
                cursor: '_',
                curve: Curves.fastEaseInToSlowEaseOut,
                speed: Duration(milliseconds: 70),
                textStyle: TextStyle(fontSize: isMobile ? 18 : null)),
            TypewriterAnimatedText("Python Developer",
                cursor: '_',
                curve: Curves.fastEaseInToSlowEaseOut,
                speed: Duration(milliseconds: 70),
                textStyle: TextStyle(fontSize: isMobile ? 18 : null)),
            TypewriterAnimatedText("AI/ML Enthusiast / Junior AI Developer",
                cursor: '_',
                curve: Curves.fastEaseInToSlowEaseOut,
                speed: Duration(milliseconds: 70),
                textStyle: TextStyle(fontSize: isMobile ? 18 : null)),
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            HoverIconButton(
                icon: FontAwesomeIcons.linkedin,
                onPressed: () => apiCalls.linkedIn(context)),
            SizedBox(width: 15),
            HoverIconButton(
                icon: FontAwesomeIcons.github,
                onPressed: () => apiCalls.gitHub(context)),
            SizedBox(width: 15),
            HoverIconButton(
                icon: FontAwesomeIcons.whatsapp,
                onPressed: () => apiCalls.whatsApp(context)),
          ],
        ),
        SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: _isHoverNotifier,
          builder: (context, isHover, child) {
            return ElevatedButton(
              onHover: (hovering) {
                _isHoverNotifier.value = hovering;
              },
              onPressed: () => apiCalls.hireMe(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                side: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: isHover
                      ? AppConstants.secondaryColor
                      : AppConstants.tertiaryColor,
                ),
              ),
              child: Text(
                "Hire Me",
                style: TextStyle(
                  color: isHover
                      ? AppConstants.secondaryColor
                      : AppConstants.tertiaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// ✅ Image Section with Rotating Icons
  Widget _buildImageSection(SizingInformation sizingInformation) {
    double size = sizingInformation.isDesktop
        ? 400
        : (sizingInformation.isTablet ? 300 : 220);

    return SizedBox(
      height: size + 120,
      width: size + 200,
      child: Center(
        child: RotatingIcons(size: size),
      ),
    );
  }
}




/// ✅ RotatingIcons Widget (Integrated)




class RotatingIcons extends StatefulWidget {
  final double size;

  const RotatingIcons({super.key, this.size = 250});

  @override
  State<RotatingIcons> createState() => _RotatingIconsState();
}

class _RotatingIconsState extends State<RotatingIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;
  late double _baseRadius;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _baseRadius = widget.size * 0.65;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: _baseRadius,
          end: _isHovered ? _baseRadius * 0.5 : _baseRadius,
        ),
        duration: const Duration(milliseconds: 300),
        builder: (context, orbitRadius, child) {
          return AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Orbiting Icons BELOW (so they go behind center image)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double angle = _controller.value * 2 * pi;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildOrbitIcon(angle, 0, orbitRadius,
                            const Icon(FontAwesomeIcons.flutter, color: AppConstants.secondaryColor, size: 40)),
                        _buildOrbitIcon(angle, 90, orbitRadius,
                            const Icon(Icons.code, color:AppConstants.secondaryColor, size: 40)),
                        _buildOrbitIcon(angle, 180, orbitRadius,
                            const Icon(FontAwesomeIcons.android, color:AppConstants.secondaryColor, size: 40)),
                        _buildOrbitIcon(angle, 270, orbitRadius,
                            const Icon(FontAwesomeIcons.dartLang, color: AppConstants.secondaryColor, size: 40)),
                      ],
                    );
                  },
                ),

                // Center Circle (on top)
                CircleContainer(
                  color: Colors.red,
                  height: size,
                  width: size,
                ),

              ],
            ),
          );
        },
      ),
    );
  }

  ///  Orbit Icon Builder
  Widget _buildOrbitIcon(double baseAngle, double offsetDeg, double radius, Widget icon) {
    double rad = (baseAngle + offsetDeg * pi / 180);
    return Transform.translate(
      offset: Offset(radius * cos(rad), radius * sin(rad)),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 25,
        child: icon,
      ),
    );
  }





}
