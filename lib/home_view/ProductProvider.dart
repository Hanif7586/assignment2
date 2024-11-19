import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  List<dynamic> _favorites = [];
  bool _isLoading = false;
  String _error = '';

  List<dynamic> get products => _products;
  List<dynamic> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get error => _error;

  ProductProvider() {
    loadFavoritesFromLocal();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _products = data['products'];
      } else {
        _error = 'Failed to load products';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Map<String, dynamic> product) async {
    final productId = product['id'];

    final existingIndex = _favorites.indexWhere((item) => item['id'] == productId);

    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(product);
    }

    notifyListeners();
    await saveFavoritesToLocal();
  }

  Future<void> saveFavoritesToLocal() async {
    try {
      final box = Hive.box('favoritesBox');
      final favoritesJson = _favorites.map((item) => json.encode(item)).toList();
      box.put('favorites', favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  Future<void> loadFavoritesFromLocal() async {
    try {
      final box = Hive.box('favoritesBox');
      final savedFavorites = box.get('favorites', defaultValue: []);

      _favorites = savedFavorites.map((item) => json.decode(item)).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }
}
