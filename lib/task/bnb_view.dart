
import 'package:flutter/material.dart';
import 'products_view.dart';

class BnbView extends StatefulWidget {
  const BnbView({super.key});

  @override
  State<BnbView> createState() => _BnbViewState();
}

class _BnbViewState extends State<BnbView> {
  int _currentIndex = 0;

  // Pages content
  final List<Widget> _pages = const [
    ProductsView(), //0
    Center(child: Text("Home Page", style: TextStyle(fontSize: 24))),
    
    Center(child: Text("Search Page", style: TextStyle(fontSize: 24))), //1
    Center(child: Text("Contact Us Page", style: TextStyle(fontSize: 24))), //2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Nav Example")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Explicitly set the type to fixed
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Producs"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Search"),
          BottomNavigationBarItem( icon: Icon(Icons.contact_mail),label: "Contact Us",),
        ],
      ),
    );
  }
}
