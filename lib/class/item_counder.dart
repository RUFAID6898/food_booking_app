import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> counters = {};

  void incrementCounter(String dishId) {
    counters.update(dishId, (value) => value + 1, ifAbsent: () => 1);

    notifyListeners();
  }

  void decrementCounter(String dishId) {
    counters.update(dishId, (value) => (value > 0) ? value - 1 : 0,
        ifAbsent: () => 0);
    notifyListeners();
  }

  int getCounter(String dishId) {
    return counters[dishId] ?? 0;
  }
}
