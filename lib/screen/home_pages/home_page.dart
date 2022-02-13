import 'package:control_board/controller/products.dart';
import 'package:control_board/screen/home_pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    Get.put(Products()).fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Get.put(Products()).fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) => print(onError));
  }

  final _x = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _x,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(10),
              children: [
                SizedBox(
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'image/drugsandmedicines.jpg',
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      //tileColor: Colors.orangeAccent,
                      onTap: () => Get.to(() => detailCard('Medicine')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'image/beauty.jpg',
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      tileColor: Colors.orangeAccent,
                      onTap: () => Get.to(() => detailCard('Beauty Tools')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'image/personal.jpg',
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      tileColor: Colors.orangeAccent,
                      onTap: () => Get.to(() => detailCard('Body Care')),
                    ),
                  ),
                )
              ],
            ), //detailCard(),
    );
  }
}
