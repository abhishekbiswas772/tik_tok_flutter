import 'package:flutter/material.dart';
import 'package:tiktok_clone/Screens/ProfileScreen/profile_screen.dart';
import 'package:tiktok_clone/Screens/custom/input_widget.dart';
import 'package:tiktok_clone/Screens/search/search_screen.dart';
import 'package:tiktok_clone/Screens/video/video_screen.dart';
import 'package:tiktok_clone/Screens/video/video_show_screen.dart';
import 'package:tiktok_clone/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _initPageIndex = 0;
  List<Widget> allPagesWidget = [
    const VideoShowScreen(),
    const SearchScreen(),
    const VideoScreen(),
    Text("messages"),
    const ProfileScreen(uid: "")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPagesWidget[_initPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _initPageIndex = index;
            });
          },
          currentIndex: _initPageIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          backgroundColor: backgroundColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                label: "Search"),
            BottomNavigationBarItem(icon: CustomIcon(), label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  size: 30,
                ),
                label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: "Profile"),
          ]),
    );
  }
}
