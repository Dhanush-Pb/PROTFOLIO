import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// Enhanced Neural Network with Space-like Blur Effects
class SpaceNeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  SpaceNeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Create starfield background
    _drawStarField(canvas, size);

    // Create multiple neural layers with different effects - REDUCED NODE COUNTS
    _drawEnhancedNeuralLayer(canvas, size, 0.0, const Color(0xFF4A90E2), 15,
        true); // Reduced from 25 to 15
    _drawEnhancedNeuralLayer(canvas, size, 0.4, const Color(0xFF9B59B6), 12,
        false); // Reduced from 20 to 12
    _drawEnhancedNeuralLayer(canvas, size, 0.8, const Color(0xFF3498DB), 10,
        true); // Reduced from 15 to 10
    _drawEnhancedNeuralLayer(canvas, size, 1.2, const Color(0xFF5DADE2), 8,
        false); // Reduced from 12 to 8

    // Add energy waves
    _drawEnergyWaves(canvas, size);
  }

  void _drawStarField(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(123);

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final twinkle = (math.sin(animationValue * 4 + i * 0.1) + 1) / 2;
      final brightness = (random.nextDouble() * 0.5 + 0.2).clamp(0.0, 1.0);

      paint.color =
          Colors.white.withOpacity((brightness * twinkle).clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 1.5 + 0.5, paint);
    }
  }

  void _drawEnhancedNeuralLayer(Canvas canvas, Size size, double timeOffset,
      Color baseColor, int nodeCount, bool hasGlow) {
    final paint = Paint()..strokeWidth = 2.0;
    final glowPaint = Paint()
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3.0);

    // Generate nodes with orbital motion
    final nodes = <Offset>[];
    final random = math.Random(42 + timeOffset.hashCode);

    for (int i = 0; i < nodeCount; i++) {
      final baseX = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final orbitRadius = 20 + random.nextDouble() * 30;
      final orbitSpeed = 0.5 + random.nextDouble() * 1.5;

      final orbitX = baseX +
          math.cos(animationValue * orbitSpeed + timeOffset + i) * orbitRadius;
      final orbitY = baseY +
          math.sin(animationValue * orbitSpeed + timeOffset + i) * orbitRadius;

      nodes.add(Offset(
        orbitX.clamp(orbitRadius, size.width - orbitRadius),
        orbitY.clamp(orbitRadius, size.height - orbitRadius),
      ));
    }

    // Draw enhanced connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        final maxDistance = size.width * 0.25;

        if (distance < maxDistance) {
          final opacity = ((1 - distance / maxDistance) * 0.3).clamp(0.0, 1.0);
          final energyPulse =
              (math.sin(animationValue * 4 + timeOffset + i * 0.8) + 1) / 2;
          final finalOpacity =
              (opacity * (0.5 + energyPulse * 0.5)).clamp(0.0, 1.0);

          // Glow effect for connections
          if (hasGlow) {
            glowPaint.color =
                baseColor.withOpacity((finalOpacity * 0.4).clamp(0.0, 1.0));
            canvas.drawLine(nodes[i], nodes[j], glowPaint);
          }

          // Main connection line
          paint.color = baseColor.withOpacity(finalOpacity);
          paint.style = PaintingStyle.stroke;
          canvas.drawLine(nodes[i], nodes[j], paint);

          // Energy flow particles along connections
          final particleCount = 3;
          for (int p = 0; p < particleCount; p++) {
            final progress = (animationValue * 2 + timeOffset + p * 0.33) % 1.0;
            final particlePos = Offset.lerp(nodes[i], nodes[j], progress)!;
            final particleOpacity =
                (math.sin(progress * math.pi) * finalOpacity).clamp(0.0, 1.0);

            paint.color = const Color(0xFFB0C4DE).withOpacity(particleOpacity);
            paint.style = PaintingStyle.fill;
            canvas.drawCircle(particlePos, 1.0, paint);
          }
        }
      }
    }

    // Draw enhanced nodes with multiple layers - REDUCED SIZES
    for (int i = 0; i < nodes.length; i++) {
      final pulseSize =
          1.5 + (math.sin(animationValue * 3 + timeOffset + i * 0.4) + 1) * 1.5;
      final coreOpacity = (0.6 +
              (math.sin(animationValue * 2.5 + timeOffset + i * 0.9) + 1) * 0.4)
          .clamp(0.0, 1.0);

      // Outer glow ring - REDUCED SIZE
      if (hasGlow) {
        paint.color =
            baseColor.withOpacity((coreOpacity * 0.2).clamp(0.0, 1.0));
        paint.style = PaintingStyle.fill;
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
        canvas.drawCircle(nodes[i], pulseSize + 4, paint);
        paint.maskFilter = null;
      }

      // Middle ring - REDUCED SIZE
      paint.color = baseColor.withOpacity((coreOpacity * 0.5).clamp(0.0, 1.0));
      canvas.drawCircle(nodes[i], pulseSize + 1, paint);

      // Core node - MOODY COLOR
      paint.color = const Color(0xFF8A9BA8).withOpacity(coreOpacity);
      canvas.drawCircle(nodes[i], pulseSize * 0.6, paint);

      // Inner bright spot - MOODY COLOR & REDUCED SIZE
      paint.color = const Color(0xFFB0C4DE).withOpacity(0.8);
      canvas.drawCircle(nodes[i], pulseSize * 0.15, paint);
    }
  }

  void _drawEnergyWaves(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < 3; i++) {
      final waveOffset = animationValue * 2 + i * 2;
      final opacity = (math.sin(animationValue * 2 + i) + 1) / 4;

      paint.color =
          const Color(0xFF85C1E9).withOpacity(opacity); // Space blue color
      paint.maskFilter = const MaskFilter.blur(BlurStyle.outer, 2.0);

      final path = Path();
      for (double x = 0; x <= size.width; x += 5) {
        final y = size.height / 2 +
            math.sin((x / size.width) * 4 * math.pi + waveOffset) * 30 +
            math.sin((x / size.width) * 8 * math.pi + waveOffset * 1.5) * 15;

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
      paint.maskFilter = null;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Usage Widget - Transparent Background
class SpaceNeuralNetworkBackground extends StatefulWidget {
  final double? height;

  const SpaceNeuralNetworkBackground({Key? key, this.height}) : super(key: key);

  @override
  _SpaceNeuralNetworkBackgroundState createState() =>
      _SpaceNeuralNetworkBackgroundState();
}

class _SpaceNeuralNetworkBackgroundState
    extends State<SpaceNeuralNetworkBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height ?? 400,
      // Removed background gradient - now transparent
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: SpaceNeuralNetworkPainter(_controller.value),
            child: Container(),
          );
        },
      ),
    );
  }
}