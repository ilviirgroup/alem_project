import 'package:flutter/material.dart';

import 'search/components/search_list_view.dart';

class SearchData extends StatefulWidget {
  static const String id = 'search_data';

  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  TextEditingController searchController = TextEditingController();
  String searchTx;
  @override
  void initState() {
    super.initState();
    searchController.text = searchTx;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchTx = value;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30.0,
                    ),
                    contentPadding: EdgeInsets.only(left: 15, top: 15.0),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.blue,
                    )),
              ),
            ),
          ),
          Expanded(
              child: SearchListView(
            name: searchTx,
          ))
        ],
      ),
    ));
  }
}
