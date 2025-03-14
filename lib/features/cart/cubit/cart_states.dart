import 'package:get_api/features/cart/data/model/cart_data.dart';

sealed class CartStates {}

final class CartInitial extends CartStates {}

final class CartLoading extends CartStates {}

final class CartGetSuccess extends CartStates {
  final List<CartModel> cartData;
  CartGetSuccess({required this.cartData});
}

final class CartSuccess extends CartStates {}

final class CartDelete extends CartStates {
 /* final int cartId;
  CartDelete({required this.cartId});*/
}

final class CartUpdate extends CartStates {}
