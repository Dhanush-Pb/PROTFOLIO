import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String selectedCategory = 'All';
  List<Map<String, dynamic>> filteredProjects = [];

  final projects = [
    // Professional Projects
    {
      'title': 'NamoDeva - Spiritual Connection App',
      'description':
          'Comprehensive spiritual platform with captivating animations and immersive UI connecting devotees to religious content with Firebase authentication and Unreal Engine gaming integration.',
      'technologies': ['Flutter', 'GetX', 'Firebase', 'Unreal Engine'],
      'color': const Color(0xFF6C63FF),
      'platform': 'Google Play Store',
      'projectUrl':
          'https://play.google.com/store/apps/details?id=in.example.namodeva_new_part&pcampaignid=web_share',
      'features': [
        'Custom Flutter animations with immersive UI',
        'Firebase authentication & real-time database',
        'In-app gaming system with Unreal Engine',
        'Religious content management system'
      ],
      'type': 'Professional',
      'icon': Icons.temple_hindu,
      'downloadCount': '10K+',
      'rating': 4.8,
    },
    {
      'title': 'BedMyWay - Hotel Booking Platform',
      'description':
          'Advanced hotel booking solution with real-time availability, reservation system, integrated payments, and Google Maps integration for seamless travel experience.',
      'technologies': [
        'Flutter',
        'Bloc',
        'Firebase',
        'Razorpay',
        'Google Maps'
      ],
      'color': const Color(0xFF00B4D8),
      'platform': 'Amazon Appstore',
      'projectUrl': 'https://www.amazon.com/dp/B0D9NQRBM2/ref=apps_sf_sta',
      'features': [
        'Real-time messaging & booking system',
        'Razorpay payment gateway integration',
        'Google Maps location services',
        'MVC architecture with clean code'
      ],
      'type': 'Professional',
      'icon': Icons.hotel,
      'downloadCount': '5K+',
      'rating': 4.6,
    },
    {
      'title': 'NutriFuel - Diet & Nutrition Planner',
      'description':
          'Comprehensive nutrition and diet tracking application to monitor food intake, achieve health goals with smart notifications and progress tracking.',
      'technologies': ['Flutter', 'Hive', 'Notifications', 'Charts'],
      'color': const Color(0xFF4CC9F0),
      'platform': 'Amazon Appstore',
      'projectUrl':
          'https://www.amazon.com/Dhanush-pb-Nutri-fuel/dp/B0CW1FW5NC/',
      'features': [
        'Hive local storage for offline functionality',
        'Customizable UI with modern design',
        'Smart notifications for meal reminders',
        'Progress tracking with visual charts'
      ],
      'type': 'Professional',
      'icon': Icons.restaurant,
      'downloadCount': '3K+',
      'rating': 4.5,
    },

    // Open Source Packages
    {
      'title': 'flowing_text - Flutter Package',
      'description':
          'Flutter package for dynamic text animations with smooth performance, extensive styling options, and customizable effects for enhanced user experience.',
      'technologies': ['Dart', 'Flutter', 'Animations', 'pub.dev'],
      'color': const Color(0xFF7209B7),
      'platform': 'pub.dev',
      'projectUrl': 'https://pub.dev/packages/flowing_text',
      'features': [
        'Customizable text animations',
        'Smooth performance optimization',
        'Extensive styling options',
        'Easy integration & documentation'
      ],
      'type': 'Open Source',
      'icon': Icons.text_fields,
      'downloadCount': '1K+',
      'rating': 4.9,
    },
    {
      'title': 'flutter_falling_items - Animation Package',
      'description':
          'Flutter package for creating beautiful falling animations including rain, snow, confetti effects with customizable parameters and performance optimization.',
      'technologies': ['Dart', 'Flutter', 'Particles', 'Animations'],
      'color': const Color(0xFF3A0CA3),
      'platform': 'pub.dev',
      'projectUrl': 'https://pub.dev/packages/flutter_falling_items',
      'features': [
        'Multiple falling effects (rain, snow, confetti)',
        'Performance optimized particle system',
        'Customizable movement patterns',
        'Easy to implement & configure'
      ],
      'type': 'Open Source',
      'icon': Icons.grain,
      'downloadCount': '800+',
      'rating': 4.7,
    },

    // Mini Projects
    {
      'title': 'Lumiconvo - AI Chatbot Web App',
      'description':
          'Modern chatbot application utilizing Gemini AI with sleek glassy UI design, seamless API integration, and responsive web interface.',
      'technologies': ['Flutter', 'Gemini AI', 'Web', 'Firebase'],
      'color': const Color(0xFF4361EE),
      'platform': 'Web App',
      'projectUrl': 'https://github.com/Dhanush-Pb/Lumiconvo_AI_app',
      'liveUrl': 'https://lumiconvo-9ced5.web.app/',
      'features': [
        'Gemini AI integration for smart responses',
        'Modern glassy UI with blur effects',
        'Real-time chat functionality',
        'Responsive design for all devices'
      ],
      'type': 'Mini Projects',
      'icon': Icons.chat_bubble_outline,
      'downloadCount': 'N/A',
      'rating': 4.4,
    },
    {
      'title': 'Tech Hub - Full Stack Node.js App',
      'description':
          'Full-stack application built with Node.js and MongoDB backend, ensuring scalability and performance with sleek Flutter UI and modern design.',
      'technologies': ['Flutter', 'Node.js', 'MongoDB', 'REST API'],
      'color': const Color(0xFF2ECC71),
      'platform': 'GitHub',
      'projectUrl': 'https://github.com/Dhanush-Pb/Tech-app-Nodejs-mongodb',
      'features': [
        'Node.js & MongoDB backend architecture',
        'RESTful API design & implementation',
        'Modern blurred glassy UI effects',
        'Scalable database design'
      ],
      'type': 'Mini Projects',
      'icon': Icons.developer_mode,
      'downloadCount': 'N/A',
      'rating': 4.3,
    },
    {
      'title': 'SkyCast - Weather Application',
      'description':
          'Real-time weather application providing accurate forecasts and updates with intuitive interface, built using BloC architecture and Weather REST API.',
      'technologies': ['Flutter', 'BloC', 'Weather API', 'Location Services'],
      'color': const Color(0xFF3498DB),
      'platform': 'GitHub',
      'projectUrl': 'https://github.com/Dhanush-Pb/Weather-_appliaction_bloc',
      'features': [
        'Real-time weather updates & forecasts',
        'BloC state management architecture',
        'Location-based weather data',
        'Beautiful weather animations'
      ],
      'type': 'Mini Projects',
      'icon': Icons.wb_sunny,
      'downloadCount': 'N/A',
      'rating': 4.2,
    },
    {
      'title': 'Netflix Clone - Streaming Platform',
      'description':
          'Complete Netflix clone using RESTful web services and TMDb API for comprehensive media streaming experience with modern UI design.',
      'technologies': ['Flutter', 'TMDb API', 'REST Services', 'Video Player'],
      'color': const Color(0xFFE74C3C),
      'platform': 'GitHub',
      'projectUrl': 'https://github.com/Dhanush-Pb/netflix_clone',
      'features': [
        'TMDb API integration for movie data',
        'Video streaming functionality',
        'Netflix-like UI/UX design',
        'Search & recommendation system'
      ],
      'type': 'Mini Projects',
      'icon': Icons.movie,
      'downloadCount': 'N/A',
      'rating': 4.5,
    },
    {
      'title': 'Student Manager - GetX Architecture',
      'description':
          'Student management application using GetX state management with Hive database for efficient data storage and modern Flutter UI design.',
      'technologies': ['Flutter', 'GetX', 'Hive', 'CRUD Operations'],
      'color': const Color(0xFF9B59B6),
      'platform': 'GitHub',
      'projectUrl': 'https://github.com/Dhanush-Pb/Getx-studentapap',
      'features': [
        'GetX state management implementation',
        'Hive local database integration',
        'Complete CRUD operations',
        'Clean & modern UI design'
      ],
      'type': 'Mini Projects',
      'icon': Icons.school,
      'downloadCount': 'N/A',
      'rating': 4.1,
    },
    {
      'title': 'Todo Manager - Provider Architecture',
      'description':
          'Task management application built with Provider state management and SQLite database for reliable data persistence and smooth user experience.',
      'technologies': ['Flutter', 'Provider', 'SQLite', 'Local Storage'],
      'color': const Color(0xFFF39C12),
      'platform': 'GitHub',
      'projectUrl': 'https://github.com/Dhanush-Pb/provider-tudu',
      'features': [
        'Provider state management pattern',
        'SQLite database for data persistence',
        'Task categorization & filtering',
        'Intuitive todo management interface'
      ],
      'type': 'Mini Projects',
      'icon': Icons.task_alt,
      'downloadCount': 'N/A',
      'rating': 4.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredProjects = projects;
  }

  void _filterProjects(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredProjects = projects;
      } else {
        filteredProjects =
            projects.where((project) => project['type'] == category).toList();
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Section Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.4),
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.work_outline,
                      color: Colors.white,
                      size: isMobile ? 28 : 36,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Projects ',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 28 : 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Crafting digital experiences & innovative solutions',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 14 : 18,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 6,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C63FF),
                      Color(0xFF3F3CF4),
                      Color(0xFF00B4D8)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // Enhanced Category Tabs
          SizedBox(
            height: 65,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryTab(
                    context, 'All', Icons.dashboard, selectedCategory == 'All'),
                _buildCategoryTab(context, 'Professional',
                    Icons.business_center, selectedCategory == 'Professional'),
                _buildCategoryTab(context, 'Open Source', Icons.code,
                    selectedCategory == 'Open Source'),
                _buildCategoryTab(context, 'Mini Projects', Icons.lightbulb,
                    selectedCategory == 'Mini Projects'),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Projects Count
          Text(
            ' ${selectedCategory == 'All' ? 'All' : selectedCategory} Projects',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 30),

          // Projects Grid with Staggered Animation
          AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : (size.width > 1400 ? 3 : 2),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile
                    ? 0.85
                    : 0.75, // Fixed aspect ratio for better space
              ),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  columnCount: isMobile ? 1 : (size.width > 1400 ? 3 : 2),
                  child: SlideAnimation(
                    verticalOffset: 60.0,
                    child: FadeInAnimation(
                      child: ProjectCard(
                        project: filteredProjects[index],
                        index: index,
                        onTap: () =>
                            _launchUrl(filteredProjects[index]['projectUrl']),
                        onLiveTap: filteredProjects[index]['liveUrl'] != null
                            ? () =>
                                _launchUrl(filteredProjects[index]['liveUrl'])
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(BuildContext context, String title, IconData icon,
      [bool isActive = false]) {
    return GestureDetector(
      onTap: () => _filterProjects(title),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isActive ? null : Colors.transparent,
          border: Border.all(
            color:
                isActive ? Colors.transparent : Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  final VoidCallback onTap;
  final VoidCallback? onLiveTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.onTap,
    this.onLiveTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final scrensize = MediaQuery.of(context).size;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color:
                  widget.project['color'].withOpacity(_isHovered ? 0.35 : 0.15),
              blurRadius: _isHovered ? 35 : 25,
              spreadRadius: _isHovered ? 5 : 2,
              offset: Offset(0, _isHovered ? 12 : 8),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.project['color'].withOpacity(0.12),
                  widget.project['color'].withOpacity(0.06),
                  Colors.black.withOpacity(0.4),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(_isHovered ? 0.25 : 0.15),
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Animated background pattern
                Positioned(
                  top: -60,
                  right: -60,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.project['color']
                              .withOpacity(_isHovered ? 0.15 : 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.project['color'].withOpacity(0.3),
                                  widget.project['color'].withOpacity(0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: widget.project['color'].withOpacity(0.4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      widget.project['color'].withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.project['icon'],
                              color: Colors.white,
                              size: isMobile ? 22 : 26,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.project['color'].withOpacity(0.25),
                                  widget.project['color'].withOpacity(0.15),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: widget.project['color'].withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              widget.project['type'],
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 10 : 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isMobile ? 12 : 20),

                      // Project Title
                      Text(
                        widget.project['title'],
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? 8 : 12),

                      // Platform Row
                      Row(
                        children: [
                          Icon(
                            widget.project['platform'] == 'GitHub'
                                ? Icons.code
                                : Icons.store,
                            size: isMobile ? 14 : 16,
                            color: widget.project['color'],
                          ),
                          SizedBox(width: isMobile ? 4 : 6),
                          Expanded(
                            child: Text(
                              widget.project['platform'],
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 13,
                                color: widget.project['color'],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: isMobile ? 12 : 16),

                      // Project Description
                      Text(
                        widget.project['description'],
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 13,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.4,
                        ),
                        maxLines: isMobile ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? 12 : 16),

                      // Key Features
                      Text(
                        'Key Features:',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 11 : 12,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: isMobile ? 6 : 8),

                      // Features List with proper spacing
                      ...((widget.project['features'] as List<String>)
                          .take(isMobile ? 3 : 4)
                          .map((feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      margin: const EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                        color: widget.project['color'],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: isMobile ? 6 : 8),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: GoogleFonts.poppins(
                                          fontSize: isMobile ? 10 : 11,
                                          color: Colors.white.withOpacity(0.8),
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ))).toList(),

                      SizedBox(height: isMobile ? 12 : 16),

                      // Technologies with proper wrapping
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (widget.project['technologies']
                                as List<String>)
                            .take(isMobile ? 4 : 6) // Limit technologies shown
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.project['color']
                                            .withOpacity(0.15),
                                        widget.project['color']
                                            .withOpacity(0.08),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: widget.project['color']
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 10 : 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),

                      SizedBox(
                          height: isMobile ? 11 : scrensize.height * 0.095),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: isMobile ? 38 : 42,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.project['color'],
                                    widget.project['color'].withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.project['color']
                                        .withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: widget.onTap,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          widget.project['platform'] == 'GitHub'
                                              ? Icons.code
                                              : Icons.store,
                                          color: Colors.white,
                                          size: isMobile ? 16 : 18,
                                        ),
                                        SizedBox(width: isMobile ? 6 : 8),
                                        Text(
                                          widget.project['platform'] == 'GitHub'
                                              ? 'View Code'
                                              : widget.project['platform'] ==
                                                      'pub.dev'
                                                  ? 'View Package'
                                                  : 'View App',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.onLiveTap != null) ...[
                            SizedBox(width: isMobile ? 8 : 12),
                            Expanded(
                              child: Container(
                                height: isMobile ? 38 : 42,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: widget.onLiveTap,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.launch,
                                            color: Colors.white,
                                            size: isMobile ? 16 : 18,
                                          ),
                                          SizedBox(width: isMobile ? 6 : 8),
                                          Text(
                                            'Live Demo',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isMobile ? 12 : 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
