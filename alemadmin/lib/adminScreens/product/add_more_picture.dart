import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMorePicture extends StatefulWidget {
  final List urls;
  final String firstPictureName;
  final String documentId;
  AddMorePicture({this.urls, this.firstPictureName, this.documentId});
  @override
  _AddMorePictureState createState() => _AddMorePictureState();
}

class _AddMorePictureState extends State<AddMorePicture> {
  File _image;
  final picker = ImagePicker();
  List urls = [];

  _addImage() async {
    final theImage = await picker.getImage(source: ImageSource.gallery);
    if (theImage != null) {
      setState(() {
        _image = File(theImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Добавить изображение"),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.documentId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  Map<String, dynamic> data = snapshot.data.data();
                  List<dynamic> urls = data['url'];
                  print(urls);
                  return SizedBox(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        // itemExtent: 80.0,
                        padding: EdgeInsets.all(10.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: urls.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GridTile(
                              child: Container(
                                color: Colors.black45,
                                child: (urls[index] != null)
                                    ? Image.network(urls[index])
                                    : Center(
                                        child: Text('Surat ýok'),
                                      ),
                              ),
                            ),
                          );
                        },
                      ));
                },
              ),
// ---------------------------------- Image box
              Divider(
                color: Colors.black,
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: _image == null
                    ? Center(
                        child: Icon(Icons.photo,
                            color: Colors.blueAccent, size: 30),
                      )
                    : Image.file(_image),
              ),
              SizedBox(height: 10.0),
// ---------------------------------- Add Image Button
              RaisedButton(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                onPressed: () {
                  _addImage();
                },
                child: Text(
                  'Выбрать изображение',
                  style: TextStyle(color: Colors.white),
                ),
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
                  Navigator.pop(context);
                },
                child: Text('Загрузить изображение',
                    style: TextStyle(color: Colors.white)),
              ),
            ])));
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    // var file = File(_image.path);
    final urlsLength = widget.urls.length;
    final lengthToString = urlsLength.toString();

    if (_image != null) {
      var snapshot = await _storage
          .ref()
          .child('products')
          .child('${widget.firstPictureName + lengthToString}.jpg')
          .putFile(_image);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.documentId)
          .update({
        'url': FieldValue.arrayUnion([downloadUrl])
      });

      // setState(() {
      //   imageUrl = downloadUrl;
      // });
    } else {
      return 'No path received';
    }
  }
}
