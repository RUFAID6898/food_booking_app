import 'package:flutter/material.dart';
import 'package:food_app/api_services/api_model.dart';
import 'package:food_app/class/cart_items.dart';
import 'package:food_app/class/item_counder.dart';
import 'package:food_app/widget/counter_button.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.size,
    required this.dish,
    required this.cart,
    required this.counterProvider,
    required this.onAddToCart,
  });

  final double size;
  final CategoryDishes dish;
  final Cart cart;
  final CounterProvider counterProvider;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: false);
    return Container(
      width: double.infinity,
      height: size * 0.55,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.radio_button_on,
                color: Colors.green,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    dish.dishName!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: size * 0.53,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'INR ${dish.dishPrice} ',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "${dish.dishCalories!.toString()} calories",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: Text(
                    dish.dishDescription!,
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CounterButton(
                    decrementCounter: () {
                      cart.removeItem(
                          dish, counterProvider.getCounter(dish.dishId!));
                      counterProvider.decrementCounter(dish.dishId!);
                    },
                    incrementCounter: () {
                      onAddToCart();
                      cart.addItem(
                          dish, counterProvider.getCounter(dish.dishId!));
                      counterProvider.incrementCounter(dish.dishId!);
                    },
                    count: '${counterProvider.getCounter(dish.dishId!)}'),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image(image: NetworkImage(dish.dishImage!)),
            )
          ],
        ),
      ),
    );
  }
}
