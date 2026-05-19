import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/data/models/animal.dart';
import 'package:game_edukasi/screens/encyclopedia/encyclopedia_screen.dart';
import 'package:game_edukasi/screens/quiz/quiz_screen.dart';
import 'package:game_edukasi/screens/animal_detail/animal_detail_screen.dart';

/// Home Screen — Main landing page
/// Features logo, greeting, 3 navigation cards, animal of the day
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Animal get _animalOfTheDay {
    final dayIndex = DateTime.now().day % AnimalData.animals.length;
    return AnimalData.animals[dayIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Header with bouncing emoji
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: child,
                ),
                child: const Text('🦁', style: TextStyle(fontSize: 64)),
              ),
              const SizedBox(height: 12),
              Text(
                'Animal Explorer',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Ayo belajar tentang hewan! 🌿',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.warmBrown,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Navigation Cards
              _NavigationCard(
                emoji: '📚',
                title: 'Ensiklopedia',
                subtitle: 'Kenali 10 hewan seru!',
                color: AppColors.pastelGreen,
                accentColor: AppColors.primaryContainer,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EncyclopediaScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _NavigationCard(
                emoji: '🧠',
                title: 'Quiz Time!',
                subtitle: 'Uji pengetahuanmu!',
                color: AppColors.pastelYellow,
                accentColor: AppColors.secondaryContainer,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                ),
              ),
              const SizedBox(height: 32),

              // Animal of the Day
              _AnimalOfTheDayCard(
                animal: _animalOfTheDay,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AnimalDetailScreen(animal: _animalOfTheDay),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bottom decoration
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('🌳', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 8),
                  Text('🐘', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 8),
                  Text('🌿', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 8),
                  Text('🦒', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 8),
                  Text('🌳', style: TextStyle(fontSize: 32)),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation card with pastel background and 3D effect
class _NavigationCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const _NavigationCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_NavigationCard> createState() => _NavigationCardState();
}

class _NavigationCardState extends State<_NavigationCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final darkBorder = HSLColor.fromColor(widget.accentColor)
        .withLightness(
          (HSLColor.fromColor(widget.accentColor).lightness - 0.15)
              .clamp(0.0, 1.0),
        )
        .toColor();

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: darkBorder.withValues(alpha: 0.3), width: 2),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Large emoji icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  widget.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.warmBrown,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            // Arrow
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.accentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animal of the Day showcase card
class _AnimalOfTheDayCard extends StatelessWidget {
  final Animal animal;
  final VoidCallback onTap;

  const _AnimalOfTheDayCard({
    required this.animal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryContainer.withValues(alpha: 0.3),
              AppColors.tertiaryContainer.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primaryContainer.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text('⭐', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Hewan Hari Ini',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              animal.emoji,
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 12),
            Text(
              animal.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.warmBrown,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              animal.funFact,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Pelajari lebih lanjut →',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
