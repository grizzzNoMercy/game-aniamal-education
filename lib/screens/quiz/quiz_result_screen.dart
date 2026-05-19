import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/screens/quiz/quiz_screen.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  const QuizResultScreen({super.key, required this.score, required this.total});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _starController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _starController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)
      ..repeat(reverse: true);
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _starController.dispose();
    super.dispose();
  }

  String get _emoji {
    final pct = widget.score / widget.total;
    if (pct == 1.0) return '🏆';
    if (pct >= 0.8) return '🌟';
    if (pct >= 0.6) return '😊';
    if (pct >= 0.4) return '💪';
    return '📚';
  }

  String get _message {
    final pct = widget.score / widget.total;
    if (pct == 1.0) return 'Sempurna! Kamu luar biasa!';
    if (pct >= 0.8) return 'Hebat! Hampir sempurna!';
    if (pct >= 0.6) return 'Bagus! Terus belajar ya!';
    if (pct >= 0.4) return 'Lumayan! Coba lagi yuk!';
    return 'Ayo belajar lagi!';
  }

  Color get _bgColor {
    final pct = widget.score / widget.total;
    if (pct >= 0.8) return AppColors.pastelGreen;
    if (pct >= 0.6) return AppColors.pastelYellow;
    return AppColors.pastelBlue;
  }

  int get _starCount {
    final pct = widget.score / widget.total;
    if (pct == 1.0) return 3;
    if (pct >= 0.6) return 2;
    if (pct >= 0.4) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated emoji
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (_, child) => Transform.scale(scale: _scaleAnimation.value, child: child),
                  child: Text(_emoji, style: const TextStyle(fontSize: 100)),
                ),
                const SizedBox(height: 24),

                // Stars
                AnimatedBuilder(
                  animation: _starController,
                  builder: (context, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      final filled = i < _starCount;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Transform.scale(
                          scale: filled ? 1.0 + (_starController.value * 0.1) : 0.8,
                          child: Text(
                            filled ? '⭐' : '☆',
                            style: TextStyle(fontSize: filled ? 40 : 32),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),

                // Score
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.outlineVariant, width: 2),
                  ),
                  child: Column(children: [
                    Text('Skor Kamu',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Text('${widget.score} / ${widget.total}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.primary)),
                  ]),
                ),
                const SizedBox(height: 16),

                // Message
                Text(_message,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.warmBrown),
                    textAlign: TextAlign.center),
                const SizedBox(height: 40),

                // Buttons
                _ResultButton(
                  label: 'Main Lagi 🔄',
                  color: AppColors.primaryContainer,
                  onTap: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const QuizScreen())),
                ),
                const SizedBox(height: 12),
                _ResultButton(
                  label: 'Kembali ke Home 🏠',
                  color: AppColors.secondaryContainer,
                  onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultButton extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ResultButton({required this.label, required this.color, required this.onTap});

  @override
  State<_ResultButton> createState() => _ResultButtonState();
}

class _ResultButtonState extends State<_ResultButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final dark = HSLColor.fromColor(widget.color)
        .withLightness((HSLColor.fromColor(widget.color).lightness - 0.15).clamp(0.0, 1.0)).toColor();
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 64, width: double.infinity,
        transform: Matrix4.translationValues(0, _pressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(9999),
          border: Border(bottom: BorderSide(color: _pressed ? Colors.transparent : dark, width: _pressed ? 0 : 4)),
          boxShadow: _pressed ? [] : [BoxShadow(color: dark.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Center(child: Text(widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white, fontSize: 18))),
      ),
    );
  }
}
