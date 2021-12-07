import 'package:bombscrypto_simulator/roi/ui/roi_page.dart';
import 'package:bombscrypto_simulator/team/list/ui/team_page.dart';
import 'package:bombscrypto_simulator/util/image/images.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  final List<Widget> pages = const [TeamsPage(), RoiPage()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: ProjectColors.backgroundLightColor,
        selectedItemColor: ProjectColors.textDarkColor,
        backgroundColor: ProjectColors.backgroundDarkColor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'ROI',
          ),
        ],
      ),
    );
  }
}
