
import 'package:final_project/screen/your_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

//screen
import '/screen/home_screen.dart';
import './provider/products.dart';
import './screen/add_product_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.pink[300],
          accentColor: Colors.blue[200],
          canvasColor: Colors.grey[300],
        ),
        routes: {
          '/' : (_) => HomeScreen(), 
          AddProductScreen.routeName : (context) => AddProductScreen(),
          YourProductsScreen.routeName :(context) => YourProductsScreen(),
        
        },
      ),
    );
  }
}
