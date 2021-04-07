import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'add_more_picture.dart';

final _firestore = FirebaseFirestore.instance;
final _firestoreProducts = FirebaseFirestore.instance.collection('products');

class UpdateProduct extends StatefulWidget {
  static const String id = 'add_products';
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
  UpdateProduct({
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
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  String updatedName = '';
  int updatedPrice = 0;
  String updatedDescription = '';
  String updatedStatus = '';
  List updatedColors = [];
  List updatedSize = [];
  // String updatedImageUrl;
  DocumentReference docRef;
  Stream<QuerySnapshot> _streamColor;
  Stream<QuerySnapshot> _streamSize;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _descriptionController;
  TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    _priceController =
        TextEditingController(text: widget.price.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
    _statusController = TextEditingController(text: widget.status ?? '');
    _streamColor = FirebaseFirestore.instance
        .collection('color')
        .orderBy('id')
        .snapshots();
    _streamSize =
        FirebaseFirestore.instance.collection('size').orderBy('id').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Обновить'),
          centerTitle: false,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton.icon(
                color: Colors.greenAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddMorePicture(
                          urls: widget.urls,
                          firstPictureName: widget.firstPictureName,
                          documentId: widget.documentId)));
                },
                icon: Icon(Icons.add_photo_alternate, color: Colors.white),
                label:
                    Text('Изображений', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          (widget.imageUrl != null)
              ? Image.network(widget.imageUrl)
              : Container(height: 20.0, child: Text("Surat yok")),
          SizedBox(height: 10.0),
// ---------------------------------- Add Image Button
          SizedBox(height: 10.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
// ---------------------------------- Product Name Form

                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Наименование товара'),
                    onChanged: (value) {
                      updatedName = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Price Form
                  TextFormField(
                    controller: _priceController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Цена'),
                    onChanged: (value) {
                      updatedPrice = int.parse(value);
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Status Form
                  TextFormField(
                    controller: _statusController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Статус'),
                    onChanged: (value) {
                      updatedStatus = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Description Form
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Описание'),
                    onChanged: (value) {
                      updatedDescription = value;
                    },
                  ),
// ---------------------------------- Colors StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: _streamColor,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          );
                        }
                        final colors = snapshot.data.docs.reversed;
                        List<String> colorsList = [];
                        for (var item in colors) {
                          final name = item.data()['name'];
                          colorsList.add(name);
                        }
                        final _items = colorsList
                            .map((color) => MultiSelectItem(color, color))
                            .toList();

                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
// ---------------------------------- Colors MultiSelectField
                          child: MultiSelectDialogField(
                            searchable: true,
                            items: _items,
                            title: Text("Цвета"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            buttonIcon: Icon(
                              Icons.color_lens,
                              color: Colors.blue,
                            ),
                            buttonText: Text(
                              "Выберите цвет",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            initialValue: widget.colors,
                            onConfirm: (results) {
                              updatedColors = results;
                            },
                          ),
                        );
                      },
                    ),
                  ),
// ---------------------------------- Size StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: _streamSize,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          );
                        }
                        final _size = snapshot.data.docs.reversed;
                        List sizeList = [];
                        for (var item in _size) {
                          final name = item.data()['name'];
                          final subCategory = item.data()['subcategory'];
                          if (widget.subCategoryId == subCategory) {
                            sizeList.add(name);
                          }
                        }
                        final _items = sizeList
                            .map((size) => MultiSelectItem(size, size))
                            .toList();

                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
// ---------------------------------- Size MultiSelectField
                          child: MultiSelectDialogField(
                            searchable: true,
                            items: _items,
                            title: Text("Размеры"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            buttonText: Text(
                              "Выберите размер",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            initialValue: widget.size,
                            onConfirm: (results) {
                              updatedSize = results;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
// ---------------------------------- Submit Button
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: RaisedButton.icon(
              elevation: 8,
              color: Colors.greenAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              onPressed: () => {
                if (_formKey.currentState.validate())
                  {
                    if (updatedName == '') {updatedName = widget.name},
                    if (updatedPrice == 0) {updatedPrice = widget.price},
                    if (updatedStatus == '') {updatedStatus = widget.status},
                    if (updatedDescription == '')
                      {updatedDescription = widget.description},
                    _firestoreProducts.doc(widget.documentId).update({
                      'name': updatedName,
                      'price': updatedPrice,
                      'description': updatedDescription,
                      'status': updatedStatus,
                    }),
                    if (updatedColors.isNotEmpty)
                      {
                        _firestoreProducts
                            .doc(widget.documentId)
                            .update({'colors': updatedColors}),
                      },
                    if (updatedSize.isNotEmpty)
                      {
                        _firestoreProducts
                            .doc(widget.documentId)
                            .update({'size': updatedSize}),
                      },
                    Fluttertoast.showToast(msg: 'Продукт обнавлен'),
                    Navigator.pop(context),
                  },
              },
              icon: Icon(Icons.update, color: Colors.white),
              label: Text("Обновить",
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
            ),
          ),
        ])));
  }
}
