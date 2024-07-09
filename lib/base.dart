import 'package:flutter/material.dart';
import 'package:interro/pages/home.dart';
import 'package:interro/pages/profil.dart';
import 'package:stroke_text/stroke_text.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int indexPage = 0;
  List pages = [
    Home(),
    Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        //backgroundColor: Color(0x44000000),
        elevation: 0,
        title: const StrokeText(
          text: "INTERRO",
          textStyle: TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 7, 5, 136),
            fontFamily: "CadhoToys",
          ),
          strokeColor: Colors.lightBlue,
          strokeWidth: 5,
        ),
        actions: [],
      ),
      //drawer: const MyDrawer(),
      body: pages[indexPage],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            selectedFontSize: 1,
            unselectedFontSize: 1,
            currentIndex: indexPage,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.blue,
            onTap: (index) {
              setState(() {
                indexPage = index;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
