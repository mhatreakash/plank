import 'package:flutter/material.dart';

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var _products = [
    {
      'name': 'Sofa',
      'image': 'images/recentImages/sofa12.jpg',
      'oldPrice': 12000,
      'price': 9000,
    },
    {
      'name': 'Harleston Bed',
      'image': 'images/recentImages/bed3.jpg',
      'oldPrice': 29999,
      'price': 27999,
    },
    {
      'name': 'Blue Sofa ',
      'image': 'images/recentImages/sofa11.jpg',
      'oldPrice': 15000,
      'price': 11500,
    },
    {
      'name': 'Dining Table',
      'image': 'images/recentImages/dine1.jpg',
      'oldPrice': 28999,
      'price': 24999,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          child: Hero(
            tag: _products[i]['name'],
            child: Material(
              child: InkWell(
                child: GridTile(
                  child: Image.asset(
                    _products[i]['image'],
                    fit: BoxFit.cover,
                  ),
                  footer: Container(
                    height: 30.0,
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${_products[i]['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "₹ ${_products[i]['price']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
