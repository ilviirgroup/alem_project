import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'update_product.dart';

final _firestore = FirebaseFirestore.instance.collection('products');

class ProductItem extends StatelessWidget {
  final int subCategoryId;
  final String documentId;
  final String alemId;
  final String name;
  final int price;
  final String description;
  final String status;
  final List colors;
  final List size;
  final String imageUrl;
  final String firstPictureName;
  final List urls;

  ProductItem({
    this.subCategoryId,
    this.documentId,
    this.alemId,
    this.name,
    this.price,
    this.description,
    this.status,
    this.colors,
    this.size,
    this.imageUrl,
    this.firstPictureName,
    this.urls,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
                content: Text('Вы хотите удалить?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('НЕТ'),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.doc(documentId).delete();
                      Navigator.pop(context);
                    },
                    child: Text('Удалить'),
                  ),
                ]),
          );
        },
        child: GridTile(
          child: (imageUrl != null)
              ? Image.network(imageUrl)
              : Center(
                  child: Text(
                  'Surat ýok',
                  style: TextStyle(color: Colors.black),
                )),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(
              name,
              textAlign: TextAlign.center,
            ),
            trailing: GestureDetector(
                child: Icon(Icons.edit),
                onTap: () {
                  print(imageUrl);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateProduct(
                        subCategoryId: subCategoryId,
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
                        urls: urls,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
