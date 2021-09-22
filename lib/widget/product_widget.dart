import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../provider/products.dart';

class ProductWidget extends StatelessWidget {
  final String id, title, imgUrl;
  final bool isFav;

  const ProductWidget(
      {required this.id,
      required this.title,
      required this.imgUrl,
      required this.isFav,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 8,
      child: (Column(children: [
        Container(
          color: Color.fromRGBO(183, 183, 183, 0.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isFav)
                Align(
                  child: GestureDetector(
                    onTap: () => Provider.of<Products>(context, listen: false)
                        .changeFavStatus(id, true),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 4.0, top: 4, bottom: 4),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 23,
                      ),
                    ),
                    // color: Colors.red,
                  ),
                  alignment: Alignment.centerRight,
                ),
              if (isFav)
                Align(
                  child: GestureDetector(
                    onTap: () => Provider.of<Products>(context, listen: false)
                        .changeFavStatus(id, false),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 23,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                ),
            ],
          ),
        ),
        Expanded(
          child: Image.network(imgUrl),
        ),
        Container(
          color: Color.fromRGBO(183, 183, 183, 0.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
