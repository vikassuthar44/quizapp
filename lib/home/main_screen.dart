import 'package:flutter/material.dart';
import 'package:quiz_app/home/category_data.dart';
import 'package:quiz_app/home/home_screen.dart';
import 'package:quiz_app/score/ScoreScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Category> categoryList;
  var currentSelectedPage = 0;

  final pages = [const HomeScreen(), const ScoreScreen()];

  List<IconData> bottomItem = [Icons.home, Icons.score];

  @override
  void initState() {
    super.initState();
  }

  void updatePage(int index) {
    setState(() {
      currentSelectedPage = index;
    });
  }

  Widget bottomBar() {
    return BottomNavigationBar(
        currentIndex: currentSelectedPage,
        onTap: (int index) {
          setState(() {
            currentSelectedPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Score", icon: Icon(Icons.score)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: pages[currentSelectedPage],
    );
  }
}
