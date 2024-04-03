import 'package:flutter/material.dart';
import 'package:tiktok_clone/colors.dart';

class CustomTxtFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String labelText;
  final bool isObscure;
  const CustomTxtFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.isObscure,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          prefixIcon: Icon(iconData),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(5.0),
          )),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 45,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7)),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(7)),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          )
        ],
      ),
    );
  }
}
