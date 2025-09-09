import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/core/app%20constants/AppConstants.dart';
import 'package:portfolio/data/apiCalls.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../application/contactNotifier.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactState();
}

class _ContactState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final apiCall = ApiCalls();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final screenWidth = sizingInformation.screenSize.width;
        final isMobile = sizingInformation.isMobile;
        final horizontalPadding = isMobile ? 20.0 : 40.0;
        final verticalPadding = isMobile ? 20.0 : 40.0;
        final lottieWidth = screenWidth > 1200 ? 500.0 : (screenWidth / 2);

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            color: AppConstants.primaryColor,
            width: double.infinity,
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.iceberg(),
                    children: [
                      TextSpan(
                        text: "Let's Discuss Your ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isMobile ? 28 : 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Project\n",
                        style: TextStyle(
                          color: AppConstants.secondaryColor,
                          fontSize: isMobile ? 28 : 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 5 : 10),
                Text(
                  "Got an idea? 💡 Let’s make it real. Whether it’s an app, a design, or a fresh concept,\n I’d love to bring it to life. Drop me a message and let’s start building together!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppConstants.secondaryColor, fontSize: isMobile ? 14 : 18),
                ),
                const SizedBox(height: 30),
                if (sizingInformation.isMobile)
                  _buildMobileLayout(lottieWidth)
                else
                  _buildDesktopLayout(lottieWidth),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(double lottieWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: Container(
          constraints: BoxConstraints(maxWidth: 800),
            child: contactForm())),
        SizedBox(width: 20),
        SizedBox(
          width: lottieWidth,
          child: Lottie.network(
            "https://lottie.host/7086297b-b3bf-460c-aabf-6f80bdbd973f/l7oBune9JU.json",
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double lottieWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        contactForm(),
        SizedBox(height: 20),
        SizedBox(
          width: lottieWidth,
          child: Lottie.network(
            width: double.infinity,
            "https://lottie.host/7086297b-b3bf-460c-aabf-6f80bdbd973f/l7oBune9JU.json",
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }

  Widget contactForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Contact Me ✏️ ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty ? "Enter first name" : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty ? "Enter last name" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter your email";
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Leave your message here",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? "Enter your message" : null,
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final contactState = ref.watch(contactProvider);

                contactState.whenOrNull(
                  data: (success) {
                    if (success) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            width: 400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppConstants.secondaryColor, width: 2),
                            ),
                            content: const Text(
                              "Message sent successfully ✅",
                              style: TextStyle(color: AppConstants.secondaryColor),
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: AppConstants.primaryColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        _formKey.currentState?.reset();
                        for (final controller in [
                          _firstNameController,
                          _lastNameController,
                          _emailController,
                          _messageController
                        ]) {
                          controller.clear();
                        }
                      });
                    }
                  },
                  error: (error, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          width: 400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: AppConstants.secondaryColor, width: 2),
                          ),
                          content: Text(
                            "Error: ${error.toString()}",
                            style: TextStyle(color: AppConstants.secondaryColor),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    });
                  },
                );

                return ElevatedButton(
                  onPressed: contactState.isLoading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(contactProvider.notifier).submitForm(
                        name: "${_firstNameController.text} ${_lastNameController.text}",
                        email: _emailController.text,
                        message: _messageController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: contactState.hasError ? Colors.red : AppConstants.secondaryColor,
                  ),
                  child: contactState.isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppConstants.secondaryColor,
                    ),
                  )
                      : Text(
                    contactState.hasError ? "Retry" : "Submit Message",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}