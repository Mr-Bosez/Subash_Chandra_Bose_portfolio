import 'package:flutter/material.dart';
import 'package:liquid_loader/liquid_loader.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:visibility_detector/visibility_detector.dart';


class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsState();
}

class _SkillsState extends State<SkillsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Map<String, dynamic>> skills = const [
    {"name": "Flutter", "value": 0.9, "color": AppConstants.secondaryColor},
    {"name": "Dart", "value": 0.85, "color": AppConstants.secondaryColor},
    {"name": "Firebase", "value": 0.75, "color": AppConstants.secondaryColor},
    {"name": "Python", "value": 0.7, "color": AppConstants.secondaryColor},
    {"name": "Java", "value": 0.6, "color": AppConstants.secondaryColor},
    {"name": "N8N", "value": 0.7, "color": AppConstants.secondaryColor},
    {"name": "MongoDB", "value": 0.65, "color": AppConstants.secondaryColor},
    {"name": "SQL", "value": 0.85, "color": AppConstants.secondaryColor},
    {"name": "GitHub", "value": 0.8, "color": AppConstants.secondaryColor},
    {"name": "Postman", "value": 0.9, "color": AppConstants.secondaryColor},
    {"name": "CI/CD", "value": 0.6, "color": AppConstants.secondaryColor},
    {"name": "DL", "value": 0.6, "color": AppConstants.secondaryColor},
    {"name": "ML", "value": 0.5, "color": AppConstants.secondaryColor},
    {"name": "Git", "value": 0.8, "color": AppConstants.secondaryColor},
    {"name": "REST APIs", "value": 0.9, "color": AppConstants.secondaryColor},
    {"name": "Cloudinary", "value": 0.6, "color": AppConstants.secondaryColor},
    {"name": "Supabase", "value": 0.6, "color": AppConstants.secondaryColor},
    {"name": "Figma", "value": 0.5, "color": AppConstants.secondaryColor},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("Skills-section"),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.5) {
          if (!_controller.isAnimating && _controller.value == 0.0) {
            _controller.forward();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(50),
        width: double.infinity,
        color: AppConstants.baseColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Skills & Tools",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.secondaryColor,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 20.0,
                children: skills.map((skill) => _skillCircle(skill)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // No longer need separate desktop and mobile layouts since Wrap handles responsiveness.
  Widget _skillCircle(Map<String, dynamic> skill) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = skill['value'] * _controller.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: LiquidLoader(
            width: 100,
            height: 100,
            liquidColor: skill['color'],
            borderColor: AppConstants.secondaryColor,
            capColor: AppConstants.secondaryColor,
            liquidLevel: progress,
            text: skill['name'],
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            shape: Shape.circle,
            hideCap: false,
          ),
        );
      },
    );
  }
}
