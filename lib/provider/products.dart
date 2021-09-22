import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  String id, title, description, imgUrl;
  double price;
  bool isFav;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imgUrl,
      required this.price,
      required this.isFav});
}



class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> filterProducts({required bool isFavourite}) {
    return _products.where((element) => element.isFav == isFavourite).toList();
  }

  List<Product> allProducts() {
    return _products
        .where((element) => element.isFav == true || element.isFav == false)
        .toList();
  }

  Future<void> getProducts() async {
    var dbRef = FirebaseDatabase().reference().child('products');
    var response = await dbRef.get();
    var extractedData = response.value;
    _products = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((id, data) {
      _products.add(Product(
        id: id,
        title: data['title'],
        description: data['description'],
        imgUrl: data['imgUrl'],
        price: data['price'].toDouble(),
        isFav: data['isFav'],
      ));
    });
  }

  Future<void> addProduct(
      String title, double price, String description, String imgUrl) async {
    var dbRef = FirebaseDatabase().reference().child('products').push();
    await dbRef.set({
      'title': title,
      'price': price,
      'description': description,
      'imgUrl': imgUrl,
      'isFav': false,
    });
    notifyListeners();
  }

  Future <void> deleteProduct(String id) async{
    var dbRef = FirebaseDatabase().reference().child('products').child(id);
    await dbRef.remove();
    _products.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  Future <void> changeFavStatus(String id, bool isFav) async{
    var dbRef = FirebaseDatabase().reference().child('products').child(id);
    await dbRef.update({
      'isFav' : isFav,
    });

    notifyListeners();
  }

  Future <void> updateProduct(String id,  String title, double price, String description, String imgUrl)async{
    var dbRef = FirebaseDatabase().reference().child('products').child(id);
    await dbRef.update({
      'title': title,
      'price': price,
      'description': description,
      'imgUrl': imgUrl,
      'isFav': false,
    });

    notifyListeners();
  }

  Product productDetails(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
