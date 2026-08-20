import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Placeholder consultation scene for the welcome screen.
/// Swap this widget for `Image.asset('assets/images/welcome_consultation.png')`
/// when the final illustration file is added to assets.
class WelcomeConsultationIllustration extends StatelessWidget {
  const WelcomeConsultationIllustration({super.key, this.height = 196});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: const CustomPaint(painter: _ConsultationPainter()),
    );
  }
}

class _ConsultationPainter extends CustomPainter {
  const _ConsultationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final tableY = size.height * 0.72;
    final center = Offset(size.width / 2, tableY);

    final tablePaint = Paint()..color = const Color(0xFFC4A574).withValues(alpha: 0.92);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: size.width * 0.78, height: 18),
        const Radius.circular(8),
      ),
      tablePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.18, tableY + 6, size.width * 0.64, 10),
        const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFFA78454),
    );

    _drawPlant(canvas, Offset(size.width * 0.28, tableY - 8), 22);
    _drawBowl(canvas, Offset(size.width * 0.5, tableY - 6));
    _drawBottle(canvas, Offset(size.width * 0.68, tableY - 8));

    _drawPerson(
      canvas: canvas,
      origin: Offset(size.width * 0.30, tableY - 18),
      facingRight: true,
      coat: Colors.white,
      hair: const Color(0xFF3E2A1F),
      skin: const Color(0xFFE8C4A8),
    );
    _drawPerson(
      canvas: canvas,
      origin: Offset(size.width * 0.70, tableY - 18),
      facingRight: false,
      coat: const Color(0xFF8FBF9A),
      hair: const Color(0xFF2C1B12),
      skin: const Color(0xFFD8A07A),
    );

    final bubble = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.22), width: 36, height: 28),
          const Radius.circular(12),
        ),
      );
    canvas.drawPath(bubble, Paint()..color = AppColors.mist);
    _drawHeart(canvas, Offset(size.width * 0.5, size.height * 0.215), 7, AppColors.forest);
  }

  void _drawPerson({
    required Canvas canvas,
    required Offset origin,
    required bool facingRight,
    required Color coat,
    required Color hair,
    required Color skin,
  }) {
    final dir = facingRight ? 1.0 : -1.0;
    canvas.drawOval(Rect.fromCenter(center: origin.translate(0, -52), width: 28, height: 32), Paint()..color = skin);
    canvas.drawOval(Rect.fromCenter(center: origin.translate(0, -62), width: 30, height: 18), Paint()..color = hair);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: origin.translate(0, -18), width: 42, height: 44),
        const Radius.circular(14),
      ),
      Paint()..color = coat,
    );
    canvas.drawLine(
      origin.translate(dir * 18, -28),
      origin.translate(dir * 34, -8),
      Paint()
        ..color = coat
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawBowl(Canvas canvas, Offset origin) {
    final path = Path()
      ..moveTo(origin.dx - 18, origin.dy - 6)
      ..quadraticBezierTo(origin.dx, origin.dy + 16, origin.dx + 18, origin.dy - 6)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFFE7EEE6));
    canvas.drawCircle(origin.translate(-6, -8), 5, Paint()..color = const Color(0xFFD46A4C));
    canvas.drawCircle(origin.translate(4, -10), 6, Paint()..color = const Color(0xFFE29B3C));
    canvas.drawCircle(origin.translate(10, -6), 5, Paint()..color = AppColors.forest);
  }

  void _drawBottle(Canvas canvas, Offset origin) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: origin.translate(0, -14), width: 12, height: 28), const Radius.circular(4)),
      Paint()..color = const Color(0xFFD7E8F2).withValues(alpha: 0.95),
    );
    canvas.drawRect(Rect.fromCenter(center: origin.translate(0, -30), width: 6, height: 8), Paint()..color = AppColors.sage);
  }

  void _drawPlant(Canvas canvas, Offset origin, double size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: origin, width: 16, height: 10), const Radius.circular(3)),
      Paint()..color = const Color(0xFFC9B8A0),
    );
    canvas.drawLine(
      origin.translate(0, -4),
      origin.translate(0, -size),
      Paint()
        ..color = AppColors.forest
        ..strokeWidth = 2,
    );
    canvas.drawOval(Rect.fromCenter(center: origin.translate(-8, -size + 4), width: 14, height: 8), Paint()..color = AppColors.sage);
    canvas.drawOval(Rect.fromCenter(center: origin.translate(8, -size + 2), width: 14, height: 8), Paint()..color = AppColors.forest);
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Color color) {
    final path = Path()
      ..moveTo(center.dx, center.dy + size * 0.6)
      ..cubicTo(center.dx - size * 1.6, center.dy - size * 0.1, center.dx - size * 0.5, center.dy - size * 1.2, center.dx, center.dy - size * 0.35)
      ..cubicTo(center.dx + size * 0.5, center.dy - size * 1.2, center.dx + size * 1.6, center.dy - size * 0.1, center.dx, center.dy + size * 0.6);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WelcomeBackdrop extends StatelessWidget {
  const WelcomeBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFBF8F1), AppColors.parchment, Color(0xFFEEF6F0)],
        ),
      ),
      child: CustomPaint(painter: _LeafBackdropPainter(), child: SizedBox.expand()),
    );
  }
}

class _LeafBackdropPainter extends CustomPainter {
  const _LeafBackdropPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.forest.withValues(alpha: 0.05);
    final sage = Paint()..color = AppColors.sage.withValues(alpha: 0.07);

    canvas.save();
    canvas.translate(size.width * 0.92, size.height * 0.04);
    canvas.rotate(-0.4);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 160, height: 70), paint);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width * 0.08, size.height * 0.88);
    canvas.rotate(0.6);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: 180, height: 80), sage);
    canvas.restore();

    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.08), 70, Paint()..color = const Color(0xFFDDE8D8).withValues(alpha: 0.35));
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.72), 90, Paint()..color = AppColors.mist.withValues(alpha: 0.55));

    final leaf = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(18, -28, 0, -56)
      ..quadraticBezierTo(-18, -28, 0, 0);
    canvas.save();
    canvas.translate(24, 48);
    canvas.rotate(-math.pi / 5);
    canvas.drawPath(leaf, Paint()..color = AppColors.forest.withValues(alpha: 0.06));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
