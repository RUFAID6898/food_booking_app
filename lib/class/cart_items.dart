import 'package:flutter/material.dart';
import 'package:food_app/api_services/api_model.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> items = [];

  void addItem(CategoryDishes dish, int quantity) {
    var existingItem = items.firstWhere(
      (cartItem) => cartItem.dish == dish,
      orElse: () => CartItem(dish, 0),
    );

    if (existingItem.quantity == 0) {
      items.add(CartItem(dish, quantity));
    } else {
      existingItem.quantity += quantity;
    }
  }

  void removeItem(CategoryDishes dish, int quantity) {
    var item = items.firstWhere(
      (cartItem) => cartItem.dish == dish,
      orElse: () => CartItem(dish, 0),
    );

    if (item.quantity > quantity) {
      item.quantity = quantity;
    } else {
      items.remove(item);
    }
  }

  double getTotal() {
    return items.fold(
        0, (total, item) => total + (item.dish.dishPrice! * item.quantity));
  }

  void clearCart() {
    items.clear();
  }
}

class CartItem {
  final CategoryDishes dish;
  int quantity;

  CartItem(this.dish, this.quantity);
}
