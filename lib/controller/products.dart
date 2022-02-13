import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String section;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.section,
  });
}

class Products extends GetxController {
  List<Product> productsList = <Product>[].obs ;
  List nameProducts=[].obs;
  String authToken;

  //Products(this.authToken,this.productsList);
  final database = FirebaseDatabase.instance.reference().child('product');
  Reference storage = FirebaseStorage.instance.ref().child('product_image');

  getData(String authToken2, List<Product> productsList2) {
    authToken = authToken2;
    productsList = productsList2;
  }

  Future<void> fetchData() async {
    try {
      final extractedData = await database.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((prodId, prodData) {
          final prodIndex =
              productsList.indexWhere((element) => element.id == prodId);
          if (prodIndex >= 0) {
            productsList[prodIndex] = Product(
                id: prodData['id'],
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'],
                imageUrl: prodData['imageUrl'],
              section: prodData['section']
                );
            nameProducts=[prodData['title'],prodData['id']];
          } else {
            productsList.add(Product(
                id: prodData['id'],
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'].toDouble(),
                imageUrl: prodData['imageUrl'],
              section: prodData['section']
                ));
            nameProducts.add(prodData['title']);
          }
        });
      });
    } catch (error) {
      throw error;
    }
  }


  Future<void> updateData(String id) async {

    final prodIndex = productsList.indexWhere((element) => element.id == id);
    try {
      await database.child(id).update({
        "title": "new title 4",
        "description": "new description 2",
        "price": 199.8,
        "section":"Medicine",
        "imageUrl":"https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
      });
      productsList[prodIndex] = Product(
        id: id,
        title: "new title 4",
        description: "new description 2",
        price: 199.8,
        imageUrl:
            "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
      );

    } catch (error) {
      throw error;
    }
  }

  Future<void> add(
      {String id,
      String title,
      String description,
      double price,
      File imageUrl,
      String section}) async {
    try {
      final ref = await storage.child(id + '.jpg');
      await ref.putFile(imageUrl);
      final url = await ref.getDownloadURL();
      await database.child(id).set({
        "title": title,
        "id": id,
        "description": description,
        "price": price,
        "imageUrl": url,
        "section":section
      });
      productsList.add(Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: url,
        section: section
      ));
    } catch (error) {
      throw error;
    }
  }

 Future<void> delete(String id) async {
    final prodIndex = productsList.indexWhere((element) => element.id == id);
    var prodItem = productsList[prodIndex];
    productsList.removeAt(prodIndex);
     await database.child(id).remove();
    prodItem = null;
  }
}
