import 'package:dio/dio.dart';

import '../model/model.dart';

class Data {
  Dio dio = Dio();

  getData() async {
    var repo = await dio.get('https://elwekala.onrender.com/product/Laptops');
    if (repo.statusCode == 200) {
      List bodyJson = repo.data["product"];
      List<Model> myData =
          bodyJson.map((json) => Model.fromJson(json)).toList();
      return myData;
    }
    throw Exception(repo.statusMessage);
  }
}
