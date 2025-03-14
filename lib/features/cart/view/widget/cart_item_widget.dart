import 'package:flutter/material.dart';
import 'package:get_api/features/cart/cubit/cart_cubit.dart';

import '../../../../core/styles/text_style.dart';
import '../../data/model/cart_data.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget({
    super.key,
    required this.item,
    required this.onPress,
    required this.secondOnPress,
    
  });
  //final Function(String value) karim;
  final CartModel item;
  final void Function()? onPress;
  final void Function()? secondOnPress;
  final TextEditingController myQantaty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                item.image,
              ),
            )),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              item.description,
              style: mySecondStyle,
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              item.name,
              style: myStyle.copyWith(fontSize: 18),
            ),
            subtitle: Text(
              '\$${item.price}',
              style: mySecondStyle.copyWith(
                  color: Colors.green[800], fontSize: 25),
            ),
            trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 40),
                    backgroundColor: Colors.blue[300]),
                onPressed: () {},
                child: Text(
                  'Buy',
                  style: mySecondStyle,
                )),
          ),
          SizedBox(height: 10),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Text(
                  'Quantity : ',
                  style: myStyle,
                ),
                CartCubit().get(context).isUpdate
                    ? SizedBox(
                        width: 40,
                        child: TextField(
                            controller: myQantaty,
                            
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number),
                      )
                    : Text(
                        '${item.quantity}',
                        style: myStyle,
                      ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 40),
                    backgroundColor: Colors.blue[100],
                  ),
                  onPressed: secondOnPress,
                  child: Text(
                    'Change Quantity',
                    style: mySecondStyle,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 40),
              backgroundColor: Colors.grey[300],
            ),
            onPressed: onPress,
            label: Text(
              'Remove',
              style: mySecondStyle.copyWith(color: Colors.red),
            ),
            icon: Icon(
              Icons.remove_circle_rounded,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
