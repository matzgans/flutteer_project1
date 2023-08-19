import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'main_page.dart';
import 'transaction_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // fore move page
  final List _children = [MainPage(), TransactionPage()];

  int _currentIndex = 0;

  void movePage(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      appBar: (_currentIndex == 0)
          ? CalendarAppBar(
              accent: Colors.green,
              lastDate: DateTime.now(),
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(
                Duration(days: 140),
              ),
            )
          : PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
                child: Text("Transactions"),
              ),
              preferredSize: Size.fromHeight(100),
            ),
      floatingActionButton: Visibility(
        visible: (_currentIndex != 1) ? true : false,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                movePage(0);
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                movePage(1);
              },
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}
