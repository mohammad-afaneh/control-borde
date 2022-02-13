import 'package:control_board/screen/home_pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/auth_controller.dart';
import 'forgot_password.dart';

class LoginPage extends StatelessWidget {
  static const String signUp = 'Don\'t have a account? SignUp';
  static const String login = 'Login';
  static const String emailHint = 'Enter your Email';
  static const String passwordHint = 'Enter your Password';
  static const String authFail = 'Authentication Fail';

  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.lightGreen,
                ))
              : SingleChildScrollView(
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
                          login,
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
                                  hintText: emailHint,
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
                                  hintText: passwordHint,
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
                        InkWell(
                          onTap: () async {
                            await authController.forgotPassword()
                                ? Get.offAll(Forogt_Password())
                                : Get.snackbar(
                                    authFail, authController.errorText.value);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Forgot your Password ?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.indigoAccent,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: GestureDetector(
                          onTap: () async {
                            await authController.signIn()
                                ? Get.offAll(Main_Screen())
                                : Get.snackbar(
                                    authFail, authController.errorText.value);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Text(
                              login,
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                        )),

                        const SizedBox(
                          height: 25,
                        ),
                        Builder(
                          builder: (ctx) => Align(
                            alignment: const Alignment(1.2, 0.90),
                            child: InkWell(
                              onTap: () async {
                                Get.offAll(()=>Main_Screen());
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('x', true);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Skip',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 35,
                                    color: Colors.lightGreen,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
