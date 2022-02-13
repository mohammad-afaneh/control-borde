import 'package:control_board/controller/cart_control.dart';
import 'package:control_board/screen/home_pages/product_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orders_details extends StatefulWidget {
  @override
  State<Orders_details> createState() => Orders_detailsState();
}

class Orders_detailsState extends State<Orders_details> {
  final Cart_Control cartList = Get.find();
  int _itemCount = 1;

  @override
  void didUpdateWidget(covariant Orders_details oldWidget) {
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
    print(cartList.carttsList.map((e) => e.title));
    print(cartList.InfoList.map((e) => e.Name));
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body:SafeArea(child: Obx(() {
        return ListView(children: [
          Column(
            children: cartList.carttsList.map((item) {
              if (item.title != '') {
                return Column(children: [
                  Builder(
                    builder: (innerContext) => Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          Get.to(() => ProductDetails(item.id));
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.grey,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      width: 70,
                                      height: 100,
                                      child: (item.imageUrl != null)
                                          ? Image.network(
                                              item.imageUrl,
                                              fit: BoxFit.fill,
                                              width: 50,
                                              height: 50,
                                            )
                                          : Image.network(
                                              'https://i.imgur.com/sUFH1Aq.png'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 10),
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                        ),
                                        SizedBox(width: 13),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      "\$${item.price}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
          Center(
              child: Text(
            'Total :${tot()}',
            style: TextStyle(fontSize: 20),
          )),
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(5),
            child: Column(
              children: cartList.InfoList.map((item) {
                if (item.Name != '') {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name : ' + item.Name,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Phone Number : ' + item.number,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Address : ' + item.address,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Payment Method : ' + item.payment_method,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Time : ' + item.time,
                          style: TextStyle(fontSize: 25),
                        ),
                      ]);
                } else {
                  return const SizedBox();
                }
              }).toList(),
            ),
          ),
        ]);
      })),
    );
  }
}
