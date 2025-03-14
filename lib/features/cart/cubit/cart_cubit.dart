import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/features/cart/cubit/cart_states.dart';
import 'package:get_api/features/cart/data/cart_data.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit get(context) => BlocProvider.of(context);
  bool isUpdate = true;
  CartCubit() : super(CartInitial());
  CartData data = CartData();
  addCartCubit() {
    emit(CartLoading());
    data.addCart();
    // print('object data');
    emit(CartSuccess());
  }

  getCartData() async {
    emit(CartLoading());
    var cartData = await data.getCart();
    emit(CartGetSuccess(cartData: cartData));
  }

  removeCartCubit({required productId}) async {
    emit(CartLoading());
    await data.removeCartCubit(productId: productId);
    emit(CartDelete());
    getCartData();
  }

  updateCartCubit({required productId, required quantity}) async {
    isUpdate = !isUpdate;
    emit(CartLoading());
    await data.updateCartCubit(
      productId: productId,
      quantity: quantity,
    );
    emit(CartUpdate());
    getCartData();
  }
}
