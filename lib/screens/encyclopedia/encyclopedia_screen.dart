import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_colors.dart';
import 'package:game_edukasi/data/models/animal.dart';
import 'package:game_edukasi/widgets/animal_card.dart';
import 'package:game_edukasi/widgets/category_chip.dart';
import 'package:game_edukasi/screens/animal_detail/animal_detail_screen.dart';

class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  List<Animal> get _filteredAnimals {
    var animals = AnimalData.animals;
    if (_selectedCategory != 'Semua') {
      animals = animals.where((a) => a.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      animals = animals
          .where((a) => a.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return animals;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', ...AnimalData.categories];
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('📚', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 8),
            Text('Ensiklopedia', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Cari hewan... 🔍',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.outline),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () { _searchController.clear(); setState(() => _searchQuery = ''); },
                        icon: const Icon(Icons.close_rounded, size: 20))
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return CategoryChip(
                  label: cat, isSelected: _selectedCategory == cat,
                  onTap: () => setState(() => _selectedCategory = cat),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${_filteredAnimals.length} hewan ditemukan',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _filteredAnimals.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('🔍', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 16),
                    Text('Tidak ditemukan', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.outline)),
                  ]))
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.85),
                    itemCount: _filteredAnimals.length,
                    itemBuilder: (context, index) {
                      final animal = _filteredAnimals[index];
                      return AnimalCard(
                        animal: animal,
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AnimalDetailScreen(animal: animal))),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
