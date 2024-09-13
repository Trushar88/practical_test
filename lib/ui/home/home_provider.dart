import 'package:flutter/material.dart';
import 'package:practical_test/Model/product_model.dart';
import 'package:practical_test/ui/home/home_repo.dart';
import 'package:practical_test/ui/review/review_screen.dart';
import 'package:practical_test/app/config/app_strings.dart';
import 'package:practical_test/app/service/network_check.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> selectedBrands = [];
  List<String> selectedCategories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  ConnectionStatusSingleton connectionStatusSingleton = ConnectionStatusSingleton.getInstance();
  Future<void> fetchProducts() async {
    selectedBrands = [];
    selectedCategories = [];
    _isLoading = true;
    notifyListeners();
    try {
      if (await connectionStatusSingleton.checkConnection()) {
        List<Product> response = await HomeRepo().getProducts();
        if (response.isNotEmpty) {
          _products = response;
          _filterProducts();
          _errorMessage = '';
        }
      } else {
        _errorMessage = APPSTRING.pleaseCheckNetwork;
      }
    } catch (e) {
      _errorMessage = APPSTRING.failedtoLoad;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void navidateToReview({required BuildContext context, required Product data}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ReviewScreen(data: data);
      },
    ));
  }

  void selectBrand(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
    _filterProducts();
    notifyListeners();
  }

  void selectCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    _filterProducts();
    notifyListeners();
  }

  void _filterProducts() {
    _filteredProducts = _products.where((product) {
      final matchesBrand = selectedBrands.isEmpty || selectedBrands.contains(product.brand);
      final matchesCategory = selectedCategories.isEmpty || product.category != null && selectedCategories.contains(product.category!);
      return matchesBrand && matchesCategory;
    }).toList();
  }

  List<String> get uniqueBrands => _products.map((p) => p.brand).whereType<String>().toSet().toList();
  List<String> get uniqueCategories => _products.map((p) => p.category).whereType<String>().toSet().toList();
}
