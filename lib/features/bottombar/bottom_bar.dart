import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newpro/features/auth/screens/loginpage.dart';
import 'package:newpro/features/product_add/screens/product_add.dart';
import 'package:newpro/features/product_display/screens/product_display.dart';
import 'package:newpro/features/product_edit/screens/product_edit.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  List page = [
    Loginscreen(),
    ProductAdd(),
    ProductDisplay(),
    Text('data'),
    Text('data'),

  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        onTap: onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'imageupload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'myaccount',
          ),
        ],
      ),
    );
  }
}
