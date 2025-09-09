import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:portfolio/presentation/Screens/contactMe.dart';
import 'package:portfolio/presentation/Screens/experience.dart';
import 'package:portfolio/presentation/Screens/homeScreen.dart';
import 'package:portfolio/presentation/Screens/skills.dart';
import 'package:portfolio/presentation/Screens/projects.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/common widgets/appbarButton.dart';
import 'aboutMe.dart';
import 'footer.dart';

class TotalViewScreen extends StatefulWidget {
  const TotalViewScreen({super.key});

  @override
  State<TotalViewScreen> createState() => _HomepageState();
}

class _HomepageState extends State<TotalViewScreen> {
  final ScrollController _scrollController = ScrollController();
  // Keys for sections
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return AppBar(
              iconTheme: IconThemeData(color: AppConstants.baseColor),
              title: Text(
                "Subash Chandra Bose",
                style: TextStyle(color: AppConstants.baseColor),
              ),
              backgroundColor: AppConstants.secondaryColor,
              actions: sizingInformation.isDesktop
                  ? [
                Appbarbutton(scrollToSection: () => _scrollToSection(_homeKey), name: "Home"),
                Appbarbutton(scrollToSection: () => _scrollToSection(_aboutKey), name: "About"),
                Appbarbutton(scrollToSection: () => _scrollToSection(_projectsKey), name: "Projects"),
                Appbarbutton(scrollToSection: () => _scrollToSection(_skillsKey), name: "Skills"),
                Appbarbutton(scrollToSection: () => _scrollToSection(_contactKey), name: "Contact"),
              ]
                  : null, // Actions are null on smaller screens
              actionsPadding: EdgeInsets.symmetric(horizontal: sizingInformation.isDesktop ? 200 : 0),
            );
          },
        ),
      ),
      drawer: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isDesktop) {
            return const SizedBox.shrink();
          }
          return Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppConstants.secondaryColor, AppConstants.baseColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.9],
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    curve: Curves.bounceInOut,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Navigation",
                        style: TextStyle(
                          color: AppConstants.baseColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      _scrollToSection(_homeKey);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () {
                      _scrollToSection(_aboutKey);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Projects'),
                    onTap: () {
                      _scrollToSection(_projectsKey);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Skills'),
                    onTap: () {
                      _scrollToSection(_skillsKey);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Contact'),
                    onTap: () {
                      _scrollToSection(_contactKey);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        dragStartBehavior: DragStartBehavior.start,
        child: Column(
          children: [
            Container(key: _homeKey, child: HomeViewScreen()),
            Container(key: _aboutKey, child: AboutMeScreen(scrollToContact: () => _scrollToSection(_contactKey),)),
            Container(key: _projectsKey, child: ProjectsScreen()),
            Container(key: _skillsKey, child: SkillsScreen()),
            Container(key: _experienceKey, child: ExperienceScreen()),
            Container(key: _contactKey, child: ContactScreen()),
            const Footer(),
          ],
        ),
      ),
    );
  }
}