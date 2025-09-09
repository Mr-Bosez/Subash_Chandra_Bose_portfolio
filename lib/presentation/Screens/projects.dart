import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/common widgets/projectsContainer.dart';


class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  bool _isVisible = false;

  final List<ProjectsContainer> projects = [
    ProjectsContainer(
      imageUrl: "https://res.cloudinary.com/dezwo04ym/image/upload/v1756891496/combined_1_gf7lth.png",
      projectTitle: 'Modern e-commerce platform for intuitive shopping.',
      projectDescription:
      "ShopSwift is a fully functional e-commerce application built with a robust admin and user system. It includes authentication, product management, and secure checkout. Admins can add/manage products with all data synced via Firebase Firestore.",
      programs: ["Flutter", "Dart", "Firebase", "Riverpod", "REST API"],
      githubUrl: 'https://github.com/Mr-Bosez/Android_App_Developmet_Intern_NativeSoftTech/tree/2e169903d447c91b128435386ccb5232ef5a41fa/e_commerce',
    ),
    ProjectsContainer(
      imageUrl: "https://res.cloudinary.com/dezwo04ym/image/upload/v1756891496/combined_6_ombcn4.png",
      projectTitle: 'Accurate weather forecasts at a glance.',
      projectDescription:
      'SkyCast is a weather app built using BLoC + MVVM. Integrates AirVisual & OpenWeatherMap APIs for real-time + 7-day forecasts. Google authentication supported, clean responsive UI.',
      programs: ["Flutter", "Dart", "Bloc", "REST API", "Google Auth"],
      githubUrl: 'https://github.com/Mr-Bosez/Android_App_Developmet_Intern_NativeSoftTech/tree/2e169903d447c91b128435386ccb5232ef5a41fa/weather_application',
    ),
    ProjectsContainer(
      imageUrl: "https://res.cloudinary.com/dezwo04ym/image/upload/v1756891496/combined_4_dtnlg6.png",
      projectTitle: 'Track tasks and boost productivity',
      projectDescription:
      'To-do app with CRUD functionality using SQLite for offline access. Clean UI, responsive design, and smooth UX for productivity tracking.',
      programs: ["Flutter", "Dart", "SQLite", "CRUD", "Provider"],
      githubUrl: 'https://github.com/Mr-Bosez/Android_App_Developmet_Intern_NativeSoftTech/tree/2e169903d447c91b128435386ccb5232ef5a41fa/todo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.4 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          children: [
            const Text("Projects",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
            const Text("Some of my recent works !",
                style: TextStyle(color: Colors.grey, fontSize: 18)),
            const SizedBox(height: 20),
            ScreenTypeLayout.builder(
              mobile: (_) => buildGrid(1),
              tablet: (_) => buildGrid(2),
              desktop: (_) => buildGrid(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (_, index) {
        return _isVisible
            ? BounceInDown(
          delay: Duration(milliseconds: index * 150),
          child: Material(
            type: MaterialType.transparency,
            child: projects[index],
          ),
        )
            : const SizedBox(); // Empty widget if not visible yet
      },
    );
  }
}


