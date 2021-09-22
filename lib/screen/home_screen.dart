import 'package:final_project/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//SCREEN
import './product_screen.dart';
import './favourite_screen.dart';
import './your_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, dynamic>> _pages;

  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'title': 'MyShop', 'page': ProductScreen()},
      {'title': 'Favourite', 'page': FavouriteScreen()}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
        actions: [
          if (_currentIndex == 0)
             IconButton(
                  icon: Icon(Icons.card_giftcard),
                  onPressed: () {
                    Navigator.pushNamed(context, YourProductsScreen.routeName);
                    }
                     
                 
                ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<Products>(context).getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _pages[_currentIndex]['page'];
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _changePage,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
