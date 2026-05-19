import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/data/models/animal.dart';

/// Animal card for Encyclopedia grid
/// 20px radius, pastel background, thick outline, large emoji icon
class AnimalCard extends StatefulWidget {
  final Animal animal;
  final VoidCallback onTap;

  const AnimalCard({
    super.key,
    required this.animal,
    required this.onTap,
  });

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkBorder = HSLColor.fromColor(widget.animal.cardColor)
        .withLightness(
          (HSLColor.fromColor(widget.animal.cardColor).lightness - 0.1)
              .clamp(0.0, 1.0),
        )
        .toColor();

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.animal.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: darkBorder, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large emoji
              Text(
                widget.animal.emoji,
                style: const TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 12),
              // Animal name
              Text(
                widget.animal.name,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.warmBrown,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              // Habitat tag
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  widget.animal.category,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
