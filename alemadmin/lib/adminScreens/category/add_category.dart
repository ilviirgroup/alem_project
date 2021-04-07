import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  static const String id = "add_category";
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String name = '';
  String alemid = '';
  File _image;
  String base64Image =
      "http://127.0.0.1:8000/media/Category/2021/04/06/tayyn_5.jpg";

  String url = 'http://127.0.0.1:8000/results/';

  Future postData(String alemid, String name, String photo) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'connection': 'keep-alive',
        },
        body: jsonEncode(<String, String>{
          "ai": alemid,
          "name": name,
          "photo": photo,
        }),
      );
      return response;
    } catch (e) {
      print(e);
    }
  }

  final picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Добавить категорию")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  'Загрузить изображение',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
                onPressed: () {
                  chooseImage();
                },
              ),
              SizedBox(height: 20.0),
              (_image != null)
                  ? Image.file(_image)
                  : Placeholder(
                      fallbackHeight: 200,
                      fallbackWidth: double.infinity,
                    ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
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
                          name = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
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
                          alemid = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                        postData(alemid, name, base64Image),
                        Navigator.pop(context),
                        // Fluttertoast.showToast(msg: 'Категория добавлена'),
                      }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Добавить",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
      }
    });
  }

  // Future addCategory() async {
  //   String url = "http://127.0.0.1:8000/category-list/";
  //   Map<String, String> headers = {'Content-Type': 'application/json'};
  //   http.Response res = await http.post(Uri.parse(url),
  //       headers: headers,
  //       body: json.encode({
  //         "ai": "alemid",
  //         "name": "name",
  //       }));
  //   print(res.statusCode);
  //   return res;
  // }
}
