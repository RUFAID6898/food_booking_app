import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/cart/cart_page.dart';
import 'package:food_app/class/cart_items.dart';
import 'package:food_app/class/item_counder.dart';

import 'package:food_app/api_services/api_model.dart';
import 'package:food_app/api_services/api_services.dart';
import 'package:food_app/home/home_widgets/ithem_widget.dart';

import 'package:food_app/services/auth_services.dart';
// import 'package:food_app/widget/counder_button.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late Future<List<UserModel>> results;
  late Cart cart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    results = ApiServicess().getuser();
    cart = Cart();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CartProvider>(context);

    AuthService authService = AuthService();
    final size = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(
                              cart: cart,
                            ),
                          ));
                    },
                    icon: const Icon(Icons.shopping_cart_rounded)),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            )
          ],
          bottom: const TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'From The Barnyar',
                ),
                Tab(
                  text: 'from',
                )
              ]),
        ),
        drawer: Container(
          width: size * 0.9,
          color: Colors.amber,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.green,
                ),
                height: 250,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(FirebaseAuth
                          .instance.currentUser!.photoURL
                          .toString()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(FirebaseAuth.instance.currentUser!.displayName
                        .toString())
                  ],
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    authService.signOut();

                    authService.logoutUser();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('LogOut'))
            ],
          ),
        ),
        body: FutureBuilder(
          future: results,
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var tableMenuList = snapshot.data![index].tableMenuList;
                  if (tableMenuList != null && tableMenuList.isNotEmpty) {
                    var categoryDishes = tableMenuList[0].categoryDishes;
                    if (categoryDishes != null && categoryDishes.isNotEmpty) {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryDishes.length,
                            itemBuilder: (context, dishIndex) {
                              var dish = categoryDishes[dishIndex];

                              return ItemWidget(
                                  size: size,
                                  dish: dish,
                                  cart: cart,
                                  counterProvider: counterProvider);
                            },
                          ),
                        ],
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
