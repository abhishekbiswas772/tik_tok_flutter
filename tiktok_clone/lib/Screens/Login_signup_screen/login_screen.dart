import 'package:flutter/material.dart';
import 'package:tiktok_clone/Screens/custom/input_widget.dart';
import 'package:tiktok_clone/colors.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final AuthController _authController = AuthController();

  void performLogin(String email, String password, BuildContext context) async {
    bool resultFromFirebase =
        await _authController.performLoginUser(email, password);
    if (resultFromFirebase) {
      if (context.mounted) {
        Navigator.of(context).pushNamed('/home');
      }
    } else {
      if (context.mounted) {
        var snackBar =
            const SnackBar(content: Text('Signin failed!, Please try again'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TikTok Clone",
                    style: TextStyle(
                        fontSize: 35,
                        color: buttonColor,
                        fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomTxtFieldWidget(
                      controller: _emailTextController,
                      labelText: "Email",
                      iconData: Icons.email,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomTxtFieldWidget(
                      controller: _passwordTextController,
                      labelText: "Email",
                      iconData: Icons.lock,
                      isObscure: true,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      // print("login");
                      performLogin(_emailTextController.text,
                          _passwordTextController.text, context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          color: buttonColor),
                      child: const Center(
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont't have an Account ",
                        style: TextStyle(fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 20, color: buttonColor),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
