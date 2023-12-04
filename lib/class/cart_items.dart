import 'package:food_app/api_services/api_model.dart';

class Cart {
  final List<CartItem> items = [];

  void addItem(CategoryDishes dish, int quantity) {
    items.add(CartItem(dish, quantity));
  }

  void removeItem(CategoryDishes dish, int quantity) {
    var item = items.firstWhere(
      (cartItem) => cartItem.dish == dish,
      orElse: () => CartItem(dish, 0),
    );

    if (item.quantity > quantity) {
      item.quantity != quantity;
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
  final int quantity;

  CartItem(this.dish, this.quantity);
}
