import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/features/cart/view/screen/cart_screen.dart';

import '../../../../core/styles/text_style.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../profile/view/screen/profile_screen.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/stats.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getDataAPIs(),
        ),
        BlocProvider(
          create: (context) => CartCubit()..addCartCubit(),
        ),
      ],
      child: Scaffold(
          body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is TestPassedState) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(Icons.add_shopping_cart),
              backgroundColor: Colors.blue[200],
            ),
            appBar: AppBar(
              title: Text('Lab Shop'),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  token: "6ymqch6bpd5m895z1av",
                                )));
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) => Card(
                  elevation: 6,
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(
                          state.list[index].image,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                      ListTile(
                        title: Column(
                          children: [
                            Text(
                              state.list[index].name,
                              style: myStyle,
                            ),
                            Text(
                              state.list[index].category,
                              style: mySecondStyle,
                            ),
                          ],
                        ),
                        subtitle: Text(
                          state.list[index].description,
                        ),
                      ),
                      Text(
                        '${state.list[index].price} \$',
                        style: myStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor:
                                    const Color.fromARGB(255, 185, 189, 185)),
                            onPressed: () {
                              log('message');
                              BlocProvider.of<CartCubit>(context)
                                  .addCartCubit();
                            },
                            label: Text('Add To Cart'),
                            icon: Icon(
                              Icons.add_shopping_cart,
                              size: 30,
                            )), //Icon(Icons.add_shopping_cart,)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      })),
    );
  }
}
