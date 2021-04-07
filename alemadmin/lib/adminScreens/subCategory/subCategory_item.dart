import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_sub_category.dart';

final _firestore = FirebaseFirestore.instance.collection('subcategory');

class SubCategoryItem extends StatelessWidget {
  static const String id = "sub_category_item";

  final String subCategoryName;
  final int subCategoryId;
  final String categoryAlemId;

  SubCategoryItem({
    this.subCategoryName,
    this.subCategoryId,
    this.categoryAlemId,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSubCategory(
                    subCategoryName: subCategoryName,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          title: GestureDetector(
              onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Products(
                          subCategoryName: subCategoryName,
                          subId: subCategoryId,
                          categoryAlemId: categoryAlemId,
                        ),
                      ),
                    )
                  },
              child: Text(
                subCategoryName,
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          subtitle: Text('id: $subCategoryId'),
          trailing: GestureDetector(
            onTap: () => {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  content: Text('Вы хотите удалить?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'НЕТ',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        String url = Uri.encodeFull(
                            'http://127.0.0.1:8000/subcategory-list/$subCategoryId');
                        http.delete(Uri.parse(url));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Удалить',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ],
                ),
              ),
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
