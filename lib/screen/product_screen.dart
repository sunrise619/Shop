import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../provider/products.dart';

//Widget
import '../widget/product_widget.dart';

//Screen
import 'product_details_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _products =
        Provider.of<Products>(context).allProducts();

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
              isFav: false),
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => 
              ProductDetailsScreen(id: _products[index].id),     
             ),
          )
        ),
        
        itemCount: _products.length,    
      ),
    );
  }
}
