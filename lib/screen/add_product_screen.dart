import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../provider/products.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const routeName = 'addScreen';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var _titleController = TextEditingController();
  var _priceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _imgUrlController = TextEditingController();
  var args;
  var isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      args = ModalRoute.of(context)!.settings.arguments;
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Product? product;
    if (args != null) {
      product = Provider.of<Products>(context).productDetails(args['id']);
      _titleController.text = product.title;
      _priceController.text = product.price.toString();
      _descriptionController.text = product.description;
      _imgUrlController.text = product.imgUrl;
    }
    return Scaffold(
      appBar: AppBar(
        title: args == null ? Text('Add Product') : Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              args == null
                  ? Provider.of<Products>(context, listen: false).addProduct(
                      _titleController.text,
                      double.parse(_priceController.text),
                      _descriptionController.text,
                      _imgUrlController.text,
                    )
                  : Provider.of<Products>(context, listen: false).updateProduct(
                      args['id'],
                      _titleController.text,
                      double.parse(_priceController.text),
                      _descriptionController.text,
                      _imgUrlController.text,
                    );

              Navigator.popUntil(context,  ModalRoute.withName('/'));
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10, left: 25, bottom: 10),
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.75,
                )),
            controller: _titleController,
            cursorColor: Theme.of(context).primaryColor,

          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(25),
                hintText: 'Price',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.75,
                )),
            controller: _priceController,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.number,
          ),
          TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 35, left: 25, bottom: 35),
                hintText: 'Description',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.75,
                )),
            controller: _descriptionController,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 2,
          ),
          TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 50, left: 25, bottom: 50),
                hintText: 'Image URL',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: 0.75,
                )),
            controller: _imgUrlController,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 3,
          )
        ],
      ),
    );
  }
}
