import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateCategory extends StatefulWidget {
  final int categoryId;
  final String name;
  final String alemId;
  final String image;

  UpdateCategory({this.categoryId, this.name, this.alemId, this.image});
  @override
  _UpdateCategoryState createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  String updatedName = '';
  String updatedImage = '';
  String updatedAlemid = '';
  String url;
  File _image;

  Map<String, String> headers = {'Content-Type': 'application/json'};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _alemIdController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    _alemIdController = TextEditingController(text: widget.alemId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    url = 'http://127.0.0.1:8000/category-list/${widget.categoryId}';
    return Scaffold(
      appBar: AppBar(title: Text("Обновить категорию")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
// ----------------- Upload Image Button ----------------- //
            RaisedButton(
              child: Text(
                'Обновить изображение',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              onPressed: () => uploadImage(),
            ),
            SizedBox(height: 20.0),
// ----------------- Image Field ----------------- //
            (_image != null)
                ? Image.file(_image)
                : (widget.image != null)
                    ? Image.network(widget.image)
                    : Text('Surat ýok'),
            SizedBox(height: 20.0),

            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
// ----------------- Name FormField ----------------- //
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Необходимые';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Название категории',
                      ),
                      onChanged: (value) {
                        updatedName = value;
                      },
                    ),
                  ),
// ----------------- AlemId FormField ----------------- //
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      controller: _alemIdController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Необходимые";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:
                            'AlemId напр.: wom, man, kid, mob, shoe, elec',
                      ),
                      onChanged: (value) {
                        updatedAlemid = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
// ----------------- Submit Button ----------------- //
            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: RaisedButton.icon(
                color: Colors.greenAccent[700],
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      if (updatedAlemid == '') {updatedAlemid = widget.alemId},
                      if (updatedName == '') {updatedName = widget.name},
                      if (updatedImage == '') {updatedImage = widget.image},
                      http
                          .patch(Uri.parse(url),
                              headers: headers,
                              body:
                                  '{"ai": "$updatedAlemid", "name":"$updatedName", "photo":"$updatedImage"}')
                          .then((http.Response res) {
                        print(res.statusCode);
                      }),
                      Navigator.pop(context),
                      Fluttertoast.showToast(msg: 'Категория обновлена'),
                    }
                },
                icon: Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                label: Text(
                  "Обновить",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage() async {
    final _picker = ImagePicker();

    var image = await _picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
      updatedImage = base64Encode(_image.readAsBytesSync());
    }
  }
}
