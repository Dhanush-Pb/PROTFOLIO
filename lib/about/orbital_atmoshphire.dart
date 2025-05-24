import 'dart:math' as math;
import 'package:flutter/material.dart';

class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Create multiple layers of neural networks with reduced node count
    _drawNeuralLayer(canvas, size, 0.0, const Color(0xFF6C63FF), 15);
    _drawNeuralLayer(canvas, size, 0.3, const Color(0xFF00D4FF), 12);
    _drawNeuralLayer(canvas, size, 0.6, const Color(0xFF9C27B0), 10);
  }

  void _drawNeuralLayer(Canvas canvas, Size size, double timeOffset,
      Color baseColor, int nodeCount) {
    final paint = Paint()..strokeWidth = 2.5; // Increased line thickness

    // Generate random but consistent node positions
    final nodes = <Offset>[];
    final random =
        math.Random(42 + timeOffset.hashCode); // Fixed seed for consistency

    for (int i = 0; i < nodeCount; i++) {
      nodes.add(Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      ));
    }

    // Draw connections between nearby nodes with increased connection distance
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        final maxDistance =
            size.width * 0.6; // Increased connection range for thicker lines

        if (distance < maxDistance) {
          final opacity = (1 - distance / maxDistance) *
              0.3; // Increased opacity for thicker lines
          final pulseOpacity =
              (math.sin(animationValue * 3 + timeOffset + i * 0.5) + 1) / 2;

          paint.color = baseColor.withOpacity(opacity * pulseOpacity);
          paint.style = PaintingStyle.stroke;

          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw pulsing nodes
    for (int i = 0; i < nodes.length; i++) {
      final pulseSize =
          2 + (math.sin(animationValue * 2 + timeOffset + i * 0.3) + 1) * 2;
      final opacity = 0.4 +
          (math.sin(animationValue * 2.5 + timeOffset + i * 0.7) + 1) * 0.3;

      paint.color = baseColor.withOpacity(opacity);
      paint.style = PaintingStyle.fill;

      canvas.drawCircle(nodes[i], pulseSize, paint);

      // Outer glow
      paint.color = baseColor.withOpacity(opacity * 0.3);
      canvas.drawCircle(nodes[i], pulseSize + 3, paint);
    }

    // Add flowing data particles
    for (int i = 0; i < 8; i++) {
      // Increased from 5 to 8
      final progress = (animationValue + timeOffset + i * 0.15) % 1.0;
      final startNode = nodes[i % nodes.length];
      final endNode =
          nodes[(i + 3) % nodes.length]; // Changed connection pattern

      final particlePos = Offset.lerp(startNode, endNode, progress)!;
      final particleOpacity = math.sin(progress * math.pi) * 0.8;

      paint.color = Colors.white.withOpacity(particleOpacity);
      canvas.drawCircle(particlePos, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Usage Widget
class NeuralNetworkBackground extends StatefulWidget {
  final double? height;

  const NeuralNetworkBackground({Key? key, this.height}) : super(key: key);

  @override
  _NeuralNetworkBackgroundState createState() =>
      _NeuralNetworkBackgroundState();
}

class _NeuralNetworkBackgroundState extends State<NeuralNetworkBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
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
    return SizedBox(
      width: double.infinity,
      height: widget.height ?? 850, // Set height to 850 pixels
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: NeuralNetworkPainter(_controller.value),
            child: Container(),
          );
        },
      ),
    );
  }
}
