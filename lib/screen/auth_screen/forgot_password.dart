import 'package:control_board/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Forogt_Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(body: SafeArea(child: Obx(() {
      return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 30.0,
                    ),
                    Image.asset(
                      'image/logo2.png',
                      width: 200,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Rest Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.0,
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(0)),
                      child: TextField(
                          controller: authController.emailController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.0),
                              ),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightGreen, width: 0.0),
                              ))),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                          controller: authController.passwordController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.0),
                              ),
                              hintText: 'Rest password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightGreen, width: 0.0),
                              ))),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ])));
    })));
  }
}
