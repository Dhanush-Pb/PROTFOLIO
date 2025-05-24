import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/about/aboutpage.dart';
import 'package:portfolio/about/space_nuro.dart';
import 'package:portfolio/baground_/baground.dart';
import 'package:portfolio/hero_section/hero_section.dart';
import 'package:portfolio/projects/project_section_.dart';

import 'package:portfolio/prot_content/proftoiosecon.dart';
import 'package:portfolio/navbar_/advanced_nav_.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhanush PB | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late AnimationController _particleController;

  int _currentSection = 0;
  bool _showBottomBar = false;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final maxScroll = _scrollController.position.maxScrollExtent;

      setState(() {
        _currentSection = (offset / (maxScroll / 4)).floor().clamp(0, 3);
        _showBottomBar = offset > 100;
      });
    });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    _particleController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollTo(int section) {
    final offset = section * MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBackground(
            particleController: _particleController,
            rotationController: _rotationController,
          ),

          // Main Content
          Column(
            children: [
              // Top Navigation
              AdvancedNavbar(
                scrollController: _scrollController,
                currentSection: _currentSection,
                onSectionTap: scrollTo,
              ),

              // Content Sections
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HeroSection(floatingController: _floatingController),
                      const AboutSection(),
                      const ProjectsSection(),
                      const SpaceNeuralNetworkBackground(),
                      const ContactSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Bottom Navigation
          if (_showBottomBar)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FloatingBottomBar(
                currentSection: _currentSection,
                onSectionTap: scrollTo,
              ),
            ),
        ],
      ),
    );
  }
}
