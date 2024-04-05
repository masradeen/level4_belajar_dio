import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../model/product_model.dart';

class ApiService {
  var dio = Dio();
  //untuk get product list secara online
  Future<List<Product>?> getProducts() async {
    try {
      var url = 'https://dummyjson.com/products?limit=10';
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var _model = ProductModel.fromJson(response.data);

        var listData = _model.products;
        return listData;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //untuk get product list secara offline, siapkan file json nya
  Future<List<Product>?> getProductsOffline() async {
    try {
      var result = await _parseFileToJson('assets/product.json');

      if (result != null) {
        var listData = result.products;
        return listData;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ProductModel> _parseFileToJson(String path) async {
    final string = await rootBundle.loadString(path);
    return productModelFromJson(string);
  }
}