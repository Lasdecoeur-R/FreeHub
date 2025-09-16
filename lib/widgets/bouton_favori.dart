import 'package:flutter/material.dart';

class BoutonFavori extends StatefulWidget {
  final bool estFavori;
  final VoidCallback onTap;
  final double taille;

  const BoutonFavori({
    super.key,
    required this.estFavori,
    required this.onTap,
    this.taille = 40,
  });

  @override
  State<BoutonFavori> createState() => _BoutonFavoriState();
}

class _BoutonFavoriState extends State<BoutonFavori>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.taille,
              height: widget.taille,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                widget.estFavori ? Icons.favorite : Icons.favorite_border,
                color: widget.estFavori ? Colors.red : Colors.white,
                size: widget.taille * 0.6,
              ),
            ),
          );
        },
      ),
    );
  }
}
