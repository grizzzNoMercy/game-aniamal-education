import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/data/models/animal.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;
  const AnimalDetailScreen({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero header
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: animal.cardColor,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: AppColors.warmBrown),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: _AudioButton(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [animal.cardColor, animal.cardColor.withValues(alpha: 0.5)],
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'animal_${animal.id}',
                    child: Text(animal.emoji, style: const TextStyle(fontSize: 120)),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Sound
                    Center(
                      child: Column(children: [
                        Text(animal.name, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.warmBrown)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: animal.cardColor, borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(animal.sound, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.warmBrown)),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 32),

                    // Info cards
                    _InfoCard(icon: '🏠', title: 'Habitat', value: animal.habitat, color: AppColors.pastelGreen),
                    const SizedBox(height: 12),
                    _InfoCard(icon: '🍽️', title: 'Makanan', value: animal.diet, color: AppColors.pastelOrange),
                    const SizedBox(height: 12),
                    _InfoCard(icon: '⭐', title: 'Fakta Seru', value: animal.funFact, color: AppColors.pastelYellow),
                    const SizedBox(height: 24),

                    // Description
                    Text('Tentang ${animal.name}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.warmBrown)),
                    const SizedBox(height: 12),
                    Text(animal.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant, height: 1.6)),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AudioButton extends StatefulWidget {
  @override
  State<_AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<_AudioButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { _controller.forward().then((_) => _controller.reverse()); },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.scale(scale: 1.0 + (_controller.value * 0.1), child: child),
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer, shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.secondaryContainer.withValues(alpha: 0.5), blurRadius: 8)],
          ),
          child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final Color color;

  const _InfoCard({required this.icon, required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final borderColor = HSLColor.fromColor(color)
        .withLightness((HSLColor.fromColor(color).lightness - 0.08).clamp(0.0, 1.0)).toColor();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 32)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.warmBrown, fontWeight: FontWeight.w600)),
        ])),
      ]),
    );
  }
}
