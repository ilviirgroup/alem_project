import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_color.dart';
import 'add_product.dart';
import 'add_size.dart';
import 'product_item.dart';

// final _firestore = FirebaseFirestore.instance;

class Products extends StatefulWidget {
  final String subCategoryName;
  final int subId;
  final String categoryAlemId;
  Products({
    this.subCategoryName,
    this.subId,
    this.categoryAlemId,
  });
  static const String id = 'products';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String _value;
  Stream<QuerySnapshot> _firestore;
  // String documentId;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance
        .collection('products')
        .orderBy('alemid')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName ?? ''),
        actions: <Widget>[
          DropdownButton(
            hint: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.library_add,
                      size: 22,
                      color: Colors.blue[700],
                    ),
                    Text(
                      'Добавить',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700]),
                    ),
                  ],
                )),
            items: [
              DropdownMenuItem(
                value: "1",
                child: Text("Новый продукт"),
              ),
              DropdownMenuItem(
                value: "2",
                child: Text("Новый цвет"),
              ),
              DropdownMenuItem(
                value: "3",
                child: Text("Новый размер"),
              )
            ],
            onChanged: (value) {
              setState(
                () {
                  if (value == '1') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddProduct(
                              categoryAlemId: widget.categoryAlemId,
                              subId: widget.subId,
                            )));
                  } else if (value == '2') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddColor()));
                  } else
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddSize(
                              subCategoryId: widget.subId,
                            )));
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final products = snapshot.data.docs.reversed;
          List<ProductItem> productList = [];
          for (var item in products) {
            final documentId = item.data()['documentId'];
            final alemId = item.data()['alemid'];
            final name = item.data()['name'];
            final price = item.data()['price'];
            final description = item.data()['description'];
            final status = item.data()['status'];
            final subCategoryId = item.data()['subcategory'];
            final colors = item.data()['colors'];
            final size = item.data()['size'];
            final pictures = item.data()['url'];
            final imageUrl = pictures[0].toString();
            final firstPictureName = item.data()['firstPictureName'];

            final productItem = ProductItem(
              documentId: documentId,
              alemId: alemId,
              name: name,
              price: price,
              description: description,
              status: status,
              colors: colors,
              size: size,
              imageUrl: imageUrl,
              firstPictureName: firstPictureName,
              subCategoryId: subCategoryId,
              urls: pictures,
            );
            if (widget.subId == subCategoryId) {
              productList.add(productItem);
            }
          }
          return GridView(
            children: productList,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        },
      ),
    );
  }
}
