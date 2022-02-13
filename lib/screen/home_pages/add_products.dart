import 'dart:io';

import 'package:control_board/controller/products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String title = "";
  String description = "";
  String price = "";
  File image;
  String idProduct = "";
  final Products productsController = Get.put(Products());

  bool _isLoading = false;
  final picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  String dropdownValue = 'Medicine';

  Future getImage(ImageSource src) async {
    final pickerFile = await picker.getImage(source: src);
    setState(() {
      if (pickerFile != null) {
        image = File(pickerFile.path);
      } else {
        print('No Image Slected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Product", hintText: "Product Name"),
                    onChanged: (val) => setState(() => title = val),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "ID", hintText: "Add Id Product"),
                    onChanged: (val) => setState(() => idProduct = val),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Description", hintText: "Product description"),
                    onChanged: (val) => setState(() => description = val),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Price", hintText: "Add price"),
                    onChanged: (val) => setState(() => price = val),
                  ),
                  const SizedBox(height: 10),
                 // const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text("Product Section :",style: TextStyle(fontSize: 20),),
                      const SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Medicine', 'Beauty Tools', 'Body Care']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Product Picture :',style: TextStyle(fontSize: 20),),
                      const SizedBox(width: 10,),
                      IconButton(
                        icon: const Icon(Icons.add_a_photo,size: 30,),
                        onPressed: () {
                          var ad = AlertDialog(
                            title: const Text('Choose Picture From'),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    width: 300,
                                    color: Colors.teal,
                                    child: ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 300,
                                    color: Colors.teal,
                                    child: ListTile(
                                      leading: const Icon(Icons.add_a_photo),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        getImage(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          showDialog(context: context, builder: (ctx) => ad);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RaisedButton(
                      color: Colors.orangeAccent,
                      textColor: Colors.black,
                      child: const Text("Add Product"),
                      onPressed: () {
                        var doublePrice;
                        setState(() {
                          doublePrice = double.tryParse(price) ?? 0.0;
                        });

                        if (title == "" ||
                            description == "" ||
                            price == "" ||
                            idProduct == "" ||
                            image==null ||
                            dropdownValue=="") {
                          Toast.show("Please enter all field", context,
                              duration: Toast.LENGTH_LONG);
                        } else if (doublePrice == 0.0) {
                          Toast.show("Please enter a valid price", context,
                              duration: Toast.LENGTH_LONG);
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          productsController
                              .add(
                            id: idProduct,
                            title: title,
                            description: description,
                            price: doublePrice,
                            imageUrl: image,
                            section: dropdownValue
                          )
                              .catchError((_) {
                            return showDialog<Null>(
                              context: context,
                              builder: (innerContext) => AlertDialog(
                                title: const Text("An error occurred!"),
                                content: const Text('Something went wrong.'),
                                actions: [
                                  FlatButton(
                                      child: const Text("Okay"),
                                      onPressed: () => Get.deleteAll())
                                ],
                              ),
                            );
                          }).then((_) {
                            setState(() {
                              _isLoading = false;
                            });
                            //Get.offAll(() => Main_Screen());
                          });
                        }
                      }),
                ],
              ),
            ),
    );
  }
}
