import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/medical_category.dart';

class CategorySelector extends StatefulWidget {
  final List<MedicalCategory> categories;

  final Function(int index)? onCategorySelected;

  final int initialSelectedIndex;

  const CategorySelector({
    super.key,
    required this.categories,
    this.onCategorySelected,
    this.initialSelectedIndex = 0,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  static const Color _activeColor = Color(0xFF2D2D5E);
  static const Color _inactiveColor = Color(0xFF8E8EAC);
  static const double _underlineHeight = 3.0;
  static const double _itemPadding = 16.0;

  late final ScrollController _scrollController;
  late final ValueNotifier<int> _activeIndex;
  late final ValueNotifier<double> _scrollPercent;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _activeIndex = ValueNotifier<int>(widget.initialSelectedIndex);
    _scrollPercent = ValueNotifier<double>(0.0);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentOffset = _scrollController.offset;

    // Calculate progress percentage (0.0 to 1.0)
    double percent = (currentOffset / maxScroll).clamp(0.0, 1.0);
    _scrollPercent.value = percent;

    // Calculate Active Index: (offset / maxScroll * (total - 1))
    int newIndex = (percent * (widget.categories.length - 1)).round();

    if (newIndex != _activeIndex.value) {
      _activeIndex.value = newIndex;
      widget.onCategorySelected?.call(newIndex);
    }
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    // Calculate the target offset to make this index "active"
    double targetOffset = (index / (widget.categories.length - 1)) * maxScroll;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _activeIndex.dispose();
    _scrollPercent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Original horizontal scrollable category list
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: List.generate(
                widget.categories.length,
                (index) => ValueListenableBuilder<int>(
                  valueListenable: _activeIndex,
                  builder: (context, activeIdx, _) {
                    return _buildCategoryItem(index, activeIdx == index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index, bool isActive) {
    final category = widget.categories[index];

    return GestureDetector(
      onTap: () => _scrollToIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _itemPadding,
          vertical: 12.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                category.icon,
                size: 24.0,
                color: isActive ? _activeColor : _inactiveColor,
              ),
            ),
            const SizedBox(height: 8.0),

            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isActive ? _activeColor : _inactiveColor,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                      height: 1.2,
                    ),
                    child: Text(category.label, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 4.0),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: isActive ? _underlineHeight : 0.0,
                    decoration: BoxDecoration(
                      color: _activeColor,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Predefined medical categories for healthcare applications
class MedicalCategories {
  static const List<MedicalCategory> defaultCategories = [
    MedicalCategory(label: 'Urgent Call', icon: Icons.phone_in_talk),
    MedicalCategory(label: 'Gen. Physician', icon: Icons.medical_services),
    MedicalCategory(label: 'Medicine', icon: Icons.medication),
    MedicalCategory(label: 'ENT', icon: Icons.hearing),
    MedicalCategory(label: 'Pediatric', icon: Icons.child_care),
    MedicalCategory(label: 'Internal Medicine', icon: Icons.biotech),
    MedicalCategory(label: 'Gynecology', icon: Icons.pregnant_woman),
    MedicalCategory(label: 'Skin & VD', icon: Icons.face),
    MedicalCategory(label: 'Orthopaedic', icon: Icons.accessibility_new),
    MedicalCategory(label: 'Cardiology', icon: Icons.favorite),
    MedicalCategory(label: 'Neurology', icon: Icons.psychology),
    MedicalCategory(label: 'Ophthalmology', icon: Icons.visibility),
    MedicalCategory(label: 'Oncology', icon: Icons.celebration),
    MedicalCategory(label: 'Gastroenterology', icon: Icons.restaurant),
    MedicalCategory(label: 'Urology', icon: Icons.water_drop),
    MedicalCategory(label: 'Rheumatology', icon: Icons.accessibility),
    MedicalCategory(label: 'Dentistry', icon: Icons.mood),
    MedicalCategory(label: 'Speech Therapy', icon: Icons.record_voice_over),
    MedicalCategory(label: 'Pulmonology', icon: Icons.air),
    MedicalCategory(label: 'Psychology', icon: Icons.psychology_alt),
    MedicalCategory(label: 'Endocrinology', icon: Icons.settings_suggest),
    MedicalCategory(label: 'Nephrology', icon: Icons.opacity),
    MedicalCategory(label: 'Nutritionist', icon: Icons.restaurant_menu),
    MedicalCategory(label: 'Hematology', icon: Icons.bloodtype),
    MedicalCategory(label: 'Hepatology', icon: Icons.local_hospital),
    MedicalCategory(label: 'Surgery', icon: Icons.content_cut),
    MedicalCategory(label: 'Neurosurgery', icon: Icons.psychology),
    MedicalCategory(label: 'Podiatry', icon: Icons.directions_walk),
    MedicalCategory(label: 'Physiotherapy', icon: Icons.fitness_center),
  ];
}
