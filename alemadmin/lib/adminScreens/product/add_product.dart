import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final _firestoreColor =
    FirebaseFirestore.instance.collection('color').orderBy('id').snapshots();
final _firestoreSize =
    FirebaseFirestore.instance.collection('size').orderBy('id').snapshots();

class AddProduct extends StatefulWidget {
  static const String id = 'add_products';
  final int subId;
  final String categoryAlemId;
  AddProduct({this.subId, this.categoryAlemId});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fieldName = TextEditingController();
  final fieldPrice = TextEditingController();

  File _image;
  Future<File> file;
  final picker = ImagePicker();
  int pictureName = 0;
  int productNumber = 0;
  String pictureId;
  String imageUrl;
  String name;
  String alemid;
  double price;
  String status;
  String description;
  List<String> selectedColors = [];
  List selectedSize = [];
  DocumentReference docRef;
  // Stream<QuerySnapshot> _streamColor;
  // Stream<QuerySnapshot> _streamSize;

  // void initstate() {
  //   super.initState();
  //   _streamColor = FirebaseFirestore.instance
  //       .collection('color')
  //       .orderBy('id')
  //       .snapshots();
  //   _streamSize =
  //       FirebaseFirestore.instance.collection('size').orderBy('id').snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('lastids')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) {
                pictureName = doc.data()['pictures'];
                productNumber = doc.data()['products'];
              })
            });

    Future uploadImage() async {
      PickedFile pickedFile =
          await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        final _storage = FirebaseStorage.instance;
        pictureId = (widget.subId.toString() +
            widget.categoryAlemId +
            (productNumber + 1).toString() +
            '-0');
        try {
          if (_image != null) {
            var snapshot = await _storage
                .ref()
                .child('products')
                .child('$pictureId.jpg')
                .putFile(_image);

            var downloadUrl = await snapshot.ref.getDownloadURL();

            setState(() {
              imageUrl = downloadUrl;
            });
          } else {
            return 'No path received';
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("???????????????? ??????????"),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(height: 10.0),
// ---------------------------------- Image box
          (imageUrl != null)
              ? Image.network(imageUrl)
              : Icon(
                  Icons.image,
                  size: 40.0,
                ),

          SizedBox(height: 10.0),
// ---------------------------------- Upload Image Button
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: () {
              uploadImage();
              FirebaseFirestore.instance
                  .collection('lastids')
                  .doc('lastIds')
                  .update({'pictures': (pictureName + 1)});
            },
            child: Text('?????????????????? ??????????????????????',
                style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
// ---------------------------------- Product Name Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "??????????????????????";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '???????????????????????? ????????????'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Price Form
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "??????????????????????";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: '????????'),
                    onChanged: (value) {
                      price = double.parse(value);
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Status Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "??????????????????????";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: '????????????'),
                    onChanged: (value) {
                      status = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Description Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "??????????????????????";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: '????????????????'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
// ---------------------------------- Colors StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: _firestoreColor,
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
                            title: Text("??????????"),
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
                              "???????????????? ????????",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              selectedColors = results;
                            },
                          ),
                        );
                      },
                    ),
                  ),
// ---------------------------------- Size StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: _firestoreSize,
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
                          if (widget.subId == subCategory) {
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
                            title: Text("??????????????"),
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
                              "???????????????? ????????????",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              selectedSize = results;
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
                alemid = (widget.subId.toString() +
                    widget.categoryAlemId +
                    (productNumber + 1).toString()),
                if (_formKey.currentState.validate())
                  {
                    FirebaseFirestore.instance
                        .collection('lastids')
                        .doc('lastIds')
                        .update({'products': (productNumber + 1)}),

                    docRef =
                        FirebaseFirestore.instance.collection('products').doc(),
                    docRef.set({
                      'documentId': docRef.id,
                      'alemid': alemid,
                      'name': name,
                      'price': price,
                      'description': description,
                      'status': status,
                      'subcategory': widget.subId,
                      'colors': selectedColors,
                      'size': selectedSize,
                      'url': [
                        imageUrl
                      ], //goni surat gosan wagtyn goni array edip sohr etsen gowy bolar
                      // son shony kopeldibermeli
                      'firstPictureName': pictureId,
                    }),
                    print(price),
                    Fluttertoast.showToast(msg: '?????????????? ????????????????'),
                    Navigator.pop(context),

                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  },
              },
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              label: Text('????????????????',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
          ),
        ])));
  }

// Upload image to Firebase Storage
}
