// Advanced Navbar with glassmorphism effect
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedNavbar extends StatelessWidget {
  final ScrollController scrollController;
  final int currentSection;
  final Function(int) onSectionTap;

  const AdvancedNavbar({
    super.key,
    required this.scrollController,
    required this.currentSection,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.flutter_dash, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF3F3CF4)],
                ).createShader(bounds),
                child: Text(
                  'Dhanush PB',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (!isMobile)
            Row(
              children: [
                _buildNavItem('Home', 0, Icons.home),
                _buildNavItem('About', 1, Icons.person),
                _buildNavItem('Projects', 2, Icons.work),
                _buildNavItem('Skills', 3, Icons.code),
                _buildNavItem('Contact', 4, Icons.contact_mail),
              ],
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _showMobileMenu(context),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index, IconData icon) {
    final isActive = currentSection == index;
    
    return GestureDetector(
      onTap: () => onSectionTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive ? Border.all(color: Colors.white.withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...[
              ('Home', 0, Icons.home),
              ('About', 1, Icons.person),
              ('Projects', 2, Icons.work),
              ('Skills', 3, Icons.code),
              ('Contact', 4, Icons.contact_mail),
            ].map((item) => ListTile(
              leading: Icon(item.$3, color: Colors.white),
              title: Text(item.$1, style: const TextStyle(color: Colors.white)),
              onTap: () {
                onSectionTap(item.$2);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
