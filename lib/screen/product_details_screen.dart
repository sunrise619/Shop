import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen
import '../provider/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.id, Key? key}) : super(key: key);
  static const routeName = 'productDetailsScreen';

  final String id;
  @override
  Widget build(BuildContext context) {
    Product _products = Provider.of<Products>(context).productDetails(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_products.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                _products.imgUrl,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money),
                    Text(
                      '     ${_products.price}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description_outlined),
                          Text(
                            ' Description:- ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                      Text(
                        _products.description,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
