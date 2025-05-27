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
import 'package:portfolio/splash_scren.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
    // Lock orientation to portrait for mobile devices
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhanush | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const SplashScren(),
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

  // Global keys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _spaceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    setState(() {
      _showBottomBar = offset > 100;
      _currentSection = _getCurrentSection(offset);
    });
  }

  int _getCurrentSection(double offset) {
    // Get section positions
    final heroPosition = _getSectionPosition(_heroKey);
    final aboutPosition = _getSectionPosition(_aboutKey);
    final projectsPosition = _getSectionPosition(_projectsKey);
    final spacePosition = _getSectionPosition(_spaceKey);
    final contactPosition = _getSectionPosition(_contactKey);

    // Add some buffer for better section detection
    final buffer = MediaQuery.of(context).size.height * 0.3;

    if (offset < aboutPosition - buffer) {
      return 0; // Hero section
    } else if (offset < projectsPosition - buffer) {
      return 1; // About section
    } else if (offset < spacePosition - buffer) {
      return 2; // Projects section
    } else if (offset < contactPosition - buffer) {
      return 3; // Space section
    } else {
      return 4; // Contact section
    }
  }

  double _getSectionPosition(GlobalKey key) {
    if (key.currentContext != null) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      return position.dy + _scrollController.offset;
    }
    return 0.0;
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
    GlobalKey? targetKey;

    switch (section) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _projectsKey;
        break;
      case 3:
        targetKey = _spaceKey;
        break;
      case 4:
        targetKey = _contactKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      final RenderBox renderBox =
          targetKey!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final targetOffset = position.dy + _scrollController.offset;

      // Adjust for navbar height if needed
      final adjustedOffset = targetOffset > 0 ? targetOffset - 80.0 : 0.0;

      _scrollController.animateTo(
        adjustedOffset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
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
                      Container(
                        key: _heroKey,
                        child: HeroSection(
                            scrollController: _scrollController,
                            projectsKey: _projectsKey,
                            floatingController: _floatingController),
                      ),
                      Container(
                        key: _aboutKey,
                        child: const AboutSection(),
                      ),
                      Container(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                      Container(
                        key: _spaceKey,
                        child: const SpaceNeuralNetworkBackground(),
                      ),
                      Container(
                        key: _contactKey,
                        child: const ContactSection(),
                      ),
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

// Fixed Floating Bottom Navigation Bar
class FloatingBottomBar extends StatelessWidget {
  final int currentSection;
  final Function(int) onSectionTap;

  const FloatingBottomBar({
    super.key,
    required this.currentSection,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBottomNavItem(Icons.home, 0, "Home"),
            _buildBottomNavItem(Icons.person, 1, "About"),
            _buildBottomNavItem(Icons.work, 2, "Projects"),
            //_buildBottomNavItem(Icons.auto_awesome, 3, "Space"),
            _buildBottomNavItem(Icons.contact_mail, 4, "Contact"),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index, String label) {
    final isActive = currentSection == index;

    return GestureDetector(
      onTap: () => onSectionTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF6C63FF).withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isActive
              ? Border.all(color: const Color(0xFF6C63FF).withOpacity(0.5))
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.0 : 0.9,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isActive
                    ? const Color(0xFF6C63FF)
                    : Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF6C63FF),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
