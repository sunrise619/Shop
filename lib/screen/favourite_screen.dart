import 'package:final_project/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen
import '../widget/product_widget.dart';
import '../provider/products.dart';
import '../screen/product_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> _products =
        Provider.of<Products>(context).filterProducts(isFavourite: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
          child: ProductWidget(
              id: _products[index].id,
              title: _products[index].title,
              imgUrl: _products[index].imgUrl,
              isFav: _products[index].isFav),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProductDetailsScreen(
                  id: _products[index].id,
                ),
              ),
            );
          },
        ),
        itemCount: _products.length,
      ),
    );
  }
}
