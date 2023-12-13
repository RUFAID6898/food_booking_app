import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CounterButton extends StatelessWidget {
  Function()? incrementCounter;
  String count;
  Function()? decrementCounter;

  CounterButton(
      {super.key,
      required this.decrementCounter,
      required this.incrementCounter,
      required this.count});

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          Text(
            count,
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: incrementCounter,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
