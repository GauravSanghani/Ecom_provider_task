// providers/product_provider.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task2_test/utils/app_const.dart';
import 'dart:convert';

import '../data/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  final List<String> _selectedBrands = [];
  final List<String> _selectedCategories = [];
  int currentIndex = 0;

  // Public getters for private variables
  List<String> get selectedBrands => _selectedBrands;
  List<String> get selectedCategories => _selectedCategories;

  List<Product> get products {

      return _products;

  }

  List<Product> get filteredProducts {
    if (_selectedBrands.isEmpty && _selectedCategories.isEmpty) {
      return _products;
    } else {
      return _products.where((product) {
        final matchesBrand =
            _selectedBrands.isEmpty || _selectedBrands.contains(product.brand);
        final matchesCategory = _selectedCategories.isEmpty ||
            _selectedCategories.contains(product.category);
        return matchesBrand && matchesCategory;
      }).toList();
    }
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(url);

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['products'] as List;
      _products = data.map((json) => Product.fromJson(json)).toList();
      notifyListeners();
    }
  }

  void toggleBrandSelection(String brand) {
    if (_selectedBrands.contains(brand)) {
      _selectedBrands.remove(brand);
    } else {
      _selectedBrands.add(brand);
    }
    notifyListeners();
  }

  void toggleCategorySelection(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  void changeIndex(int index) async {
    currentIndex = index;
    notifyListeners();

  }
}
