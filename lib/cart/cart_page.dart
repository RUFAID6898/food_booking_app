import 'package:flutter/material.dart';
import 'package:food_app/class/cart_items.dart';
import 'package:food_app/class/item_counder.dart';
import 'package:food_app/widget/counder_button.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final counterProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        // backgroundColor: Colors.white,
        title: const Text(' Oder Summary'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: size * 4,
          child: ListView(
            children: [
              if (cart.items.isNotEmpty)
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'Your items',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              Column(
                children: List.generate(cart.items.length, (index) {
                  var item = cart.items[index];

                  return Container(
                    width: double.infinity,
                    height: size * 0.4,
                    decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.black26),
                          bottom: BorderSide(color: Colors.black26),
                          right: BorderSide(color: Colors.black26)),
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
                            children: [
                              SizedBox(
                                width: 80,
                                height: 70,
                                child: Text(
                                  // overflow: TextOverflow.ellipsis,
                                  item.dish.dishName!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "INR ${item.dish.dishPrice.toString()}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${item.dish.dishCalories}calories",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CounderButton(
                              decrementCounter: () {
                                if (counterProvider
                                        .getCounter(item.dish.dishId!) ==
                                    0) {
                                  cart.clearCart();
                                }
                                cart.removeItem(
                                    item.dish,
                                    counterProvider
                                        .getCounter(item.dish.dishId!));
                                counterProvider
                                    .decrementCounter(item.dish.dishId!);
                              },
                              incrementCounter: () {
                                cart.addItem(
                                    item.dish,
                                    counterProvider
                                        .getCounter(item.dish.dishId!));
                                counterProvider
                                    .incrementCounter(item.dish.dishId!);
                              },
                              count:
                                  '${counterProvider.getCounter(item.dish.dishId!)}'),
                          Text(
                            "INR ${item.dish.dishPrice.toString()}",
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              if (cart.items.isNotEmpty)
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.black26),
                          bottom: BorderSide(color: Colors.black26),
                          right: BorderSide(color: Colors.black26))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${cart.getTotal()}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: size * 1,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          width: 350,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(40)),
          child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {
                if (cart.items.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.green,
                      content: Text('Oder Successfully placed'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text(' your cart is empty'),
                    ),
                  );
                }

                cart.clearCart();
                counterProvider.counters.clear();

                Navigator.pop(context);
              },
              child: const Text(
                'Place Order',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
      ),
    );
  }
}
