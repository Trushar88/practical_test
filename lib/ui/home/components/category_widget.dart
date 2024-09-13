import 'package:flutter/material.dart';
import 'package:practical_test/ui/home/home_provider.dart';
import 'package:practical_test/app/config/app_colors.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.uniqueCategories.length,
        itemBuilder: (context, index) {
          final category = productProvider.uniqueCategories[index];
          final isSelected = productProvider.selectedCategories.contains(category);

          return GestureDetector(
            onTap: () => productProvider.selectCategory(category),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? APPCOLOR.PRIMARYCOLOR : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
