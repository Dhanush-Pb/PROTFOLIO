import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _animationController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background elements
          ...List.generate(
            3,
            (index) => Positioned(
              top: (index + 1) * size.height * 0.2,
              left: (index.isEven ? 0.1 : 0.7) * size.width,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.5 + (_animationController.value * 0.5),
                    child: Container(
                      width: 100 + (index * 20),
                      height: 100 + (index * 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF6C63FF).withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Main content with proper mobile padding
          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 20 : 80,
              right: isMobile ? 20 : 80,
              top: isMobile ? 40 : 0,
              bottom: isMobile
                  ? (bottomPadding + 100)
                  : 0, // Extra space for bottom nav
            ),
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: isMobile
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      if (isMobile) const SizedBox(height: 20),

                      // Section Title with animation
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1200),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Text(
                              'Get In Touch',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 32 : 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),

                      // Animated underline
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1500),
                        tween: Tween(begin: 0.0, end: 60.0),
                        curve: Curves.easeOutCubic,
                        builder: (context, width, child) {
                          return Container(
                            height: 4,
                            width: width,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: isMobile ? 16 : 20),

                      Text(
                        'Ready to bring your app idea to life? Let\'s collaborate!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 20,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: isMobile ? 40 : 60),

                      // Contact Options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!isMobile) ...[
                            _buildContactCard(
                              Icons.email,
                              'Email',
                              'dhanushpb49@gmail.com',
                              () => _launchEmail(),
                              0,
                            ),
                            const SizedBox(width: 30),
                            _buildContactCard(
                              Icons.phone,
                              'Phone',
                              '+91 9947191878',
                              () => _launchPhone(),
                              1,
                            ),
                            const SizedBox(width: 30),
                            _buildContactCard(
                              Icons.location_on,
                              'Location',
                              'Bangalore, Karnataka',
                              () => _launchLocation(),
                              2,
                            ),
                          ] else
                            Column(
                              children: [
                                _buildContactCard(
                                  Icons.email,
                                  'Email',
                                  'dhanushpb49@gmail.com',
                                  () => _launchEmail(),
                                  0,
                                ),
                                const SizedBox(height: 20),
                                _buildContactCard(
                                  Icons.phone,
                                  'Phone',
                                  '+91 9947191878',
                                  () => _launchPhone(),
                                  1,
                                ),
                                const SizedBox(height: 20),
                                _buildContactCard(
                                  Icons.location_on,
                                  'Location',
                                  'Bangalore, Karnataka',
                                  () => _launchLocation(),
                                  2,
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 40 : 60),

                      // Social Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            Icons.work,
                            () => _launchLinkedIn(),
                            'LinkedIn',
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            Icons.code_sharp,
                            () => _launchGitHub(),
                            'GitHub',
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            Icons.message,
                            () => _launchEmail(),
                            'Message',
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 30 : 40),

                      // Copyright
                      Text(
                        '© 2025 Dhanush PB. All rights reserved.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),

                      if (isMobile)
                        const SizedBox(
                            height: 20), // Extra space at bottom for mobile
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
    int index,
  ) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, animationValue, child) {
        return Transform.scale(
          scale: animationValue,
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width:
                    isMobile ? MediaQuery.of(context).size.width * 0.8 : null,
                padding: EdgeInsets.all(isMobile ? 20 : 24),
                decoration: BoxDecoration(
                  color: _hoveredIndex == index
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: _hoveredIndex == index
                        ? const Color(0xFF6C63FF).withOpacity(0.5)
                        : Colors.white.withOpacity(0.1),
                  ),
                  boxShadow: _hoveredIndex == index
                      ? [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [],
                ),
                transform: _hoveredIndex == index
                    ? Matrix4.translationValues(0, -10, 0)
                    : Matrix4.identity(),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isMobile ? 50 : 60,
                      width: isMobile ? 50 : 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: _hoveredIndex == index
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFF6C63FF).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: _hoveredIndex == index
                            ? (isMobile ? 24 : 28)
                            : (isMobile ? 20 : 24),
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 11 : 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onTap, String tooltip) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.bounceOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                height: isMobile ? 45 : 50,
                width: isMobile ? 45 : 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child:
                    Icon(icon, color: Colors.white, size: isMobile ? 18 : 20),
              ),
            );
          },
        ),
      ),
    );
  }

  // Launch functions
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'dhanushpb49@gmail.com',
      query:
          'subject=Let\'s Collaborate!&body=Hi Dhanush,\n\nI would like to discuss...',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+919947191878');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchLocation() async {
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=Bangalore+Karnataka+India');

    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchLinkedIn() async {
    final Uri linkedInUri =
        Uri.parse('https://www.linkedin.com/in/dhanush-pb/');

    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/Dhanush-Pb');

    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }
}
