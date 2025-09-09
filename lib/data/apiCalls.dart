import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
class ApiCalls{
  // gmail hiring Function
  Future<void> hireMe(BuildContext context) async {
    final Uri gmail = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=mrbose694@gmail.com&su=Hiring Inquiry',
    );
    if (!await launchUrl(gmail,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $gmail');
    }
  }


  // linkedIn Function
  Future<void> linkedIn(BuildContext context) async {
    final Uri linkedInUrl = Uri.parse(
      'https://www.linkedin.com/in/subash-chandra-bose-s619',
    );
    if (!await launchUrl(linkedInUrl,mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $linkedInUrl');
    }
  }

  // gitHub function
  Future<void> gitHub(BuildContext context) async {
    final Uri gitHub = Uri.parse(
      'https://github.com/dashboard',
    );
    if (!await launchUrl(gitHub,mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $gitHub');
    }
  }

  // resume downloader
  Future<void> resumeDownload(BuildContext context) async {
    final cvUrl = Uri.parse('https://drive.google.com/uc?export=download&id=1AevjTDbtQ28XzfudMmDABAHbol77JsGx');
    if (!await launchUrl(cvUrl)) {
      throw Exception('Could not launch $cvUrl');
    }
  }

  // Whatsapp function
  Future<void> whatsApp(BuildContext context) async {
    final Uri whatsApp = Uri.parse(
      'https://wa.me/917598580137?text=Hi%20Subash%2C%20I%E2%80%99d%20like%20to%20discuss%20a%20project%20with%20you',
    );
    if (!await launchUrl(whatsApp,mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $whatsApp');
    }
  }





  final String _apiUrl="https://api.web3forms.com/submit";
  final String _accessKey="776f73b2-11de-44fd-8a4d-20296aed6828";
  // web3Forms
  Future<bool> submitForm({
    required String name,
    required String email,
    required String message,
   }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "access_key": _accessKey,
          "name": name,
          "email": email,
          "message": message,
        }),
      );
      // ✅ Web3Forms returns statusCode 200 when successful
      return response.statusCode == 200;
    } catch (e) {
      // print("Web3Forms error: $e");
      return false;
    }
  }

  // github projects links
  // Whatsapp function
  Future<void> gitHubProjects(BuildContext context,String url) async {
    final Uri githubprj = Uri.parse(
      url,
    );
    if (!await launchUrl(githubprj,mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $githubprj');
    }
  }
}