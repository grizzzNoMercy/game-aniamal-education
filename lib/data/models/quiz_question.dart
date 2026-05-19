
/// Quiz question model
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String animalId;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.animalId,
    required this.explanation,
  });
}

/// Quiz data repository
class QuizData {
  QuizData._();

  static const List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'Hewan apa yang dijuluki "Raja Hutan"?',
      options: ['Gajah', 'Singa', 'Harimau', 'Jerapah'],
      correctIndex: 1,
      animalId: 'lion',
      explanation: 'Singa dijuluki Raja Hutan karena keberaniannya!',
    ),
    QuizQuestion(
      question: 'Hewan darat apa yang paling besar di dunia?',
      options: ['Jerapah', 'Harimau', 'Gajah', 'Zebra'],
      correctIndex: 2,
      animalId: 'elephant',
      explanation: 'Gajah adalah hewan darat terbesar di dunia!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang paling tinggi di dunia?',
      options: ['Gajah', 'Singa', 'Jerapah', 'Monyet'],
      correctIndex: 2,
      animalId: 'giraffe',
      explanation: 'Jerapah bisa setinggi 6 meter!',
    ),
    QuizQuestion(
      question: 'Kucing terbesar di dunia adalah?',
      options: ['Singa', 'Harimau', 'Panda', 'Kelinci'],
      correctIndex: 1,
      animalId: 'tiger',
      explanation: 'Harimau adalah kucing terbesar di dunia!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang bisa melompat 20 kali panjang tubuhnya?',
      options: ['Kelinci', 'Katak', 'Penguin', 'Monyet'],
      correctIndex: 1,
      animalId: 'frog',
      explanation: 'Katak bisa melompat sangat jauh!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang suka makan wortel?',
      options: ['Panda', 'Zebra', 'Kelinci', 'Penguin'],
      correctIndex: 2,
      animalId: 'rabbit',
      explanation: 'Kelinci suka makan wortel dan sayuran!',
    ),
    QuizQuestion(
      question: 'Burung apa yang tidak bisa terbang tapi jago berenang?',
      options: ['Penguin', 'Katak', 'Monyet', 'Zebra'],
      correctIndex: 0,
      animalId: 'penguin',
      explanation: 'Penguin adalah perenang yang hebat!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang suka makan pisang?',
      options: ['Panda', 'Monyet', 'Zebra', 'Singa'],
      correctIndex: 1,
      animalId: 'monkey',
      explanation: 'Monyet suka makan buah-buahan, terutama pisang!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang makan bambu selama 12 jam sehari?',
      options: ['Jerapah', 'Gajah', 'Panda', 'Harimau'],
      correctIndex: 2,
      animalId: 'panda',
      explanation: 'Panda menghabiskan hampir sepanjang hari untuk makan bambu!',
    ),
    QuizQuestion(
      question: 'Hewan apa yang memiliki garis hitam putih yang unik?',
      options: ['Penguin', 'Panda', 'Zebra', 'Singa'],
      correctIndex: 2,
      animalId: 'zebra',
      explanation: 'Setiap zebra memiliki pola garis yang berbeda!',
    ),
  ];

  static List<QuizQuestion> getRandomQuestions(int count) {
    final shuffled = List<QuizQuestion>.from(questions)..shuffle();
    return shuffled.take(count).toList();
  }
}
