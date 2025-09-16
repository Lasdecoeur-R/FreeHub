import 'package:flutter/material.dart';
import 'puce_categorie.dart';

class SectionCategories extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const SectionCategories({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final estSelectionnee = index == selectedIndex;
            return GestureDetector(
              onTap: () => onCategorySelected(index),
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: PuceCategorie(
                  texte: categories[index],
                  estSelectionnee: estSelectionnee,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
