import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:portfolio/data/apiCalls.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:animate_do/animate_do.dart';

class AboutMeScreen extends StatefulWidget {
  final VoidCallback? scrollToContact;
  AboutMeScreen({super.key, this.scrollToContact});
  final apiCall = ApiCalls();

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  bool _isVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-me-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        height: 750,
        width: double.infinity,
        color: AppConstants.tertiaryColor,
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isDesktop) {
              return _buildDesktopLayout(context);
            } else if (sizingInformation.isTablet) {
              return _buildTabletLayout(context);
            }
            return _buildMobileLayout(context);
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Center(
            child: Text(
              "About ME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                wordSpacing: 2,
                shadows: [
                  Shadow(
                      color: AppConstants.baseColor,
                      offset: const Offset(2, 2),
                      blurRadius: 2),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lottie animation - no animation added here for fade
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Lottie.asset(
                      "assets/animations/GDSC Modules.json",
                      fit: BoxFit.contain,
                      height: 600,
                    ),
                  ),
                ),

                // Animated text only
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: _isVisible
                        ? FadeInRight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: _about(context)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _button("Download CV",
                                  onPressed: () =>
                                      widget.apiCall.resumeDownload(context)),
                              const SizedBox(width: 20),
                              _button("Contact Me",
                                  onPressed: widget.scrollToContact),
                            ],
                          ),
                        ],
                      ),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: _about(context)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _button("Download CV",
                                onPressed: () =>
                                    widget.apiCall.resumeDownload(context)),
                            const SizedBox(width: 20),
                            _button("Contact Me",
                                onPressed: widget.scrollToContact),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // For tablet and mobile you can do similarly — wrap the text area in FadeInLeft depending on _isVisible

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About ME",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              shadows: [
                Shadow(
                    color: AppConstants.baseColor,
                    offset: const Offset(2, 2),
                    blurRadius: 2),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Lottie.asset(
            "assets/animations/GDSC Modules.json",
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          _isVisible
              ? FadeInRight(child: _about(context, isMobile: true))
              : _about(context, isMobile: true),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button("Download CV",
                  onPressed: () => widget.apiCall.resumeDownload(context)),
              const SizedBox(width: 20),
              _button("Contact Me", onPressed: widget.scrollToContact),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "About ME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                shadows: [
                  Shadow(
                      color: AppConstants.baseColor,
                      offset: const Offset(2, 2),
                      blurRadius: 2),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Lottie.asset(
              "assets/animations/GDSC Modules.json",
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            _isVisible
                ? FadeInRight(child: _about(context, isMobile: true))
                : _about(context, isMobile: true),
            const SizedBox(height: 5),
            Column(
              children: [
                _button("Download CV",
                    onPressed: () => widget.apiCall.resumeDownload(context)),
                const SizedBox(height: 15),
                _button("Contact Me", onPressed: widget.scrollToContact),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// keep your _about and _button functions unchanged

Widget _about(BuildContext context, {bool isMobile = false}) {
  return RichText(
    softWrap: true,
    textAlign: isMobile ? TextAlign.center : TextAlign.start,
    text: TextSpan(
      style: DefaultTextStyle.of(context).style.copyWith(
        fontSize: isMobile ? 16 : 20,
        height: 1.5,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: "I’m "),
        TextSpan(
          text: "Subash Chandra Bose\n",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 20,
            color: AppConstants.baseColor,
          ),
        ),
        TextSpan(
          text: "Flutter Mobile application Developer | N8N Automations | AI models\n",
          style: TextStyle(fontWeight: FontWeight.w600, color: AppConstants.baseColor, fontSize: isMobile ? 14 : 16),
        ),
        TextSpan(
          text: "A final-year B.Tech Computer Science (AIML) student at ",
        ),
        TextSpan(
          text: "Kalasalingam Academy of Research and Education",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppConstants.baseColor,
          ),
        ),
        TextSpan(text: ", based in "),
        TextSpan(
          text: "Tirunelveli, India.\n\n",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppConstants.baseColor,
          ),
        ),
        TextSpan(
          text: "I’m passionate about building cross-platform apps with ",
        ),
        TextSpan(
          text: "Flutter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextSpan(text: ", developing "),
        TextSpan(
          text: "AI models",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextSpan(text: ", and creating intelligent automations with "),
        TextSpan(
          text: "n8n",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextSpan(
          text: ". With a strong interest in blending mobile development, AI, and workflow automation, I strive to craft solutions that are both ",
        ),
        TextSpan(
          text: "innovative",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstants.baseColor,
          ),
        ),
        TextSpan(text: " and "),
        TextSpan(
          text: "impactful.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstants.baseColor,
          ),
        ),
        TextSpan(
          text: "\nMail ID : mrbose694@gmail.com\n Ph no : 9345401456",
          style: TextStyle(
            color: AppConstants.baseColor,
            fontSize: isMobile ? 14 : null,
          ),
        ),
      ],
    ),
  );
}

Widget _button(String text, {VoidCallback? onPressed}) {
  return ElevatedButton(
    onPressed: onPressed ?? () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: AppConstants.baseColor,
      side: BorderSide(
        style: BorderStyle.solid,
        width: 2,
        color: AppConstants.secondaryColor,
      ),
    ),
    child: Text(text, style: TextStyle(color: AppConstants.secondaryColor)),
  );
}
