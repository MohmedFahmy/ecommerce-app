import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/features/cart/cubit/cart_cubit.dart';
import 'package:get_api/features/cart/cubit/cart_states.dart';

import '../widget/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //   String controler = '';
    return BlocProvider(
      create: (context) => CartCubit()..getCartData(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: BlocConsumer<CartCubit, CartStates>(
              builder: (context, state) {
                if (state is CartGetSuccess) {
                  return ListView.builder(
                    itemCount: state.cartData.length,
                    itemBuilder: (context, index) {
                      final item = state.cartData[index];
                      return CartItemWidget(
                        /*  karim: (value) {
                          controler = value;
                          print(value);
                        },*/
                        item: item,
                        onPress: () {
                          CartCubit().get(context).removeCartCubit(
                              productId: state.cartData[index]);
                        },
                        secondOnPress: () {
                          CartCubit().get(context).isUpdate = true;
                          CartCubit().get(context).updateCartCubit(
                              productId: state.cartData[index].id,
                              quantity: state.cartData[index].quantity);
                        },
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
              listener: (context, state) {})),
    );
  }
}
