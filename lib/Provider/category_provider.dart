import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:service_pro_user/Models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/category'));
    if (response.statusCode == 200) {
      final categoryData = jsonDecode(response.body)['data'] as List;
      return categoryData
          .map<CategoryModel>(
              (categoryData) => CategoryModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
