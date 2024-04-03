import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Screens/custom/input_widget.dart';
import 'package:tiktok_clone/colors.dart';
import 'package:tiktok_clone/controllers/auth_controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameContoller = TextEditingController();
  final AuthController _authController = AuthController();
  File? picImage;

  void onTapRegister(String username, String password, String email,
      File? image, BuildContext context) async {
    bool resultFromFirebase = await _authController.performRegisterUser(
        username, password, image, email);
    if (image != null) {
      if (resultFromFirebase) {
        if (context.mounted) {
          Navigator.of(context).pushNamed('/home');
        }
      } else {
        if (context.mounted) {
          var snackBar =
              const SnackBar(content: Text('Signup Failed, Please Try Again'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      if (context.mounted) {
        var snackBar = const SnackBar(content: Text('Profile Pic Needed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void onTapPicImage(BuildContext context) async {
    File? isPickedImage = await _authController.picImageFuncs();
    if (isPickedImage != null) {
      picImage = isPickedImage;
      if (context.mounted) {
        setState(() {});
      }
    } else {
      if (context.mounted) {
        var snackBar =
            const SnackBar(content: Text('Please Select a profile pic'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _usernameContoller.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                      "Register",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),
                    Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: (picImage == null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: const Image(
                                      image: NetworkImage(
                                          "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg")),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(picImage ?? File(""))),
                        ),
                        Positioned(
                          bottom: -5,
                          left: 100,
                          child: IconButton(
                              onPressed: () {
                                onTapPicImage(context);
                              },
                              icon: const Icon(Icons.add_a_photo)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomTxtFieldWidget(
                        controller: _usernameContoller,
                        labelText: "Username",
                        iconData: Icons.person,
                        isObscure: false,
                      ),
                    ),
                    const SizedBox(height: 15),
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
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomTxtFieldWidget(
                        controller: _passwordTextController,
                        labelText: "Password",
                        iconData: Icons.lock,
                        isObscure: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        onTapRegister(
                            _usernameContoller.text,
                            _passwordTextController.text,
                            _emailTextController.text,
                            picImage,
                            context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: buttonColor),
                        child: const Center(
                          child: Text("Register",
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
                          "Alreay have an Account ",
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/login");
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: buttonColor),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
