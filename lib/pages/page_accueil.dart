import 'package:flutter/material.dart';
import '../widgets/en_tete_application.dart';
import '../widgets/section_categories.dart';
import '../widgets/navigation_bas.dart';
import 'page_tous.dart';
import 'page_populaires.dart';
import 'page_mieux_notes.dart';
import 'page_en_salle.dart';
import 'page_a_venir.dart';
import 'page_favoris.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;

  static const List<String> _categories = [
    'TOUS',
    'POPULAIRES',
    'MIEUX NOTÉS',
    'EN SALLE',
    'À VENIR',
  ];

  void _selectCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _selectNav(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  Widget _getCurrentPage() {
    if (_selectedNavIndex == 1) {
      return const PageFavoris();
    }

    switch (_selectedCategoryIndex) {
      case 0:
        return const PageTous();
      case 1:
        return const PagePopulaires();
      case 2:
        return const PageMieuxNotes();
      case 3:
        return const PageEnSalle();
      case 4:
        return const PageAVenir();
      default:
        return const PageTous();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EnTeteApplication(),
          if (_selectedNavIndex != 1)
            SectionCategories(
              categories: _categories,
              selectedIndex: _selectedCategoryIndex,
              onCategorySelected: _selectCategory,
            ),
          Expanded(child: _getCurrentPage()),
          NavigationBas(selectedIndex: _selectedNavIndex, onTap: _selectNav),
        ],
      ),
    );
  }
}