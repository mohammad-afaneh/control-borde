import 'package:control_board/controller/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details.dart';

class Search_screen extends StatefulWidget {
  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  final Products prodName = Get.find();
  TextEditingController search = TextEditingController();
  List foundRes=[];
  @override
  initState() {
    foundRes = prodName.nameProducts;
    super.initState();
  }
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = prodName.nameProducts;
    } else {
      results = prodName.nameProducts
          .where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundRes = results;
    });
  }
  String retId(String name){
    var prodList = Get.put(Products()).productsList;

    var filteredItem = prodList.firstWhere((element) => element.title == name, orElse: () => null);
    return filteredItem.id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: foundRes.isNotEmpty
                  ? ListView.builder(
                itemCount: foundRes.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(foundRes[index]),
                  color: Colors.amberAccent,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    onTap:()=>  Get.to(() => ProductDetails(retId(foundRes[index]))),
                    title: Text(foundRes[index]),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
