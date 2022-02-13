import 'package:control_board/controller/auth_controller.dart';
import 'package:control_board/controller/bottom_navigation_bar_controller.dart';
import 'package:control_board/controller/cart_control.dart';
import 'package:control_board/screen/home_pages/product_details.dart';
import 'package:control_board/screen/home_pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_products.dart';
import 'home_page.dart';
import 'orders.dart';

class Main_Screen extends StatefulWidget {
  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  final AuthController authController = Get.put(AuthController());
  BottomNavigationBarController bottomNavigationController =
      Get.put(BottomNavigationBarController());

  @override
  void didUpdateWidget(covariant Main_Screen oldWidget) {
    super.didUpdateWidget(oldWidget);
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {});
    }).catchError((onError) => print(onError));
  }

  var listRoute = [
    Orders(),
    MyHomePage(),
    AddProduct(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.lightGreen,
          title: Center(
            child: Image.asset(
              'image/logo3.png',
              height: 30,
              width: 100,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                Get.to(() => Search_screen());
              },
            ),
          ],
        ),
        body: Obx(() {
          return IndexedStack(
            index: bottomNavigationController.currentIndex,
            children: listRoute,
          );
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavigationController.currentIndex,
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                bottomNavigationController.changeIndex(index);
              });
            },
            selectedItemColor: Colors.lightGreen,
            unselectedItemColor: Colors.grey,
            //grey.shade700,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: 'Add Product'),
            ],
          ),
        ));
  }
}
