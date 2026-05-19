import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';

/// Animal data model
class Animal {
  final String id;
  final String name;
  final String emoji;
  final String habitat;
  final String diet;
  final String funFact;
  final String description;
  final String sound;
  final IconData icon;
  final Color cardColor;
  final Color accentColor;
  final String category;

  const Animal({
    required this.id,
    required this.name,
    required this.emoji,
    required this.habitat,
    required this.diet,
    required this.funFact,
    required this.description,
    required this.sound,
    required this.icon,
    required this.cardColor,
    required this.accentColor,
    required this.category,
  });
}

/// All animals data
class AnimalData {
  AnimalData._();

  static const List<Animal> animals = [
    Animal(
      id: 'lion',
      name: 'Singa',
      emoji: '🦁',
      habitat: 'Sabana Afrika',
      diet: 'Karnivora',
      funFact: 'Auman singa bisa terdengar hingga 8 km jauhnya!',
      description:
          'Singa adalah kucing besar yang hidup di Afrika. Mereka dikenal sebagai "Raja Hutan" karena keberaniannya. Singa jantan memiliki surai yang indah di sekitar kepalanya.',
      sound: 'Roaaar! 🦁',
      icon: Icons.pets,
      cardColor: AppColors.pastelOrange,
      accentColor: Color(0xFFFF9800),
      category: 'Savana',
    ),
    Animal(
      id: 'elephant',
      name: 'Gajah',
      emoji: '🐘',
      habitat: 'Hutan & Sabana Afrika dan Asia',
      diet: 'Herbivora',
      funFact: 'Gajah bisa mengingat teman-temannya selama bertahun-tahun!',
      description:
          'Gajah adalah hewan darat terbesar di dunia. Mereka sangat pintar dan memiliki belalai yang bisa digunakan untuk minum, makan, dan menyapa teman.',
      sound: 'Pruuuut! 🐘',
      icon: Icons.pets,
      cardColor: AppColors.pastelBlue,
      accentColor: Color(0xFF78909C),
      category: 'Savana',
    ),
    Animal(
      id: 'giraffe',
      name: 'Jerapah',
      emoji: '🦒',
      habitat: 'Sabana Afrika',
      diet: 'Herbivora',
      funFact: 'Jerapah adalah hewan tertinggi di dunia, bisa setinggi 6 meter!',
      description:
          'Jerapah memiliki leher yang sangat panjang untuk mencapai daun-daun di pohon tinggi. Setiap jerapah memiliki pola bintik yang unik, seperti sidik jari manusia!',
      sound: 'Hmmmm! 🦒',
      icon: Icons.pets,
      cardColor: AppColors.pastelYellow,
      accentColor: Color(0xFFFFB74D),
      category: 'Savana',
    ),
    Animal(
      id: 'tiger',
      name: 'Harimau',
      emoji: '🐯',
      habitat: 'Hutan Asia',
      diet: 'Karnivora',
      funFact: 'Setiap harimau memiliki pola belang yang berbeda-beda!',
      description:
          'Harimau adalah kucing terbesar di dunia. Mereka hidup di hutan Asia dan sangat pandai berenang. Belang-belang mereka membantu bersembunyi di antara rumput tinggi.',
      sound: 'Grrrr! 🐯',
      icon: Icons.pets,
      cardColor: AppColors.pastelOrange,
      accentColor: Color(0xFFE65100),
      category: 'Hutan',
    ),
    Animal(
      id: 'frog',
      name: 'Katak',
      emoji: '🐸',
      habitat: 'Rawa & Kolam',
      diet: 'Karnivora (serangga)',
      funFact: 'Katak bisa melompat 20 kali panjang tubuhnya!',
      description:
          'Katak adalah hewan amfibi yang bisa hidup di air dan di darat. Mereka bernapas melalui kulit dan paru-paru. Katak membantu petani dengan memakan serangga hama.',
      sound: 'Koak koak! 🐸',
      icon: Icons.pets,
      cardColor: AppColors.pastelGreen,
      accentColor: Color(0xFF4CAF50),
      category: 'Air',
    ),
    Animal(
      id: 'rabbit',
      name: 'Kelinci',
      emoji: '🐰',
      habitat: 'Padang Rumput & Hutan',
      diet: 'Herbivora',
      funFact: 'Kelinci bisa memutar telinganya 180 derajat!',
      description:
          'Kelinci adalah hewan yang lucu dengan telinga panjang dan ekor pendek. Mereka suka melompat-lompat dan makan wortel, rumput, dan sayuran.',
      sound: 'Sniff sniff! 🐰',
      icon: Icons.pets,
      cardColor: AppColors.pastelPink,
      accentColor: Color(0xFFF48FB1),
      category: 'Padang Rumput',
    ),
    Animal(
      id: 'penguin',
      name: 'Penguin',
      emoji: '🐧',
      habitat: 'Antartika',
      diet: 'Karnivora (ikan)',
      funFact: 'Penguin tidak bisa terbang, tapi mereka perenang yang hebat!',
      description:
          'Penguin adalah burung yang tidak bisa terbang tapi sangat jago berenang. Mereka hidup di tempat yang sangat dingin dan saling berpelukan untuk menghangatkan diri.',
      sound: 'Waak waak! 🐧',
      icon: Icons.pets,
      cardColor: AppColors.pastelBlue,
      accentColor: Color(0xFF42A5F5),
      category: 'Kutub',
    ),
    Animal(
      id: 'monkey',
      name: 'Monyet',
      emoji: '🐵',
      habitat: 'Hutan Tropis',
      diet: 'Omnivora',
      funFact: 'Monyet bisa menggunakan alat sederhana untuk mencari makanan!',
      description:
          'Monyet adalah hewan yang sangat cerdas dan suka bermain. Mereka hidup di pohon-pohon tinggi di hutan tropis dan suka makan buah-buahan, terutama pisang.',
      sound: 'Uuk uuk! 🐵',
      icon: Icons.pets,
      cardColor: AppColors.pastelOrange,
      accentColor: Color(0xFF8D6E63),
      category: 'Hutan',
    ),
    Animal(
      id: 'panda',
      name: 'Panda',
      emoji: '🐼',
      habitat: 'Hutan Bambu China',
      diet: 'Herbivora (bambu)',
      funFact: 'Panda makan bambu selama 12 jam setiap hari!',
      description:
          'Panda adalah beruang berwarna hitam putih yang sangat menggemaskan. Mereka tinggal di hutan bambu di China dan hampir seluruh makanan mereka adalah bambu.',
      sound: 'Bleat! 🐼',
      icon: Icons.pets,
      cardColor: AppColors.pastelGreen,
      accentColor: Color(0xFF66BB6A),
      category: 'Hutan',
    ),
    Animal(
      id: 'zebra',
      name: 'Zebra',
      emoji: '🦓',
      habitat: 'Sabana Afrika',
      diet: 'Herbivora',
      funFact: 'Tidak ada dua zebra yang memiliki pola garis yang sama!',
      description:
          'Zebra terlihat seperti kuda dengan garis-garis hitam putih. Mereka hidup berkelompok di sabana Afrika. Garis-garis mereka membantu membingungkan predator.',
      sound: 'Hiiiih! 🦓',
      icon: Icons.pets,
      cardColor: AppColors.pastelPurple,
      accentColor: Color(0xFF9575CD),
      category: 'Savana',
    ),
  ];

  static Animal getById(String id) {
    return animals.firstWhere((a) => a.id == id);
  }

  static List<String> get categories {
    return animals.map((a) => a.category).toSet().toList();
  }

  static List<Animal> getByCategory(String category) {
    return animals.where((a) => a.category == category).toList();
  }
}
