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
  int? _tappedIndex;

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
      // Remove fixed height for mobile to allow scrolling
      height: isMobile ? null : size.height,
      constraints: isMobile
          ? BoxConstraints(minHeight: size.height * 1)
          : BoxConstraints(minHeight: size.height),
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
          // Animated background elements - reduced for mobile
          if (!isMobile)
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: isMobile ? 16 : 80,
                right: isMobile ? 16 : 80,
                top: isMobile ? 20 : 0,
                bottom: isMobile ? 20 : 0,
              ),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    physics: isMobile
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
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
                                  fontSize:
                                      isMobile ? 28 : 48, // Reduced for mobile
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
                                  colors: [
                                    Color(0xFF6C63FF),
                                    Color(0xFF3F3CF4)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: isMobile ? 12 : 20),

                        Text(
                          'Ready to bring your app idea to life? Let\'s collaborate!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 14 : 20, // Reduced for mobile
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: isMobile ? 30 : 60),

                        // Contact Options - Always column for mobile
                        if (!isMobile)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                            ],
                          )
                        else
                          Column(
                            children: [
                              _buildContactCard(
                                Icons.email,
                                'Email',
                                'dhanushpb49@gmail.com',
                                () => _launchEmail(),
                                0,
                              ),
                              const SizedBox(height: 16), // Reduced spacing
                              _buildContactCard(
                                Icons.phone,
                                'Phone',
                                '+91 9947191878',
                                () => _launchPhone(),
                                1,
                              ),
                              const SizedBox(height: 16),
                              _buildContactCard(
                                Icons.location_on,
                                'Location',
                                'Bangalore, Karnataka',
                                () => _launchLocation(),
                                2,
                              ),
                            ],
                          ),

                        SizedBox(height: isMobile ? 20 : 40),

                        // Direct Call Button
                        _buildCallButton(),

                        // Reduced spacing before social buttons - MOVED HIGHER
                        SizedBox(height: isMobile ? 24 : 32),

                        // Social Links - Positioned higher on mobile to avoid bottom navbar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              Icons.work,
                              () async {
                                final url = Uri.parse(
                                    'https://www.linkedin.com/in/dhanush-pb/');
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              },
                              'LinkedIn',
                            ),
                            const SizedBox(width: 15), // Reduced spacing
                            _buildSocialButton(
                              Icons.code_sharp,
                              () => _launchGitHub(),
                              'GitHub',
                            ),
                            const SizedBox(width: 15),
                            _buildSocialButton(
                              Icons.chat,
                              () => _launchWhatsApp(),
                              'Message',
                            ),
                          ],
                        ),

                        // Reduced spacing after social buttons
                        SizedBox(height: isMobile ? 16 : 32),

                        // Copyright
                        Text(
                          '© 2025 Dhanush PB. All rights reserved.',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 10 : 12, // Smaller for mobile
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),

                        // Extra bottom padding for mobile to avoid bottom navbar overlap
                        if (isMobile) SizedBox(height: bottomPadding + 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton() {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, animationValue, child) {
        return Transform.scale(
          scale: animationValue,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _launchPhone(),
              borderRadius: BorderRadius.circular(25), // Reduced radius
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isMobile ? MediaQuery.of(context).size.width * 0.8 : 300,
                height: isMobile ? 50 : 70, // Reduced height for mobile
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00C851),
                      Color(0xFF007E33),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00C851).withOpacity(0.4),
                      blurRadius: 15, // Reduced shadow
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(isMobile ? 6 : 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: isMobile ? 18 : 24,
                      ),
                    ),
                    SizedBox(width: isMobile ? 10 : 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Call Now',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '+91 9947191878',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 10 : 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                onTapDown: (_) => setState(() => _tappedIndex = index),
                onTapUp: (_) => setState(() => _tappedIndex = null),
                onTapCancel: () => setState(() => _tappedIndex = null),
                borderRadius: BorderRadius.circular(12), // Reduced radius
                splashColor: Color(0xFF6C63FF).withOpacity(0.2),
                highlightColor: Color(0xFF6C63FF).withOpacity(0.1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width:
                      isMobile ? double.infinity : null, // Full width on mobile
                  padding:
                      EdgeInsets.all(isMobile ? 16 : 24), // Reduced padding
                  decoration: BoxDecoration(
                    color: (_hoveredIndex == index || _tappedIndex == index)
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (_hoveredIndex == index || _tappedIndex == index)
                          ? const Color(0xFF6C63FF).withOpacity(0.5)
                          : Colors.white.withOpacity(0.1),
                    ),
                    boxShadow: (_hoveredIndex == index || _tappedIndex == index)
                        ? [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              blurRadius: 15, // Reduced shadow
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [],
                  ),
                  transform: (_hoveredIndex == index || _tappedIndex == index)
                      ? Matrix4.translationValues(0, -5, 0) // Reduced movement
                      : Matrix4.identity(),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: isMobile ? 40 : 60, // Reduced size
                        width: isMobile ? 40 : 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              (_hoveredIndex == index || _tappedIndex == index)
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF6C63FF)
                                            .withOpacity(0.4),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size:
                              (_hoveredIndex == index || _tappedIndex == index)
                                  ? (isMobile ? 20 : 28)
                                  : (isMobile ? 18 : 24),
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 16),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 16, // Reduced font size
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isMobile ? 4 : 8),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 9 : 12, // Reduced font size
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20), // Reduced radius
          splashColor: Color(0xFF6C63FF).withOpacity(0.3),
          highlightColor: Color(0xFF6C63FF).withOpacity(0.2),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.bounceOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  height: isMobile ? 40 : 55, // Reduced size
                  width: isMobile ? 40 : 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withOpacity(0.3),
                        blurRadius: 8, // Reduced shadow
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child:
                      Icon(icon, color: Colors.white, size: isMobile ? 16 : 22),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    try {
      // Multiple WhatsApp launch options with comprehensive message
      final String message = Uri.encodeComponent('Hi Dhanush! 👋\n\n'
          'I came across your portfolio and I\'m impressed with your Flutter development skills. '
          'I would like to connect with you regarding:\n\n'
          '• Mobile App Development\n'
          '• Project Collaboration\n'
          '• Freelance Opportunities\n'
          '• Technical Consultation\n\n'
          'Looking forward to hearing from you!');

      final List<Uri> whatsappUris = [
        Uri.parse('whatsapp://send?phone=919947191878&text=$message'),
        Uri.parse('https://wa.me/919947191878?text=$message'),
        Uri.parse(
            'https://api.whatsapp.com/send?phone=919947191878&text=$message'),
      ];

      bool launched = false;
      for (Uri uri in whatsappUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('WhatsApp launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog(
            'WhatsApp', 'Please message me on WhatsApp: +91 9947191878');
      }
    } catch (e) {
      debugPrint('WhatsApp launch error: $e');
      _showErrorDialog(
          'WhatsApp', 'Please message me on WhatsApp: +91 9947191878');
    }
  }

  // Fixed launch functions with proper URL schemes for Android/iOS
  Future<void> _launchEmail() async {
    try {
      // Try multiple email launch methods
      final List<Uri> emailUris = [
        Uri.parse(
            'mailto:dhanushpb49@gmail.com?subject=Let\'s%20Collaborate!&body=Hi%20Dhanush,%0A%0AI%20would%20like%20to%20discuss...'),
        Uri.parse('mailto:dhanushpb49@gmail.com'),
      ];

      bool launched = false;
      for (Uri uri in emailUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('Email launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog('Email', 'Please email me at: dhanushpb49@gmail.com');
      }
    } catch (e) {
      debugPrint('Email launch error: $e');
      _showErrorDialog('Email', 'Please email me at: dhanushpb49@gmail.com');
    }
  }

  Future<void> _launchPhone() async {
    try {
      // Multiple phone number formats for better compatibility
      final List<Uri> phoneUris = [
        Uri.parse('tel:+919947191878'),
        Uri.parse('tel:919947191878'),
        Uri.parse('tel:9947191878'),
      ];

      bool launched = false;
      for (Uri uri in phoneUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('Phone launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog('Phone', 'Please call me at: +91 9947191878');
      }
    } catch (e) {
      debugPrint('Phone launch error: $e');
      _showErrorDialog('Phone', 'Please call me at: +91 9947191878');
    }
  }

  Future<void> _launchLocation() async {
    try {
      // Multiple location launch options
      final List<Uri> locationUris = [
        Uri.parse('geo:12.9716,77.5946?q=Bangalore%2CKarnataka%2CIndia'),
        Uri.parse('geo:0,0?q=Bangalore+Karnataka+India'),
        Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=Bangalore%2BKarnataka%2BIndia'),
        Uri.parse('https://maps.google.com/?q=Bangalore,Karnataka,India'),
      ];

      bool launched = false;
      for (Uri uri in locationUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('Location launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog(
            'Location', 'I\'m located in Bangalore, Karnataka, India');
      }
    } catch (e) {
      debugPrint('Location launch error: $e');
      _showErrorDialog(
          'Location', 'I\'m located in Bangalore, Karnataka, India');
    }
  }

  Future<void> _launchLinkedIn() async {
    try {
      // Multiple LinkedIn launch options
      final List<Uri> linkedInUris = [
        Uri.parse('linkedin://profile/dhanush-pb'),
        Uri.parse('https://www.linkedin.com/in/dhanush-pb/'),
        Uri.parse('https://linkedin.com/in/dhanush-pb'),
      ];

      bool launched = false;
      for (Uri uri in linkedInUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('LinkedIn launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog(
            'LinkedIn', 'Find me on LinkedIn: linkedin.com/in/dhanush-pb');
      }
    } catch (e) {
      debugPrint('LinkedIn launch error: $e');
      _showErrorDialog(
          'LinkedIn', 'Find me on LinkedIn: linkedin.com/in/dhanush-pb');
    }
  }

  Future<void> _launchGitHub() async {
    try {
      // Multiple GitHub launch options
      final List<Uri> githubUris = [
        Uri.parse('https://github.com/Dhanush-Pb'),
        Uri.parse('https://www.github.com/Dhanush-Pb'),
      ];

      bool launched = false;
      for (Uri uri in githubUris) {
        try {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (launched) break;
        } catch (e) {
          debugPrint('GitHub launch attempt failed: $e');
          continue;
        }
      }

      if (!launched) {
        _showErrorDialog(
            'GitHub', 'Check out my GitHub: github.com/Dhanush-Pb');
      }
    } catch (e) {
      debugPrint('GitHub launch error: $e');
      _showErrorDialog('GitHub', 'Check out my GitHub: github.com/Dhanush-Pb');
    }
  }

  // Show error dialog instead of clipboard copy
  void _showErrorDialog(String title, String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: const Color(0xFF6C63FF)),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Got it!',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
