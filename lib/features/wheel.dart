import 'dart:math';
import 'package:flutter/material.dart';

class EmotionWheelApp extends StatelessWidget {
  const EmotionWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: EmotionWheel()),
    );
  }
}

class EmotionWheel extends StatefulWidget {
  const EmotionWheel({super.key});

  @override
  State<EmotionWheel> createState() => _EmotionWheelState();
}

class _EmotionWheelState extends State<EmotionWheel> {
  final Map<String, Map<String, List<String>>> emotions = {
    "sad": {
      "hurt": ["disappointed", "embarrassed"],
      "depressed": ["unseen", "empty"],
      "guilty": ["ashamed", "remorseful"],
      "despair": ["powerless", "grief"],
      "vulnerable": ["victimized", "fragile"],
      "lonely": ["isolated", "abandoned"],
    },
    "bad": {
      "tired": ["unfocused", "sleepy"],
      "stressed": ["overwhelmed", "out of control"],
      "busy": ["rushed", "pressured"],
      "bored": ["indifferent", "apathetic"],
    },
    "disgusted": {
      "disappointed": ["appealed", "revolted"],
      "disapproving": ["judgmental", "commending"],
      "awful": ["detestable", "nauseated"],
      "repelled": ["horrified", "hesitant"],
    },
    "angry": {
      "letdown": ["betrayed", "resentful"],
      "humiliated": ["disrespected", "ridiculed"],
      "bitter": ["indignant", "violated"],
      "mad": ["furious", "jealous"],
      "aggressive": ["hostile", "provoked"],
      "frustrated": ["annoyed", "infuriated"],
      "distant": ["withdrawn", "numb"],
      "critical": ["skeptical", "dismissive"],
    },
    "happiness": {
      "optimistic": ["hopeful", "inspired"],
      "trusting": ["sensitive", "intimate"],
      "peaceful": ["loving", "thankful"],
      "powerful": ["courageous", "creative"],
      "accepted": ["respected", "valued"],
      "proud": ["successful", "confident"],
      "interested": ["curious", "inquisitive"],
      "content": ["free", "joyful"],
      "playful": ["aroused", "cheeky"],
    },
  };

  String? selectedPrimary;
  String? selectedSecondary;
  String? selectedTertiary;

  void _handleTap(Offset localPosition, Size size) {
    final dx = localPosition.dx - size.width / 2;
    final dy = localPosition.dy - size.height / 2;
    final distance = sqrt(dx * dx + dy * dy);
    final angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);

    final outerRadius = size.width / 2;

    final level = distance < 120
        ? 1
        : distance < 160
        ? 2
        : distance < 200
        ? 3
        : 0;

    if (level == 0) return;

    final primaryKeys = emotions.keys.toList();
    final primaryAngle = 2 * pi / primaryKeys.length;

    for (int i = 0; i < primaryKeys.length; i++) {
      final primary = primaryKeys[i];
      final startAngle = i * primaryAngle;
      final endAngle = startAngle + primaryAngle;

      if (angle >= startAngle && angle < endAngle) {
        final secondaryMap = emotions[primary]!;
        final secondaryKeys = secondaryMap.keys.toList();
        final secondaryAngle = primaryAngle / secondaryKeys.length;

        if (level == 1) {
          setState(() {
            selectedPrimary = primary;
            selectedSecondary = null;
            selectedTertiary = null;
          });
          return;
        }

        for (int j = 0; j < secondaryKeys.length; j++) {
          final secondary = secondaryKeys[j];
          final secondaryStartAngle = startAngle + j * secondaryAngle;
          final secondaryEndAngle = secondaryStartAngle + secondaryAngle;

          if (angle >= secondaryStartAngle && angle < secondaryEndAngle) {
            final tertiaryList = secondaryMap[secondary]!;
            final tertiaryAngle = secondaryAngle / tertiaryList.length;

            if (level == 2) {
              setState(() {
                selectedPrimary = primary;
                selectedSecondary = secondary;
                selectedTertiary = null;
              });
              return;
            }

            for (int k = 0; k < tertiaryList.length; k++) {
              final tertiaryStartAngle =
                  secondaryStartAngle + k * tertiaryAngle;
              final tertiaryEndAngle = tertiaryStartAngle + tertiaryAngle;
              if (angle >= tertiaryStartAngle && angle < tertiaryEndAngle) {
                setState(() {
                  selectedPrimary = primary;
                  selectedSecondary = secondary;
                  selectedTertiary = tertiaryList[k];
                });
                return;
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);
        _handleTap(localPosition, box.size);
      },
      child: CustomPaint(
        size: const Size(400, 400),
        painter: EmotionWheelPainter(
          emotions,
          selectedPrimary,
          selectedSecondary,
          selectedTertiary,
        ),
      ),
    );
  }
}

class EmotionWheelPainter extends CustomPainter {
  final Map<String, Map<String, List<String>>> data;
  final String? selectedPrimary;
  final String? selectedSecondary;
  final String? selectedTertiary;

  EmotionWheelPainter(
    this.data,
    this.selectedPrimary,
    this.selectedSecondary,
    this.selectedTertiary,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = size.width / 2;

    final primaryKeys = data.keys.toList();
    final primaryAngle = 2 * pi / primaryKeys.length;

    for (int i = 0; i < primaryKeys.length; i++) {
      final primary = primaryKeys[i];
      final secondaryMap = data[primary]!;
      final secondaryKeys = secondaryMap.keys.toList();

      final startAngle = i * primaryAngle;

      // Primary ring
      _drawArc(
        canvas,
        center,
        80,
        120,
        startAngle,
        primaryAngle,
        _getColor(primary, 1),
        primary,
      );

      final secondaryAngle = primaryAngle / secondaryKeys.length;
      for (int j = 0; j < secondaryKeys.length; j++) {
        final secondary = secondaryKeys[j];
        final tertiaryList = secondaryMap[secondary]!;

        final secondaryStartAngle = startAngle + j * secondaryAngle;

        // Secondary ring
        _drawArc(
          canvas,
          center,
          120,
          160,
          secondaryStartAngle,
          secondaryAngle,
          _getColor(secondary, 2),
          secondary,
        );

        final tertiaryAngle = secondaryAngle / tertiaryList.length;
        for (int k = 0; k < tertiaryList.length; k++) {
          final tertiary = tertiaryList[k];
          final tertiaryStartAngle = secondaryStartAngle + k * tertiaryAngle;

          // Tertiary ring
          _drawArc(
            canvas,
            center,
            160,
            200,
            tertiaryStartAngle,
            tertiaryAngle,
            _getColor(tertiary, 3),
            tertiary,
          );
        }
      }
    }
  }

  void _drawArc(
    Canvas canvas,
    Offset center,
    double innerRadius,
    double outerRadius,
    double startAngle,
    double sweepAngle,
    Color color,
    String label,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final steps = 30;
    for (int i = 0; i <= steps; i++) {
      final angle = startAngle + (sweepAngle / steps) * i;
      final x = center.dx + cos(angle) * outerRadius;
      final y = center.dy + sin(angle) * outerRadius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    for (int i = steps; i >= 0; i--) {
      final angle = startAngle + (sweepAngle / steps) * i;
      final x = center.dx + cos(angle) * innerRadius;
      final y = center.dy + sin(angle) * innerRadius;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Color _getColor(String name, int level) {
    final hue = name.hashCode % 360;
    final saturation = 0.7;

    final isSelected =
        name == selectedPrimary ||
        name == selectedSecondary ||
        name == selectedTertiary;
    final brightness = isSelected ? 0.75 : 0.4;
    return HSLColor.fromAHSL(
      1.0,
      hue.toDouble(),
      saturation,
      brightness,
    ).toColor();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
