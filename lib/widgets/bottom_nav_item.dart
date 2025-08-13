import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Map<String, List<Map<String, dynamic>>>? categoryData; 

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.categoryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.blue : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
