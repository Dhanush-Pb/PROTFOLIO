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
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 80, vertical: isMobile ? 30 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Section Header - Mobile Optimized
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.4),
                          blurRadius: isMobile ? 15 : 25,
                          spreadRadius: isMobile ? 2 : 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.work_outline,
                      color: Colors.white,
                      size: isMobile ? 24 : 36,
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Projects',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 24 : 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: isMobile ? 4 : 8),
                        Text(
                          'Crafting digital experiences & innovative solutions',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 12 : 18,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Container(
                height: 4,
                width: isMobile ? 100 : 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C63FF),
                      Color(0xFF3F3CF4),
                      Color(0xFF00B4D8)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.6),
                      blurRadius: isMobile ? 8 : 12,
                      spreadRadius: isMobile ? 1 : 2,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // Category Tabs - Mobile Optimized
          SizedBox(
            height: isMobile ? 50 : 65,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: isMobile ? 8 : 0), // Add some padding on mobile
                _buildCategoryTab(
                    context, 'All', Icons.dashboard, selectedCategory == 'All'),
                _buildCategoryTab(context, 'Professional',
                    Icons.business_center, selectedCategory == 'Professional'),
                _buildCategoryTab(context, 'Open Source', Icons.code,
                    selectedCategory == 'Open Source'),
                _buildCategoryTab(context, 'Mini Projects', Icons.lightbulb,
                    selectedCategory == 'Mini Projects'),
                SizedBox(width: isMobile ? 8 : 0), // Add some padding on mobile
              ],
            ),
          ),

          SizedBox(height: isMobile ? 24 : 40),

          // Projects Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
            child: Text(
              '${filteredProjects.length} ${selectedCategory == 'All' ? 'All' : selectedCategory} Projects',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 16 : 30),

          // Projects Grid with Staggered Animation - Mobile Optimized
          AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : (size.width > 1400 ? 3 : 2),
                crossAxisSpacing: isMobile ? 12 : 20,
                mainAxisSpacing: isMobile ? 12 : 20,
                childAspectRatio:
                    isMobile ? 3.2 : 0.75, // Fixed ratio for mobile cheat cards
              ),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  columnCount: isMobile ? 1 : (size.width > 1400 ? 3 : 2),
                  child: SlideAnimation(
                    verticalOffset: isMobile ? 40.0 : 60.0,
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
                        isMobile: isMobile,
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

  Widget _buildCategoryTab(BuildContext context, String title, IconData icon,
      [bool isActive = false]) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return GestureDetector(
      onTap: () => _filterProjects(title),
      child: Container(
        margin: EdgeInsets.only(right: isMobile ? 8 : 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
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
                    blurRadius: isMobile ? 15 : 20,
                    spreadRadius: isMobile ? 1 : 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, vertical: isMobile ? 10 : 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isMobile ? 18 : 20,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
            ),
            SizedBox(width: isMobile ? 6 : 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                fontSize: isMobile ? 13 : 15,
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
  final bool isMobile;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.onTap,
    this.onLiveTap,
    required this.isMobile,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _showProjectDetails() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.project['color'].withOpacity(0.15),
                  widget.project['color'].withOpacity(0.08),
                  Colors.black.withOpacity(0.6),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.project['color'].withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with close button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
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
                        ),
                        child: Icon(
                          widget.project['icon'],
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.project['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
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
                                  color:
                                      widget.project['color'].withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                widget.project['type'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Platform and Download Count
                        Row(
                          children: [
                            Icon(
                              widget.project['platform'] == 'GitHub'
                                  ? Icons.code
                                  : Icons.store,
                              size: 16,
                              color: widget.project['color'],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.project['platform'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: widget.project['color'],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.project['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Key Features
                        Text(
                          'Key Features',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        ...(widget.project['features'] as List<String>)
                            .map((feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(top: 8),
                                        decoration: BoxDecoration(
                                          color: widget.project['color'],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          feature,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),

                        const SizedBox(height: 24),

                        // Technologies
                        Text(
                          'Technologies Used',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (widget.project['technologies']
                                  as List<String>)
                              .map((tech) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          widget.project['color']
                                              .withOpacity(0.2),
                                          widget.project['color']
                                              .withOpacity(0.1),
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
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.project['color'],
                                widget.project['color'].withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: widget.project['color'].withOpacity(0.4),
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
                              onTap: () {
                                Navigator.of(context).pop();
                                widget.onTap();
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      widget.project['platform'] == 'GitHub'
                                          ? Icons.code
                                          : Icons.store,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
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
                                        fontSize: 14,
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 50,
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
                                onTap: () {
                                  Navigator.of(context).pop();
                                  widget.onLiveTap!();
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.launch,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Live Demo',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // For mobile, show compact card
    if (widget.isMobile) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _showProjectDetails, // Show popup on tap
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 120, // Fixed small height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.project['color'].withOpacity(0.15),
                  widget.project['color'].withOpacity(0.08),
                  Colors.black.withOpacity(0.4),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(_isHovered ? 0.3 : 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.project['color']
                      .withOpacity(_isHovered ? 0.3 : 0.15),
                  blurRadius: _isHovered ? 20 : 15,
                  spreadRadius: _isHovered ? 2 : 1,
                  offset: Offset(0, _isHovered ? 6 : 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.project['color'].withOpacity(0.3),
                          widget.project['color'].withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.project['color'].withOpacity(0.4),
                      ),
                    ),
                    child: Icon(
                      widget.project['icon'],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.project['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.project['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        // Platform badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: widget.project['color'].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.project['color'].withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            widget.project['type'],
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.6),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // For desktop, show full card (your existing desktop code)
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              size: 26,
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
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Project Title
                      Text(
                        widget.project['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 12),

                      // Platform Row
                      Row(
                        children: [
                          Icon(
                            widget.project['platform'] == 'GitHub'
                                ? Icons.code
                                : Icons.store,
                            size: 16,
                            color: widget.project['color'],
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.project['platform'],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: widget.project['color'],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (widget.project['downloadCount'] != 'N/A')
                            Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  size: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.project['downloadCount'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Project Description
                      Text(
                        widget.project['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.4,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 16),

                      // Key Features
                      Text(
                        'Key Features:',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Features List
                      ...((widget.project['features'] as List<String>)
                          .take(4)
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
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.white.withOpacity(0.8),
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()),

                      const SizedBox(height: 16),

                      // Technologies
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children:
                            (widget.project['technologies'] as List<String>)
                                .take(6)
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
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                      ),

                      const Spacer(),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 42,
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
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: 42,
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
                                          const Icon(
                                            Icons.launch,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Live Demo',
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
