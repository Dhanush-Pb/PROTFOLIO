import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/about/orbital_atmoshphire.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _profileController;
  late AnimationController _particleController;
  late AnimationController _skillsController;
  late AnimationController _techIconController;
  late Animation<double> _profileAnimation;
  late Animation<double> _particleAnimation;
  late Animation<Color?> _gradientAnimation;
  late Animation<double> _skillsAnimation;

  @override
  void initState() {
    super.initState();

    _profileController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _skillsController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _techIconController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _profileAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _profileController, curve: Curves.easeInOut),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    _skillsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _skillsController, curve: Curves.linear),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF667EEA),
      end: const Color(0xFF64B6FF),
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _profileController.dispose();
    _particleController.dispose();
    _skillsController.dispose();
    _techIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = _ResponsiveHelper(size.width);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      decoration: _buildBackgroundDecoration(),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.horizontalPadding,
            vertical: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSectionHeader(responsive),
              SizedBox(height: responsive.sectionSpacing),
              _buildMainContent(responsive),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF0A0E27),
          const Color(0xFF1A1A2E).withOpacity(0.95),
          const Color(0xFF16213E).withOpacity(0.9),
        ],
        stops: const [0.1, 0.5, 1.0],
      ),
    );
  }

  Widget _buildSectionHeader(_ResponsiveHelper responsive) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 800),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: widget,
              duration: const Duration(milliseconds: 1000),
            ),
          ),
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'About ',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: responsive.titleSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Me',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: responsive.titleSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64B6FF),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF667EEA),
                    Color(0xFF64B6FF),
                    Color(0xFF64B6FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(_ResponsiveHelper responsive) {
    if (responsive.isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileSection(responsive),
          SizedBox(height: responsive.contentSpacing),
          _buildContentSection(responsive),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: _buildProfileSection(responsive),
        ),
        SizedBox(width: responsive.contentSpacing),
        Flexible(
          flex: 3,
          child: _buildContentSection(responsive),
        ),
      ],
    );
  }

  Widget _buildProfileSection(_ResponsiveHelper responsive) {
    return Column(
      children: [
        Center(
          child: AnimatedBuilder(
              animation: _profileAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _profileAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildParticleBackground(responsive),
                      _buildProfileImage(responsive),
                      _buildProfileDecoration(responsive),
                    ],
                  ),
                );
              }),
        ),

        SizedBox(
          height: responsive.isMobile ? 90 : 300,
        ),

        // Only show Neural Network on desktop/tablet
        if (!responsive.isMobile)
          const Stack(
            children: [
              NeuralNetworkBackground() // Background layer
              // Your app content on top
            ],
          )
      ],
    );
  }

  Widget _buildParticleBackground(_ResponsiveHelper responsive) {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return SizedBox(
          width: responsive.profileImageSize * 1.2,
          height: responsive.profileImageSize * 1.2,
          child: ClipOval(
            child: CustomPaint(
              painter: _ParticlePainter(
                animationValue: _particleAnimation.value,
                color: _gradientAnimation.value ?? const Color(0xFF667EEA),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(_ResponsiveHelper responsive) {
    return Container(
      width: responsive.profileImageSize,
      height: responsive.profileImageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B6FF).withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 10,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face&auto=format&q=80',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF667EEA).withOpacity(0.4),
                      const Color(0xFF64B6FF).withOpacity(0.4),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDecoration(_ResponsiveHelper responsive) {
    return Positioned(
      bottom: -10,
      right: responsive.isMobile ? -10 : 30,
      child: AnimatedBuilder(
        animation: _particleAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _particleAnimation.value * 2 * 3.1416,
            child: Container(
              width: responsive.profileImageSize * 0.3,
              height: responsive.profileImageSize * 0.3,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection(_ResponsiveHelper responsive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: responsive.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Show Neural Network at top of description on mobile
        if (responsive.isMobile) ...[
          const Stack(
            children: [
              NeuralNetworkBackground() // Background layer at top of description
            ],
          ),
          SizedBox(height: responsive.contentSpacing),
        ],
        _buildIntroduction(responsive),

        SizedBox(height: responsive.contentSpacing),

        _buildDescription(responsive),
        SizedBox(height: responsive.contentSpacing),
        _buildStatsSection(responsive),
        SizedBox(height: responsive.contentSpacing),
        _buildSkillsSection(responsive),
      ],
    );
  }

  Widget _buildIntroduction(_ResponsiveHelper responsive) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Full-Stack ',
            style: GoogleFonts.raleway(
              fontSize: responsive.subtitleSize,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 0.5,
            ),
          ),
          TextSpan(
            text: 'Flutter Developer ',
            style: GoogleFonts.raleway(
              fontSize: responsive.subtitleSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64B6FF),
              letterSpacing: 0.5,
            ),
          ),
          TextSpan(
            text: '/ ',
            style: GoogleFonts.raleway(
              fontSize: responsive.subtitleSize,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 0.5,
            ),
          ),
          TextSpan(
            text: 'Software Engineer',
            style: GoogleFonts.raleway(
              fontSize: responsive.subtitleSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64B6FF),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      textAlign: responsive.isMobile ? TextAlign.center : TextAlign.start,
    );
  }

  Widget _buildDescription(_ResponsiveHelper responsive) {
    return Column(
      children: [
        Text(
          'Passionate software engineer specializing in Flutter development with 2+ years of experience building scalable mobile and web applications.',
          style: GoogleFonts.inter(
            fontSize: responsive.bodySize,
            color: Colors.white.withOpacity(0.85),
            height: 1.7,
            letterSpacing: 0.2,
          ),
          textAlign: responsive.isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          'I excel at transforming complex requirements into elegant, user-focused solutions while collaborating seamlessly across cross-functional teams to deliver exceptional digital experiences.',
          style: GoogleFonts.inter(
            fontSize: responsive.bodySize,
            color: Colors.white.withOpacity(0.85),
            height: 1.7,
            letterSpacing: 0.2,
          ),
          textAlign: responsive.isMobile ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildStatsSection(_ResponsiveHelper responsive) {
    final stats = [
      _StatData('2+', 'Years\nExperience'),
      _StatData('25+', 'Projects\nCompleted'),
      _StatData('100%', 'Client\nSatisfaction'),
    ];

    return AnimationLimiter(
      child: Wrap(
        alignment:
            responsive.isMobile ? WrapAlignment.center : WrapAlignment.start,
        spacing: 24,
        runSpacing: 20,
        children: stats
            .map((stat) => AnimationConfiguration.staggeredList(
                  position: stats.indexOf(stat),
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildStatCard(stat, responsive),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildStatCard(_StatData stat, _ResponsiveHelper responsive) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(responsive.cardPadding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.03),
              Colors.white.withOpacity(0.01),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return Text(
                  stat.number,
                  style: GoogleFonts.raleway(
                    fontSize: responsive.statNumberSize,
                    fontWeight: FontWeight.w700,
                    color: _gradientAnimation.value ?? const Color(0xFF667EEA),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              stat.label,
              style: GoogleFonts.inter(
                fontSize: responsive.statLabelSize,
                color: Colors.white.withOpacity(0.7),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(_ResponsiveHelper responsive) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(responsive.isMobile ? 20 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.02),
            Colors.white.withOpacity(0.005),
            const Color(0xFF667EEA).withOpacity(0.01),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFF64B6FF).withOpacity(0.05),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkillsHeader(responsive),
          SizedBox(height: responsive.skillSpacing),
          _buildResponsiveSkillCategories(responsive),
        ],
      ),
    );
  }

  Widget _buildSkillsHeader(_ResponsiveHelper responsive) {
    return Row(
      mainAxisAlignment: responsive.isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _skillsAnimation,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _gradientAnimation.value?.withOpacity(0.2) ??
                        const Color(0xFF667EEA).withOpacity(0.2),
                    _gradientAnimation.value?.withOpacity(0.1) ??
                        const Color(0xFF64B6FF).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _gradientAnimation.value?.withOpacity(0.3) ??
                      const Color(0xFF667EEA).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.code_rounded,
                color: _gradientAnimation.value ?? const Color(0xFF667EEA),
                size: responsive.isMobile ? 20 : 24,
              ),
            );
          },
        ),
        const SizedBox(width: 16),
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Technical ',
                  style: GoogleFonts.raleway(
                    fontSize: responsive.sectionTitleSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                TextSpan(
                  text: 'Expertise',
                  style: GoogleFonts.raleway(
                    fontSize: responsive.sectionTitleSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64B6FF),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveSkillCategories(_ResponsiveHelper responsive) {
    final skillCategories = {
      'Mobile Development': {
        'skills': ['Flutter', 'Dart', 'React Native', 'iOS', 'Android'],
        'icon': Icons.phone_android_rounded,
        'color': const Color(0xFF667EEA),
      },
      'Backend & Cloud': {
        'skills': [
          'Node.js',
          'Express.js',
          'MongoDB',
          'Firebase',
          'Rest/RestFullAPI'
        ],
        'icon': Icons.cloud_rounded,
        'color': const Color(0xFF64B6FF),
      },
      'State Management': {
        'skills': ['BLoC', 'GetX', 'Provider'],
        'icon': Icons.memory_rounded,
        'color': const Color(0xFF7C3AED),
      },
      'Database': {
        'skills': ['Firestore', 'Hive', 'SQLite', 'MongoDB'],
        'icon': Icons.storage_rounded,
        'color': const Color(0xFF06B6D4),
      },
      'Web Technologies': {
        'skills': ['React', 'HTML5', 'CSS3', 'JavaScript'],
        'icon': Icons.web_rounded,
        'color': const Color(0xFF10B981),
      },
      'DevOps & Tools': {
        'skills': ['Git', 'GitHub', 'CI/CD', 'Figma', 'Postman'],
        'icon': Icons.build_rounded,
        'color': const Color(0xFFF59E0B),
      },
    };

    return AnimationLimiter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive columns based on available width
          int crossAxisCount;
          double childAspectRatio;

          if (constraints.maxWidth < 500) {
            // Small mobile - 1 column
            crossAxisCount = 1;
            childAspectRatio = 2.2; // reduced for more height
          } else if (constraints.maxWidth < 800) {
            // Large mobile/small tablet
            crossAxisCount = 1;
            childAspectRatio = 2.4;
          } else if (constraints.maxWidth < 1200) {
            // Tablet
            crossAxisCount = 2;
            childAspectRatio = 2.0;
          } else {
            // Desktop
            crossAxisCount = 2;
            childAspectRatio = 2.2;
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: responsive.isMobile ? 16 : 20,
              mainAxisSpacing: responsive.isMobile ? 16 : 20,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: skillCategories.length,
            itemBuilder: (context, index) {
              final category = skillCategories.entries.elementAt(index);
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 600),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildResponsiveSkillCategoryCard(
                      category.key,
                      category.value,
                      responsive,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildResponsiveSkillCategoryCard(
    String title,
    Map<String, dynamic> data,
    _ResponsiveHelper responsive,
  ) {
    final skills = data['skills'] as List<String>;
    final icon = data['icon'] as IconData;
    final color = data['color'] as Color;

    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.all(responsive.isMobile ? 16 : 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.05),
              color.withOpacity(0.02),
              Colors.white.withOpacity(0.01),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                AnimatedBuilder(
                  animation: _skillsAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: EdgeInsets.all(responsive.isMobile ? 8 : 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.2),
                            color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: responsive.isMobile ? 18 : 20,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: responsive.categorySize,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.isMobile ? 12 : 16),
            // Skills chips with responsive wrapping
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: responsive.isMobile ? 6 : 8,
                      runSpacing: responsive.isMobile ? 6 : 8,
                      children: skills
                          .map((skill) => _buildResponsiveSkillChip(
                                skill,
                                color,
                                responsive,
                                constraints.maxWidth,
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveSkillChip(
    String skill,
    Color color,
    _ResponsiveHelper responsive,
    double availableWidth,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _skillsAnimation,
        builder: (context, child) {
          final pulseValue =
              sin(_skillsAnimation.value * 2 * pi * 0.5) * 0.05 + 1.0;

          return Transform.scale(
            scale: pulseValue,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              constraints: BoxConstraints(
                maxWidth: responsive.isMobile
                    ? availableWidth * 0.45
                    : double.infinity,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: responsive.chipPadding,
                vertical: responsive.chipPadding * 0.6,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.08),
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(responsive.isMobile ? 12 : 16),
                border: Border.all(
                  color: color.withOpacity(0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: responsive.isMobile ? 5 : 6,
                    height: responsive.isMobile ? 5 : 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      skill,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: responsive.chipSize,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillCategoryCard(
    String title,
    Map<String, dynamic> data,
    _ResponsiveHelper responsive,
  ) {
    final skills = data['skills'] as List<String>;
    final icon = data['icon'] as IconData;
    final color = data['color'] as Color;

    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(responsive.isMobile ? 20 : 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.05),
              color.withOpacity(0.02),
              Colors.white.withOpacity(0.01),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _skillsAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.2),
                            color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 20,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: responsive.categorySize,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills
                    .map((skill) =>
                        _buildPremiumSkillChip(skill, color, responsive))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumSkillChip(
      String skill, Color color, _ResponsiveHelper responsive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _skillsAnimation,
        builder: (context, child) {
          final pulseValue =
              sin(_skillsAnimation.value * 2 * pi * 0.5) * 0.1 + 1.0;

          return Transform.scale(
            scale: pulseValue,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: responsive.chipPadding,
                vertical: responsive.chipPadding * 0.7,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    skill,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: responsive.chipSize,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _ParticlePainter({
    required this.animationValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final particleCount = 36;
    final particlePaint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Draw pulsing outer ring
    final ringPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(center, radius * 0.9, ringPaint);

    // Draw main particles
    for (int i = 0; i < particleCount; i++) {
      final angle = 2 * pi * i / particleCount;
      final pulseFactor = sin(animationValue * 2 * pi + angle * 2);
      final distance = radius * 0.7 + radius * 0.2 * pulseFactor;

      final position = Offset(
        center.dx + distance * cos(angle),
        center.dy + distance * sin(angle),
      );

      final particleSize = 2 + 1.5 * sin(animationValue * 2 * pi + i * 0.5);

      // Draw glow effect
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(position, particleSize * 1.5, glowPaint);
      canvas.drawCircle(position, particleSize, particlePaint);
    }

    // Draw inner connecting lines
    final linePaint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < particleCount; i += 3) {
      final angle1 = 2 * pi * i / particleCount;
      final angle2 = 2 * pi * (i + 3) / particleCount;

      final pos1 = Offset(
        center.dx + radius * 0.5 * cos(angle1),
        center.dy + radius * 0.5 * sin(angle1),
      );

      final pos2 = Offset(
        center.dx + radius * 0.5 * cos(angle2),
        center.dy + radius * 0.5 * sin(angle2),
      );

      canvas.drawLine(pos1, pos2, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Updated ResponsiveHelper class with better responsive values
class _ResponsiveHelper {
  final double screenWidth;

  _ResponsiveHelper(this.screenWidth);

  bool get isSmallMobile => screenWidth < 480;
  bool get isMobile => screenWidth < 768;
  bool get isTablet => screenWidth >= 768 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  double get horizontalPadding {
    if (isSmallMobile) return 16;
    if (isMobile) return 24;
    if (isTablet) return 40;
    return 80;
  }

  double get sectionSpacing => isMobile ? 40 : 80;
  double get contentSpacing => isMobile ? 24 : 40;
  double get skillSpacing => isMobile ? 16 : 24;

  double get titleSize {
    if (isSmallMobile) return 32;
    if (isMobile) return 36;
    if (isTablet) return 42;
    return 48;
  }

  double get subtitleSize {
    if (isSmallMobile) return 16;
    if (isMobile) return 18;
    if (isTablet) return 20;
    return 22;
  }

  double get sectionTitleSize {
    if (isSmallMobile) return 16;
    if (isMobile) return 18;
    if (isTablet) return 20;
    return 22;
  }

  double get bodySize {
    if (isSmallMobile) return 14;
    if (isMobile) return 15;
    return 16;
  }

  double get categorySize {
    if (isSmallMobile) return 13;
    if (isMobile) return 14;
    if (isTablet) return 15;
    return 16;
  }

  double get chipSize {
    if (isSmallMobile) return 11;
    if (isMobile) return 12;
    return 13;
  }

  double get profileImageSize {
    if (isSmallMobile) return 240;
    if (isMobile) return 280;
    if (isTablet) return 320;
    return 360;
  }

  double get cardPadding {
    if (isSmallMobile) return 12;
    if (isMobile) return 16;
    return 20;
  }

  double get chipPadding {
    if (isSmallMobile) return 10;
    if (isMobile) return 12;
    return 14;
  }

  double get statNumberSize {
    if (isSmallMobile) return 20;
    if (isMobile) return 24;
    return 28;
  }

  double get statLabelSize {
    if (isSmallMobile) return 11;
    if (isMobile) return 12;
    return 14;
  }
}

class _StatData {
  final String number;
  final String label;

  _StatData(this.number, this.label);
}

class TechOrbitSystem extends StatefulWidget {
  final bool isMobile;
  final bool isSmallMobile;

  const TechOrbitSystem({
    Key? key,
    required this.isMobile,
    required this.isSmallMobile,
  }) : super(key: key);

  @override
  State<TechOrbitSystem> createState() => _TechOrbitSystemState();
}

class _TechOrbitSystemState extends State<TechOrbitSystem>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _pulseController;
  late Animation<double> _orbitAnimation;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> techItems = [
    {
      'icon': Icons.flutter_dash,
      'color': const Color(0xFF02569B),
      'label': 'Flutter',
      'orbitSpeed': 0.5,
    },
    {
      'icon': Icons.android,
      'color': const Color(0xFF3DDC84),
      'label': 'Android',
      'orbitSpeed': 0.6,
    },
    {
      'icon': Icons.phone_iphone,
      'color': const Color(0xFF007AFF),
      'label': 'iOS',
      'orbitSpeed': 0.7,
    },
    {
      'icon': Icons.psychology,
      'color': const Color(0xFFFF6B6B),
      'label': 'AI/ML',
      'orbitSpeed': 0.8,
    },
    {
      'icon': Icons.cloud,
      'color': const Color(0xFF4285F4),
      'label': 'Cloud',
      'orbitSpeed': 0.9,
    },
  ];

  @override
  void initState() {
    super.initState();

    // Orbit animation (20 second loop)
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _orbitAnimation = CurvedAnimation(
      parent: _orbitController,
      curve: Curves.linear,
    );

    // Pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerSize = widget.isMobile
        ? (widget.isSmallMobile ? size.width * 0.7 : size.width * 0.6)
        : 400.0;
    final orbitRadius = containerSize * 0.35;
    final iconSize = containerSize * 0.2;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Orbiting animation
          SizedBox(
            width: containerSize,
            height: containerSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Central glow
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      width: containerSize * 0.5,
                      height: containerSize * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF6C63FF).withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF)
                                .withOpacity(0.2 * _pulseAnimation.value),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Central icon
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.code,
                    size: iconSize * 0.6,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),

                // Orbiting tech items
                ...techItems.map((tech) {
                  return AnimatedBuilder(
                    animation: _orbitAnimation,
                    builder: (context, child) {
                      final angle =
                          _orbitAnimation.value * 2 * pi * tech['orbitSpeed'];
                      final x = orbitRadius * cos(angle);
                      final y = orbitRadius * sin(angle);

                      return Positioned(
                        left: (containerSize / 2) + x - (iconSize / 2),
                        top: (containerSize / 2) + y - (iconSize / 2),
                        child: Transform.scale(
                          scale:
                              1 + 0.1 * sin(_orbitAnimation.value * 2 * pi * 2),
                          child: _TechItem(
                            icon: tech['icon'],
                            color: tech['color'],
                            label: tech['label'],
                            isMobile: widget.isMobile,
                            isSmallMobile: widget.isSmallMobile,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ],
            ),
          ),

          // Tech stack labels
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: techItems.map((tech) {
              return _TechLabel(
                color: tech['color'],
                label: tech['label'],
                isSmallMobile: widget.isSmallMobile,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TechItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isMobile;
  final bool isSmallMobile;

  const _TechItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.isMobile,
    required this.isSmallMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        width: isMobile ? (isSmallMobile ? 40 : 50) : 60,
        height: isMobile ? (isSmallMobile ? 40 : 50) : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: isMobile ? (isSmallMobile ? 20 : 24) : 28,
        ),
      ),
    );
  }
}

class _TechLabel extends StatelessWidget {
  final Color color;
  final String label;
  final bool isSmallMobile;

  const _TechLabel({
    required this.color,
    required this.label,
    required this.isSmallMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          fontSize: isSmallMobile ? 10 : 12,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}
