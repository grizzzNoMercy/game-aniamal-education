import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';

/// Primary pill-shaped button with 3D bottom border effect
/// Height: 72px, fully rounded, bottom shadow for depth
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final Color? borderColor;
  final double height;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.borderColor,
    this.height = 72,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.color ?? AppColors.primaryContainer;
    final darkBorder = widget.borderColor ??
        HSLColor.fromColor(bgColor)
            .withLightness(
              (HSLColor.fromColor(bgColor).lightness - 0.15).clamp(0.0, 1.0),
            )
            .toColor();

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9999),
          border: Border(
            bottom: BorderSide(
              color: _isPressed ? Colors.transparent : darkBorder,
              width: _isPressed ? 0 : 4,
            ),
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: darkBorder.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 28, color: Colors.white),
                const SizedBox(width: 12),
              ],
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
