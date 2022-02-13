import 'package:control_board/controller/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details.dart';
class detailCard extends StatefulWidget {
  final String sections;
  detailCard(this.sections,);


  @override
  detailCardState createState() => detailCardState();
}

class detailCardState extends State<detailCard> {
  final Products prodList =
  Get.find(); //Get.put(Products() ).productsList.obs;
  @override
  Widget build(BuildContext context) {
    print(prodList.productsList.map((e) => e.title));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightGreen,
        title: Text(widget.sections,style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(child: Obx(() {return ListView(
          children: prodList.productsList.map((item) {
            if(item.section==widget.sections){
              return Builder(
                builder: (innerContext) => FlatButton(
                  onPressed: () {
                    Get.to(() => ProductDetails(item.id));
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Card(
                        elevation: 10,
                        color: const Color.fromRGBO(115, 138, 119, 1),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                width: 130,
                                child: Hero(
                                  tag: item.id,
                                  child: (item.imageUrl != null)
                                      ? Image.network(item.imageUrl, fit: BoxFit.fill,width: 100,height: 130,)
                                      : Image.network(
                                      'https://i.imgur.com/sUFH1Aq.png'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                  ),
                                  Divider(color: Colors.white),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      item.description,
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 14),
                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Divider(color: Colors.white),
                                  Text(
                                    "\$${item.price}",
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                  ),
                                  SizedBox(height: 13),
                                ],
                              ),
                            ),
                            Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return const SizedBox();
            }

          }).toList());})),
    );
  }
}
