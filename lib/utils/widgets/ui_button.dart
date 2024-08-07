import 'package:flutter/material.dart';

class UiButton extends StatefulWidget {
  final Widget icon;
  final String value;
  final VoidCallback onTap;
  const UiButton({super.key, required this.icon, required this.value, required this.onTap});

  @override
  State<UiButton> createState() => _UiButtonState();
}

class _UiButtonState extends State<UiButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30.0, width: 30.0, child: widget.icon),
          const SizedBox(height: 8.0),
          Text(
            widget.value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black.withOpacity(0.25), blurRadius: 1.0)]),
          ),
        ],
      ),
    );
  }
}
