import 'package:flutter/material.dart';

class EnTeteApplication extends StatelessWidget {
  const EnTeteApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
      ),
      child: const Center(
        child: Text(
          'MOVIES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
