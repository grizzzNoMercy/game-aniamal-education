import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/data/models/quiz_question.dart';
import 'package:game_edukasi/widgets/progress_dots.dart';
import 'package:game_edukasi/screens/quiz/quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _questions = QuizData.getRandomQuestions(5);
    _shakeController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _shakeAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _bounceController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() { _selectedAnswer = index; _answered = true; });
    final isCorrect = index == _questions[_currentIndex].correctIndex;
    if (isCorrect) {
      _score++;
      _bounceController.forward().then((_) => _bounceController.reverse());
    } else {
      _shakeController.forward().then((_) => _shakeController.reverse());
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() { _currentIndex++; _selectedAnswer = null; _answered = false; });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => QuizResultScreen(score: _score, total: _questions.length),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          const Text('🧠', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          Text('Quiz Time!', style: Theme.of(context).textTheme.headlineMedium),
        ]),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            // Progress
            ProgressDots(total: _questions.length, current: _currentIndex),
            const SizedBox(height: 8),
            Text('Pertanyaan ${_currentIndex + 1} dari ${_questions.length}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 24),

            // Question card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.pastelBlue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBBDEFB), width: 2),
              ),
              child: Column(children: [
                const Text('❓', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                Text(question.question,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.warmBrown),
                    textAlign: TextAlign.center),
              ]),
            ),
            const SizedBox(height: 24),

            // Options
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: question.options.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _OptionButton(
                    label: question.options[index],
                    index: index,
                    isSelected: _selectedAnswer == index,
                    isCorrect: index == question.correctIndex,
                    showResult: _answered,
                    shakeAnimation: _shakeAnimation,
                    bounceAnimation: _bounceAnimation,
                    onTap: () => _selectAnswer(index),
                  );
                },
              ),
            ),

            // Explanation & Next button
            if (_answered) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedAnswer == question.correctIndex
                      ? AppColors.pastelGreen : AppColors.pastelPink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(children: [
                  Text(_selectedAnswer == question.correctIndex ? '🎉' : '💡',
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(question.explanation,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.warmBrown))),
                ]),
              ),
              const SizedBox(height: 16),
              _NextButton(
                isLast: _currentIndex == _questions.length - 1,
                onTap: _nextQuestion,
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final Animation<double> shakeAnimation;
  final Animation<double> bounceAnimation;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label, required this.index, required this.isSelected,
    required this.isCorrect, required this.showResult,
    required this.shakeAnimation, required this.bounceAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppColors.surfaceContainerLowest;
    Color borderColor = AppColors.outlineVariant;
    Widget? trailing;

    if (showResult) {
      if (isCorrect) {
        bgColor = AppColors.pastelGreen;
        borderColor = AppColors.primaryContainer;
        trailing = const Text('✅', style: TextStyle(fontSize: 24));
      } else if (isSelected && !isCorrect) {
        bgColor = AppColors.pastelPink;
        borderColor = AppColors.error;
        trailing = const Text('❌', style: TextStyle(fontSize: 24));
      }
    } else if (isSelected) {
      bgColor = AppColors.primaryContainer.withValues(alpha: 0.2);
      borderColor = AppColors.primaryContainer;
    }

    Widget card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: showResult && isCorrect ? AppColors.primaryContainer
                : showResult && isSelected ? AppColors.error
                : AppColors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text('${index + 1}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: showResult && (isCorrect || isSelected) ? Colors.white : AppColors.warmBrown))),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.warmBrown))),
        ?trailing,
      ]),
    );

    if (showResult && isSelected && !isCorrect) {
      card = AnimatedBuilder(
        animation: shakeAnimation,
        builder: (_, child) => Transform.translate(
            offset: Offset(shakeAnimation.value * (shakeAnimation.status == AnimationStatus.forward ? 1 : -1), 0),
            child: child),
        child: card,
      );
    }
    if (showResult && isCorrect) {
      card = AnimatedBuilder(
        animation: bounceAnimation,
        builder: (_, child) => Transform.scale(scale: bounceAnimation.value, child: child),
        child: card,
      );
    }

    return GestureDetector(onTap: showResult ? null : onTap, child: card);
  }
}

class _NextButton extends StatefulWidget {
  final bool isLast;
  final VoidCallback onTap;
  const _NextButton({required this.isLast, required this.onTap});

  @override
  State<_NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<_NextButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isLast ? AppColors.secondaryContainer : AppColors.primaryContainer;
    final dark = HSLColor.fromColor(color)
        .withLightness((HSLColor.fromColor(color).lightness - 0.15).clamp(0.0, 1.0)).toColor();
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) { setState(() => _pressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 64, width: double.infinity,
        transform: Matrix4.translationValues(0, _pressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(9999),
          border: Border(bottom: BorderSide(color: _pressed ? Colors.transparent : dark, width: _pressed ? 0 : 4)),
        ),
        child: Center(child: Text(
          widget.isLast ? 'Lihat Hasil 🏆' : 'Selanjutnya →',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white, fontSize: 18),
        )),
      ),
    );
  }
}
