import 'package:dio/dio.dart';
import 'package:get_api/features/cart/data/model/cart_data.dart';

class CartData {
  Dio dio = Dio();
  addCart() async {
    Response response =
        await dio.post('https://elwekala.onrender.com/cart/add', data: {
      "nationalId": "01056710052789",
      "productId": "64666d3a91c71d884185b774",
      "quantity": "1"
    });

    return response.data;
  }

  getCart() async {
    Response response = await dio.get(
        'https://elwekala.onrender.com/cart/allProducts',
        data: {"nationalId": "01056710052789"});
    List responseData = response.data['products'];
    List<CartModel> listCard =
        responseData.map((e) => CartModel.fromJson(e)).toList();
    return listCard;
  }

  removeCartCubit({required productId}) {
    dio.delete('https://elwekala.onrender.com/cart/delete', data: {
      "nationalId": "01056710052789",
      "productId": productId,
      "quantity": "1"
    });
  }

  updateCartCubit({required productId, required quantity}) {
    dio.put('https://elwekala.onrender.com/cart', data: {
      "nationalId": "01056710052789",
      "productId": productId,
      "quantity": quantity
    });
  }
}
