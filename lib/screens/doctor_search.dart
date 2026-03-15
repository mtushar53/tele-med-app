import 'package:flutter/material.dart';
import '../widgets/category_selector.dart';

class DoctorSearchScreen extends StatelessWidget {
  const DoctorSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySelector(
              categories: MedicalCategories.defaultCategories,
              initialSelectedIndex: 0,
            ),

            const Divider(height: 1, color: Color(0xFFE0E0E0)),
          ],
        ),
      ),
    );
  }
}
