import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';

/// Quiz progress dots indicator
/// Active dot: 24px, Sunny Yellow | Inactive: 16px, Soft Gray
class ProgressDots extends StatelessWidget {
  final int total;
  final int current;

  const ProgressDots({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == current;
        final isCompleted = index < current;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 16,
          height: isActive ? 24 : 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.secondaryContainer
                : isCompleted
                    ? AppColors.primaryContainer
                    : AppColors.surfaceContainerHigh,
            border: isActive
                ? Border.all(
                    color: AppColors.secondary,
                    width: 2,
                  )
                : null,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 10, color: Colors.white)
              : null,
        );
      }),
    );
  }
}
