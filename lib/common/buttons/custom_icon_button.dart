import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  // ignore: use_key_in_widget_constructors
  const CustomIconButton({this.iconData, this.color, this.onTap, this.size});

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: onTap == null ? Colors.grey[300] : color,
              size: size ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
