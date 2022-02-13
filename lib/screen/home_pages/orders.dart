import 'package:control_board/controller/cart_control.dart';
import 'package:control_board/screen/home_pages/product_details.dart';
import 'package:control_board/utils/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_details.dart';

class Orders extends StatefulWidget {
  @override
  State<Orders> createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  final Cart_Control cartList = Get.find();
  int _itemCount = 1;
@override
  void initState() {
    super.initState();
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {});
    });
  }
  @override
  void didUpdateWidget(covariant Orders oldWidget) {
    super.didUpdateWidget(oldWidget);
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {});
    });
  }

  double tot() {
    double cartTotal = 0.0;

    cartList.carttsList.forEach((element) {
      cartTotal += element.price;
    });
    return cartTotal;
  }
  @override
  Widget build(BuildContext context) {
    CloudFunctions.users.get().then((value) => print(value.toString()));
    return Scaffold(
        body: ListView(children: [
      Column(
        children: [
          cartList.InfoList.isNotEmpty
              ? Column(
                  children: cartList.InfoList.map((e) {
                    if (e.Name != '') {
                      return TextButton(
                        onPressed: () {
                          Get.to(() => Orders_details());
                        },
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                e.Name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          /*IconButton(
                          onPressed: () async {
                            await cartList
                                .delete()
                                .then((value) => null);
                          },
                          icon: Icon(Icons.delete, color: Colors.amberAccent))*/
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No Orders',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  }).toList(),
                )
              : const Text(
                  'No Orders',
                  style: TextStyle(fontSize: 20),
                ),
        ],
      ),
    ]));
  }
}
