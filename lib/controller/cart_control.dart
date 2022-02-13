import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  double total;
  int itemCount;

  Cart({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    @required this.itemCount,
  });
}

class InfoUser {
  final String Name;
  final String address;
  final String payment_method;
  final String time;
  final String number;

  InfoUser({
    @required this.Name,
    @required this.address,
    @required this.payment_method,
    @required this.time,
    @required this.number,
  });
}

class Cart_Control extends GetxController {
  List<Cart> carttsList = <Cart>[].obs;
  List<InfoUser> InfoList = <InfoUser>[].obs;
  String authToken;
  List idProducts = [].obs;

  /* Future<bool> retData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool dec = prefs.getBool('x');
    return dec;
  }
  Widget screen = (retData()== false || dec == null) ? const PView() : MyApp();*/
  getData(String authToken2, List<Cart> cartList2) {
    authToken = authToken2;
    carttsList = cartList2;
  }

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child('Cart').child('userCart');
  final DatabaseReference database2 =
      FirebaseDatabase.instance.reference().child('Cart');

  Future<void> fetchData() async {
    try {
      /*database2
          .once()
          .then((value) => print('val :' + value.value.toString()));*/
      final extractedData = await database
          .child('ProductCart')
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((prodId, prodData) {
          final prodIndex =
              carttsList.indexWhere((element) => element.id == prodId);
          if (prodIndex >= 0) {
            carttsList[prodIndex] = Cart(
              id: prodData['id'],
              title: prodData['title'],
              price: prodData['price'].toDouble(),
              imageUrl: prodData['imageUrl'],
              itemCount: prodData['itemCount'],
            );

            idProducts.add(prodData['id']);
          } else {
            carttsList.add(Cart(
              id: prodData['id'],
              title: prodData['title'],
              price: prodData['price'].toDouble(),
              imageUrl: prodData['imageUrl'],
              itemCount: prodData['itemCount'],
            ));
          }
        });
      });
    } catch (error) {
      throw error;
    }
    try {
      final extractedData2 =
          await database.child('Info').once().then((DataSnapshot snapshot) {
        database.printInfo();
        if (snapshot.value != null) {
          Map<dynamic, dynamic> values = snapshot.value;
          final prodIndex = InfoList.indexWhere((
            element,
          ) =>
              element.Name == values['Name']);
          if (prodIndex >= 0) {
            InfoList[prodIndex] = InfoUser(
              Name: values['Name'],
              address: values['address'],
              payment_method: values['payment_method'],
              time: values['time'],
              number: values['number'],
            );
          } else {
            InfoList.add(InfoUser(
              Name: values['Name'],
              address: values['address'],
              payment_method: values['payment_method'],
              time: values['time'],
              number: values['number'],
            ));
          }
        } else {
          InfoList.clear();
        }
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete() async {
    carttsList.clear();
    await database.remove();
  }
}
