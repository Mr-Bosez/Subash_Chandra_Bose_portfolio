// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:portfolio/data/apiCalls.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart'; // ✅ animations

class ProjectsContainer extends StatefulWidget {
  final String imageUrl;
  final String projectTitle;
  final String projectDescription;
  final List<String> programs;
  final String githubUrl;

  const ProjectsContainer({
    super.key,
    required this.imageUrl,
    required this.projectTitle,
    required this.projectDescription,
    required this.programs,
    required this.githubUrl,
  });

  @override
  State<ProjectsContainer> createState() => _ProjectsContainerState();
}

class _ProjectsContainerState extends State<ProjectsContainer> {
  bool isFront = true;
  final controller = FlipCardController();
  final apicall=ApiCalls();

  @override
  Widget build(BuildContext context) {
      // double cardHeight = MediaQuery.of(context).size.width > 900 ? 400 :(MediaQuery.of(context).size.width > 600 ? 350 : 320); // ✅ adjust height by screen size
      double cardWidth = MediaQuery.of(context).size.width > 600 ? 320 : double.infinity;
      double screenWidth = MediaQuery.of(context).size.width;

      double cardHeight = screenWidth > 900
          ? 400 // Desktop
          : (screenWidth > 600
          ? 400 // Tablet
          : 500); // Mobile → bigger height to fit 2-line titles

      return FadeInUp( // ✅ smooth appear animation
      duration: const Duration(milliseconds: 800),
      child: FlipCard(
        controller: controller,
        animationDuration: const Duration(milliseconds: 600),
        rotateSide: isFront ? RotateSide.right : RotateSide.left,
        axis: FlipAxis.vertical,
        // 🔹 FRONT CARD
        frontWidget: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppConstants.secondaryColor, width: 2),
          ),
          child: Container(
            width: cardWidth,
            height: cardHeight, // reduced for better look
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2,color: AppConstants.secondaryColor,)),
                      errorWidget: (_, _, _) =>
                      const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppConstants.tertiaryColor,
                      borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround, // ✅ fix spacing
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: AutoSizeText(
                              widget.projectTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 22,
                              minFontSize: 16,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white)
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row( // ✅ shimmer + flip button grouped together
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: const Text(
                                  "To know more >>",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              flipButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


        // 🔹 BACK CARD
        backWidget: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: AutoSizeText(
                    maxFontSize: 22,
                    minFontSize: 12,
                    widget.projectDescription,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: widget.programs
                      .map((p) => Chip(
                    label: Text(p,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: AppConstants.secondaryColor,
                  ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        apicall.gitHubProjects(context, widget.githubUrl);
                      },
                      icon: const Icon(FontAwesomeIcons.github,
                          color: Colors.white, size: 16),
                      label: const AutoSizeText("View Project",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fixedSize: const Size(130, 36),
                          backgroundColor: AppConstants.secondaryColor),
                    ),

                    // ✅ Flip back
                    flipButton()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget flipButton() {
    return GestureDetector(
      onTap: () {
        controller.flipcard();
        setState(() => isFront = !isFront);
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 36,
        decoration: BoxDecoration(
          color: isFront
              ? AppConstants.primaryColor
              : AppConstants.secondaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 1)
          ],
        ),
        child: Text(
          "Flip me",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isFront
                  ? AppConstants.secondaryColor
                  : AppConstants.primaryColor),
        ),
      ),
    );
  }
}

