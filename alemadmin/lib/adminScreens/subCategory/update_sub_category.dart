import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateSubCategory extends StatefulWidget {
  static const String id = 'updateSubCategory';
  final String documentId;
  final String subCategoryName;
  UpdateSubCategory({this.documentId, this.subCategoryName});
  @override
  _UpdateSubCategoryState createState() => _UpdateSubCategoryState();
}

class _UpdateSubCategoryState extends State<UpdateSubCategory> {
  String updatedName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController =
        TextEditingController(text: widget.subCategoryName ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Обновить подкатегорию')),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: textEditingController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Необходимые";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название подкатегории'),
                onChanged: (value) {
                  updatedName = value;
                },
              ),
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
                    if (updatedName == null)
                      {updatedName = widget.subCategoryName},
                    FirebaseFirestore.instance
                        .collection('subcategory')
                        .doc(widget.documentId)
                        .update({'name': updatedName}),
                    Navigator.pop(context),
                    Fluttertoast.showToast(msg: 'Подкатегория обновлена'),

                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  }
              },
              icon: Icon(
                Icons.update,
                color: Colors.white,
              ),
              label: Text(
                "Обновить",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
