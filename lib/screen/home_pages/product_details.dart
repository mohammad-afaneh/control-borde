
import 'package:control_board/controller/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final String id;

  ProductDetails(this.id);
  final Products productsController = Get.put(Products());

  @override
  Widget build(BuildContext context) {
    var prodList = Get.put(Products()).productsList;

    var filteredItem = prodList.firstWhere((element) => element.id == id, orElse: () => null);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: filteredItem == null ? null : Text(filteredItem.title),
          actions: [
            //FlatButton(onPressed: ()=> productsController.updateData(id), child: Text("Update Data"))
          ],
      ),
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                const SizedBox(height: 10),
                buildContainer(filteredItem.imageUrl, filteredItem.id),
                const SizedBox(height: 10),
                buildCard(filteredItem.title, filteredItem.description,
                    filteredItem.price),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async{
          await productsController.delete(id).then((value) => Get.back());
          //Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),
    );
  }

  SizedBox buildContainer(String image, String id) {
     return  SizedBox(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: (image != null)
              ? Image.network(image,fit: BoxFit.fill)
              : Image.network('https://i.imgur.com/sUFH1Aq.png'),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
     return Card(
      elevation: 10,
      margin: const EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.black),
            Text(desc,
                style: const TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            const Divider(color: Colors.black),
            Text(
              "\$$price",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
