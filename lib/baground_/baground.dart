// Enhanced Premium Animated Background with particles
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatelessWidget {
  final AnimationController particleController;
  final AnimationController rotationController;

  const AnimatedBackground({
    super.key,
    required this.particleController,
    required this.rotationController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0E27),
            Color(0xFF16213E),
            Color(0xFF1A1A2E),
            Color(0xFF0F3460),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for depth
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  const Color(0xFF4A90E2).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Medium particles with different movement
          ...List.generate(25, (index) {
            return AnimatedBuilder(
              animation: particleController,
              builder: (context, child) {
                final random = math.Random(index * 3 + 100);
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                final baseX = random.nextDouble() * screenWidth;
                final baseY = random.nextDouble() * screenHeight;

                final moveX = math.cos(
                        particleController.value * 3 * math.pi + index * 0.8) *
                    25;
                final moveY = math.sin(
                        particleController.value * 1.5 * math.pi +
                            index * 1.2) *
                    40;

                final opacity = (math.cos(
                            particleController.value * 3 * math.pi +
                                index * 0.3) +
                        1) /
                    2;
                final size = random.nextDouble() * 6 + 2;

                return Positioned(
                  left: baseX + moveX,
                  top: baseY + moveY,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF81C784).withOpacity(opacity * 0.5),
                          const Color(0xFF4CAF50).withOpacity(opacity * 0.2),
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF81C784)
                              .withOpacity(opacity * 0.2),
                          blurRadius: size * 1.5,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),

          // Small twinkling particles
          ...List.generate(60, (index) {
            return AnimatedBuilder(
              animation: particleController,
              builder: (context, child) {
                final random = math.Random(index * 5 + 200);
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                final x = random.nextDouble() * screenWidth;
                final y = random.nextDouble() * screenHeight;

                final twinkle = math
                    .sin(particleController.value * 4 * math.pi + index * 0.1);
                final opacity = (twinkle * twinkle) * 0.8;
                final size = random.nextDouble() * 3 + 1;

                return Positioned(
                  left: x,
                  top: y,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(opacity),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(opacity * 0.5),
                          blurRadius: size * 3,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),

          // Subtle grid overlay for premium feel
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF1A1A2E).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
