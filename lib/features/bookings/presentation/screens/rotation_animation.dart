import 'dart:math';

import 'package:flutter/material.dart';

class Rotation extends StatefulWidget {
  const Rotation({super.key});

  @override
  State<Rotation> createState() => _RotationState();
}

class _RotationState extends State<Rotation>
    with SingleTickerProviderStateMixin {
  final int itemCount = 8;
  int selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  void rotateToNext() {
    setState(() {
      selectedIndex = (selectedIndex + 1) % itemCount;
      _rotationAnimation = Tween<double>(
        begin: _rotationAnimation.value,
        end: _rotationAnimation.value - (2 * pi / itemCount),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildItem(int index, double radius, double angle) {
    final isSelected = index == selectedIndex;

    final item = circularItems[index];
    final offset = Offset(radius * cos(angle), radius * sin(angle));

    return Transform.translate(
      offset: offset,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        width: isSelected ? 80 : 50,
        height: isSelected ? 80 : 50,
        decoration: BoxDecoration(
          color: item['color'],
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black26, blurRadius: 8)]
              : [],
        ),
        alignment: Alignment.center,
        child: isSelected
            ? FadeTransition(
                opacity: _fadeAnimation,
                child: Icon(item['icon'], size: 50, color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = 100.0;
    double baseRotationOffset = pi / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Circular Selector')),
      body: Center(
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    height: 210,
                    width: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                ...List.generate(itemCount, (index) {
                  double angle =
                      (2 * pi * index / itemCount) +
                      _rotationAnimation.value +
                      baseRotationOffset;
                  return _buildItem(index, radius, angle);
                }),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: rotateToNext,
        label: Text('Next'),
        icon: Icon(Icons.rotate_right),
      ),
    );
  }
}

final List circularItems = [
  {'color': Colors.red, 'icon': Icons.home},
  {'color': Colors.yellow, 'icon': Icons.person},
  {'color': Colors.tealAccent, 'icon': Icons.local_activity_outlined},
  {'color': Colors.green, 'icon': Icons.pin},
  {'color': Colors.greenAccent, 'icon': Icons.location_on},
  {'color': Colors.pink, 'icon': Icons.add_shopping_cart},
  {'color': Colors.blueAccent, 'icon': Icons.ballot_outlined},
  {'color': Colors.purple, 'icon': Icons.file_download},
  {'color': Colors.indigo, 'icon': Icons.filter_drama_sharp},
];
