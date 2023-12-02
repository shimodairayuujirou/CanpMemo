import 'package:flutter/material.dart';
import 'package:memoapp/src/canp_info/canp_info_page.dart';
import 'package:memoapp/src/memo/memo_list.dart';

class BottomNavigaionBar extends StatefulWidget {
  const BottomNavigaionBar({Key? key}) : super(key: key);

  @override
  State<BottomNavigaionBar> createState() => _BottomNavigaionBarState();
}

class _BottomNavigaionBarState extends State<BottomNavigaionBar> {
  static const _screens = [
    MemoPage(),
    CanpInfoPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff3D6E55),
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orange,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 50,
                width: 50,
                child: Icon(Icons.add_to_photos_outlined),
              ),
              label: 'メモ',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 50,
                width: 50,
                child: Icon(Icons.info_outline),
              ),
              label: 'キャンプ情報',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}