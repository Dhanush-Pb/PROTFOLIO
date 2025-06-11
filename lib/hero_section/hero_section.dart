import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final AnimationController floatingController;
  final ScrollController? scrollController;
  final GlobalKey? projectsKey;
  const HeroSection(
      {super.key,
      required this.floatingController,
      this.scrollController,
      this.projectsKey});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _matrixController;
  late AnimationController _particleController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _matrixController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _matrixController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _scrollToProjects() {
    if (widget.scrollController != null && widget.projectsKey != null) {
      final context = widget.projectsKey!.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _downloadCV() async {
    try {
      // Your Google Drive CV link
      const String cvUrl =
          'https://drive.google.com/file/d/1eeLfi0a6ojXciA6YEXKKIXbcQZIm15Mx/view?usp=sharing';

      // Show loading message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.open_in_new, color: Colors.white),
              SizedBox(width: 8),
              Text('Opening CV in Google Drive...'),
            ],
          ),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );

      // Open Google Drive link in browser/app
      await launchUrl(
        Uri.parse(cvUrl),
        mode: LaunchMode.externalApplication, // Opens in external browser/app
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open CV. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      print('Error opening CV: $e');
    }
  }

  @override

// CHANGE 1: Remove SingleChildScrollView to allow main page scrolling
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isSmallMobile = size.width < 480;

    return Container(
      // CHANGED: Remove fixed height to allow content to flow naturally
      constraints: BoxConstraints(minHeight: size.height),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.3, -0.5),
          radius: 1.5,
          colors: [
            const Color(0xFF1A1B3A).withOpacity(0.8),
            const Color(0xFF0A0B1E).withOpacity(0.9),
            const Color(0xFF000000),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated Matrix Background
          _buildMatrixBackground(size),

          // Floating Particles
          _buildFloatingParticles(size),

          // Neural Network Lines
          _buildNeuralNetwork(size),

          // CHANGED: Direct main content without SingleChildScrollView
          _buildMainContent(size, isMobile, isTablet, isSmallMobile),
        ],
      ),
    );
  }

// CHANGE 2: Adjust main content method for better mobile layout
  Widget _buildMainContent(
      Size size, bool isMobile, bool isTablet, bool isSmallMobile) {
    return Padding(
      padding: EdgeInsets.only(
        left: isSmallMobile ? 16 : (isMobile ? 20 : 80),
        right: isSmallMobile ? 16 : (isMobile ? 20 : 80),
        top: isMobile ? 60 : 0, // Increased top padding for mobile
        bottom: isMobile ? 80 : 0, // Increased bottom padding for mobile
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight:
              isMobile ? size.height - 140 : size.height, // Account for padding
        ),
        child: isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mobile: Show floating animation first
                  _buildFloatingAnimation(size, isMobile, isSmallMobile),
                  SizedBox(height: isSmallMobile ? 30 : 40),
                  // Then show text content
                  _buildTextContent(size, isMobile, isTablet, isSmallMobile),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildTextContent(
                        size, isMobile, isTablet, isSmallMobile),
                  ),
                  Expanded(
                    flex: 2,
                    child:
                        _buildFloatingAnimation(size, isMobile, isSmallMobile),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMatrixBackground(Size size) {
    return AnimatedBuilder(
      animation: _matrixController,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: MatrixPainter(_matrixController.value),
        );
      },
    );
  }

  Widget _buildFloatingParticles(Size size) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: ParticlePainter(_particleController.value),
        );
      },
    );
  }

  Widget _buildNeuralNetwork(Size size) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: NeuralNetworkPainter(_pulseController.value),
        );
      },
    );
  }

// CHANGE 3: Update _buildTextContent method - fix the buttons section spacing
  Widget _buildTextContent(
      Size size, bool isMobile, bool isTablet, bool isSmallMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        AnimationLimiter(
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 800),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: -50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                const SizedBox(height: 20),

                Text(
                  'Hello, I\'m',
                  style: GoogleFonts.poppins(
                    fontSize: isSmallMobile
                        ? 20
                        : (isMobile ? 24 : (isTablet ? 28 : 32)),
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ),
                const SizedBox(height: 8),

                // Glowing Name with Holographic Effect
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF)
                                .withOpacity(0.3 * _pulseAnimation.value),
                            blurRadius: 30 * _pulseAnimation.value,
                            spreadRadius: 5 * _pulseAnimation.value,
                          ),
                        ],
                      ),
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF6C63FF),
                            Color(0xFF6C63FF),
                            Color(0xFF00D4FF),
                            Color.fromARGB(255, 9, 181, 233),
                          ],
                          stops: [0.0, 0.3, 0.7, 1.0],
                        ).createShader(bounds),
                        child: Text(
                          'Dhanush',
                          style: GoogleFonts.poppins(
                            fontSize: isSmallMobile
                                ? 28
                                : (isMobile ? 36 : (isTablet ? 48 : 56)),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.start,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Enhanced Animated Text with Cyber Effects
                SizedBox(
                  width:
                      isMobile ? size.width - (isSmallMobile ? 32 : 40) : null,
                  child: Wrap(
                    alignment:
                        isMobile ? WrapAlignment.center : WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'I\'m a ',
                        style: GoogleFonts.poppins(
                          fontSize: isSmallMobile
                              ? 16
                              : (isMobile ? 18 : (isTablet ? 20 : 24)),
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF00D4FF).withOpacity(0.05),
                              const Color(0xFF6C63FF).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF00D4FF).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFF00D4FF),
                              Color(0xFF6C63FF),
                              Color(0xFF4ECDC4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Software Engineer',
                                textStyle: GoogleFonts.poppins(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: const Color(0xFF00D4FF)
                                          .withOpacity(0.3),
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 80),
                              ),
                              TypewriterAnimatedText(
                                'Full-Stack Flutter developer',
                                textStyle: GoogleFonts.firaCode(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: const Color(0xFF6C63FF)
                                          .withOpacity(0.4),
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 75),
                              ),
                              TypewriterAnimatedText(
                                'App & Game Functionality Builder',
                                textStyle: GoogleFonts.poppins(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: const Color(0xFF00D4FF)
                                          .withOpacity(0.3),
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 85),
                              ),
                              TypewriterAnimatedText(
                                'UI/UX Focused Developer',
                                textStyle: GoogleFonts.poppins(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 9.0,
                                      color: const Color(0xFF6C63FF)
                                          .withOpacity(0.35),
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 80),
                              ),
                              TypewriterAnimatedText(
                                'Animation & Interaction Designer',
                                textStyle: GoogleFonts.poppins(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8.0,
                                      color: const Color.fromARGB(
                                              255, 110, 103, 255)
                                          .withOpacity(0.3),
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 85),
                              ),
                              TypewriterAnimatedText(
                                'AI Integration Expert',
                                textStyle: GoogleFonts.poppins(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: const Color(0xFF00D4FF)
                                          .withOpacity(0.4),
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 80),
                              ),
                              TypewriterAnimatedText(
                                'Interactive Experience Designer',
                                textStyle: GoogleFonts.firaCode(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 9.0,
                                      color: const Color(0xFF4ECDC4)
                                          .withOpacity(0.4),
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 75),
                              ),
                              TypewriterAnimatedText(
                                'Next-Gen App Architect',
                                textStyle: GoogleFonts.firaCode(
                                  fontSize: isSmallMobile
                                      ? 16
                                      : (isMobile ? 18 : (isTablet ? 20 : 24)),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: const Color(0xFF00D4FF)
                                          .withOpacity(0.4),
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                speed: const Duration(milliseconds: 78),
                              ),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 2000),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Enhanced Description with Typewriter Effect
                Container(
                  width:
                      isMobile ? size.width - (isSmallMobile ? 32 : 40) : null,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF6C63FF).withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    'Engineering intelligent, scalable Flutter applications that turn innovative ideas into seamless digital experiences—powered by precision, creativity, and advanced AI/ML integration.Dedicated to building future-ready solutions that merge design elegance with engineering excellence.',
                    style: GoogleFonts.poppins(
                      fontSize: isSmallMobile
                          ? 13
                          : (isMobile ? 14 : (isTablet ? 16 : 18)),
                      color: Colors.white.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  ),
                ),
                SizedBox(height: isSmallMobile ? 20 : 30),

                // Tech Stack Indicators
                _buildTechStack(isMobile, isSmallMobile),
                SizedBox(
                    height:
                        isSmallMobile ? 25 : 30), // CHANGED: Increased spacing

                // CHANGED: Better button layout for mobile
                Container(
                  width: isMobile ? double.infinity : null,
                  child: isMobile
                      ? Column(
                          children: [
                            // Stack buttons vertically on small screens
                            SizedBox(
                              width: double.infinity,
                              child: _buildGlowButton(
                                'Explore Projects',
                                Icons.rocket_launch,
                                () {
                                  _scrollToProjects();
                                },
                                isPrimary: true,
                                isSmallMobile: isSmallMobile,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: _buildGlowButton(
                                'Download CV',
                                Icons.cloud_download,
                                () {
                                  _downloadCV();
                                },
                                isPrimary: false,
                                isSmallMobile: isSmallMobile,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: _buildGlowButton(
                                'Explore Projects',
                                Icons.rocket_launch,
                                () {
                                  _scrollToProjects();
                                },
                                isPrimary: true,
                                isSmallMobile: isSmallMobile,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: _buildGlowButton(
                                'Download CV',
                                Icons.cloud_download,
                                () {
                                  _downloadCV();
                                },
                                isPrimary: false,
                                isSmallMobile: isSmallMobile,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
        // CHANGED: Add extra bottom spacing for mobile
        SizedBox(height: isMobile ? 40 : 100),
      ],
    );
  }

  Widget _buildTechStack(bool isMobile, bool isSmallMobile) {
    final techIcons = [
      {
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF02569B),
        'label': 'Flutter'
      },
      {
        'icon': Icons.android,
        'color': const Color(0xFF3DDC84),
        'label': 'Android'
      },
      {
        'icon': Icons.phone_iphone,
        'color': const Color(0xFF007AFF),
        'label': 'iOS'
      },
      {
        'icon': Icons.psychology,
        'color': const Color(0xFFFF6B6B),
        'label': 'AI/ML'
      },
      {'icon': Icons.cloud, 'color': const Color(0xFF4285F4), 'label': 'Cloud'},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: techIcons.map((tech) {
        return AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (tech['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (tech['color'] as Color).withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (tech['color'] as Color)
                        .withOpacity(0.2 * _pulseController.value),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tech['icon'] as IconData,
                    color: tech['color'] as Color,
                    size: isSmallMobile ? 16 : 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tech['label'] as String,
                    style: GoogleFonts.firaCode(
                      fontSize: isSmallMobile ? 8 : 10,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFloatingAnimation(Size size, bool isMobile, bool isSmallMobile) {
    final animationSize = isMobile
        ? (isSmallMobile ? size.width * 0.6 : size.width * 0.7)
        : 400.0;
    final iconSize = isMobile
        ? (isSmallMobile ? animationSize * 0.3 : animationSize * 0.35)
        : 200.0;
    final dashSize = isMobile ? (isSmallMobile ? 60.0 : 80.0) : 100.0;
    final orbitRadius = isMobile
        ? (isSmallMobile ? animationSize * 0.3 : animationSize * 0.35)
        : 150.0;

    return AnimatedBuilder(
      animation: widget.floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              0,
              math.sin(widget.floatingController.value * 2 * math.pi) *
                  (isMobile ? 15 : 20)),
          child: Container(
            height: animationSize,
            width: animationSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF6C63FF).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Flutter Dash Container
                Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Icon(
                    Icons.flutter_dash,
                    size: dashSize,
                    color: const Color(0xFF6C63FF),
                  ),
                ),
                // Orbiting elements with proper sizing
                ...List.generate(3, (index) {
                  return Transform.rotate(
                    angle: (widget.floatingController.value * 2 * math.pi) +
                        (index * 2 * math.pi / 3),
                    child: Transform.translate(
                      offset: Offset(orbitRadius, 0),
                      child: Container(
                        height: isMobile ? (isSmallMobile ? 12 : 16) : 20,
                        width: isMobile ? (isSmallMobile ? 12 : 16) : 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: [
                            const Color(0xFF6C63FF),
                            const Color(0xFF00D4FF),
                            const Color(0xFF3F3CF4),
                          ][index],
                          boxShadow: [
                            BoxShadow(
                              color: [
                                const Color(0xFF6C63FF),
                                const Color(0xFF00D4FF),
                                const Color(0xFF3F3CF4),
                              ][index]
                                  .withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlowButton(
    String text,
    IconData icon,
    VoidCallback onTap, {
    required bool isPrimary,
    required bool isSmallMobile,
    bool isSpecial = false,
  }) {
    bool isHovered = false;
    bool isTapped = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => isTapped = true),
            onTapUp: (_) {
              setState(() => isTapped = false);
              HapticFeedback.lightImpact();
              onTap();
            },
            onTapCancel: () => setState(() => isTapped = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()
                ..scale(isTapped ? 0.95 : (isHovered ? 1.05 : 1.0)),
              padding: EdgeInsets.symmetric(
                horizontal: isSmallMobile ? 18 : 24,
                vertical: isSmallMobile ? 10 : 12,
              ),
              decoration: BoxDecoration(
                gradient: isPrimary
                    ? LinearGradient(
                        colors: isHovered
                            ? [const Color(0xFF7C73FF), const Color(0xFF4F4CF4)]
                            : [
                                const Color(0xFF6C63FF),
                                const Color(0xFF3F3CF4)
                              ],
                      )
                    : isSpecial
                        ? LinearGradient(
                            colors: isHovered
                                ? [
                                    const Color(0xFFFF6B6B),
                                    const Color(0xFFFF8E53)
                                  ]
                                : [
                                    const Color(0xFFFF6B6B).withOpacity(0.1),
                                    const Color(0xFFFF8E53).withOpacity(0.1)
                                  ],
                          )
                        : null,
                border: isPrimary || isSpecial
                    ? null
                    : Border.all(
                        color: isHovered
                            ? Colors.white.withOpacity(0.6)
                            : Colors.white.withOpacity(0.3),
                        width: isHovered ? 1.5 : 1.0,
                      ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: isPrimary
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6C63FF)
                              .withOpacity(isHovered ? 0.5 : 0.3),
                          blurRadius: isHovered ? 20 : 15,
                          offset: const Offset(0, 5),
                          spreadRadius: isHovered ? 2 : 0,
                        ),
                      ]
                    : isSpecial
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF6B6B)
                                  .withOpacity(isHovered ? 0.4 : 0.2),
                              blurRadius: isHovered ? 20 : 15,
                              offset: const Offset(0, 5),
                              spreadRadius: isHovered ? 2 : 0,
                            ),
                          ]
                        : isHovered
                            ? [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                            : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                      fontSize: isSmallMobile ? 13 : 14,
                    ),
                    child: Text(text),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isHovered ? 0.05 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: isSmallMobile ? 16 : 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom Painters for Background Effects
class MatrixPainter extends CustomPainter {
  final double animationValue;

  MatrixPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw matrix-like grid
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 15; j++) {
        final x = (size.width / 20) * i;
        final y = (size.height / 15) * j + (animationValue * 50) % 100;

        if (math.Random(i * j + animationValue.toInt()).nextDouble() > 0.95) {
          canvas.drawCircle(Offset(x, y), 2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);

    for (int i = 0; i < 50; i++) {
      final x =
          (math.sin(animationValue * 2 + i) * size.width / 2) + size.width / 2;
      final y = (math.cos(animationValue * 3 + i) * size.height / 2) +
          size.height / 2;
      final radius = math.sin(animationValue * 4 + i) * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C63FF).withOpacity(0.2)
      ..strokeWidth = 1;

    // Draw neural network connections
    final nodes = [
      Offset(size.width * 0.1, size.height * 0.3),
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.5),
    ];

    for (int i = 0; i < nodes.length - 1; i++) {
      final opacity = (math.sin(animationValue * 2 + i) + 1) / 2;
      paint.color = const Color(0xFF6C63FF).withOpacity(opacity * 0.3);
      canvas.drawLine(nodes[i], nodes[i + 1], paint);
    }

    // Draw nodes
    paint.color = const Color(0xFF6C63FF).withOpacity(0.5);
    for (final node in nodes) {
      canvas.drawCircle(node, 3, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
