import 'package:final_project/provider/products.dart';
import 'package:final_project/screen/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Provider
import '../provider/products.dart';

class YourProductsScreen extends StatelessWidget {
  const YourProductsScreen({Key? key}) : super(key: key);
  static const routeName = 'yourProductScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> _products = Provider.of<Products>(context).allProducts();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Your Products'),
        actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName);
              },
              icon: Icon(Icons.add),
            ),
          
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.15,
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(_products[index].imgUrl),
              ),
              title: Text(_products[index].title),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Theme.of(context).primaryColor,
              icon: Icons.edit,
              onTap: () {
                Navigator.pushNamed(context, AddProductScreen.routeName,
                    arguments: {
                      'id': _products[index].id,
                    });
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Theme.of(context).accentColor,
              icon: Icons.delete,
              onTap: () => Provider.of<Products>(context, listen: false)
                  .deleteProduct(_products[index].id),
            ),
          ],
        ),
        separatorBuilder: (context, index) => Divider(
          height: 5,
        ),
        itemCount: _products.length,
      ),
    );
  }
}
