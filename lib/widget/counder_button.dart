import 'package:flutter/material.dart';
import 'package:food_app/class/item_counder.dart';
import 'package:provider/provider.dart';

class CounderButton extends StatelessWidget {
  // String decrementCounter;
  Function()? incrementCounter;
  String count;
  Function()? decrementCounter;

  CounderButton(
      {super.key,
      required this.decrementCounter,
      required this.incrementCounter,
      required this.count});

  @override
  Widget build(BuildContext context) {
    // final counterProvider = Provider.of<CartProvider>(context);

    return Container(
      width: 130,
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 224, 27),
          borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: decrementCounter,
            icon: Icon(Icons.remove),
          ),
          Text(count),
          IconButton(
            onPressed: incrementCounter,
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
