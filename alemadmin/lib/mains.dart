import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'service.dart';

void main() {
  runApp(MyApp(categories: fetchCategories()));
}

List<Category> parseCategories(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Category>((json) => Category.fromMap(json)).toList();
}

Future<List<Category>> fetchCategories() async {
  var uri = Uri.parse('http://127.0.0.1:8000/category-list/');
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return parseCategories(response.body);
  } else {
    throw Exception('Unable to fetch categories from the REST API');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.categories}) : super(key: key);
  final Future<List<Category>> categories;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(
          title: 'Product Navigation demo home page', categories: categories),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final Future<List<Category>> categories;
  const MyHomePage({Key key, this.title, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Navigation')),
      body: Center(
        child: FutureBuilder(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ProductBoxList(items: snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ProductBoxList extends StatelessWidget {
  final List<Category> items;
  const ProductBoxList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(items);
    print(items.length);
    return ListView.builder(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProductBox(item: items[index]),
          onTap: () {
            print(items[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  final Category item;
  const ProductPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Scaffold(
        appBar: AppBar(
          title: Text(this.item.name),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(this.item.photo),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.item.id.toString()),
                          Text(this.item.ai),
                          Text(
                            this.item.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}

class ProductBox extends StatelessWidget {
  final Category item;
  const ProductBox({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(this.item.photo),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(this.item.id.toString()),
                      Text(this.item.ai),
                      Text(
                        this.item.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class RatingBox extends StatefulWidget {
//   RatingBox({Key key}) : super(key: key);

//   @override
//   _RatingBoxState createState() => _RatingBoxState();
// }

// class _RatingBoxState extends State<RatingBox> {
//   int _rating = 0;
//   void _setRatingAsOne() {
//     setState(() {
//       _rating = 1;
//     });
//   }

//   void _setRatingAsTwo() {
//     setState(() {
//       _rating = 2;
//     });
//   }

//   void _setRatingAsThree() {
//     setState(() {
//       _rating = 3;
//     });
//   }

//   Widget build(BuildContext context) {
//     double _size = 20;
//     print(_rating);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             icon: _rating >= 1
//                 ? Icon(Icons.star, size: _size)
//                 : Icon(
//                     Icons.star_border,
//                     size: _size,
//                   ),
//             color: Colors.red[500],
//             onPressed: _setRatingAsOne,
//             iconSize: _size,
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             icon: _rating >= 2
//                 ? Icon(Icons.star, size: _size)
//                 : Icon(
//                     Icons.star_border,
//                     size: _size,
//                   ),
//             color: Colors.red[500],
//             onPressed: _setRatingAsTwo,
//             iconSize: _size,
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             icon: _rating >= 3
//                 ? Icon(Icons.star, size: _size)
//                 : Icon(
//                     Icons.star_border,
//                     size: _size,
//                   ),
//             color: Colors.red[500],
//             onPressed: _setRatingAsThree,
//             iconSize: _size,
//           ),
//         ),
//       ],
//     );
//   }
// }
