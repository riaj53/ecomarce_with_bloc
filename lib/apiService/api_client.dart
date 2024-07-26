import 'dart:convert';

import 'package:learnbloc/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<ProductModel?> getProduct() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      ProductModel productModel =
          ProductModel.fromJson(jsonDecode(response.body));
      return productModel;
    }
    return null;
  }
}
