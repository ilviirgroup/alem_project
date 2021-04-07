import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'adminScreens/admin_home.dart';
import 'adminScreens/app_messages.dart';
import 'adminScreens/app_users.dart';
import 'adminScreens/category/add_category.dart';
import 'adminScreens/category/categories_screen.dart';
import 'adminScreens/login_screen.dart';
import 'adminScreens/orders/orders.dart';
import 'adminScreens/product/products_screen.dart';
import 'adminScreens/search_data.dart';
import 'adminScreens/subCategory/add_sub_category.dart';
import 'adminScreens/subCategory/subCategories_screen.dart';
import 'adminScreens/subCategory/subCategory_item.dart';
import 'adminScreens/subCategory/update_sub_category.dart';
import 'people_upsert.dart';
import 'welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/peopleUpsert': (BuildContext context) => PeopleUpsert(),
        AdminHome.id: (context) => AdminHome(),
        AppMessages.id: (context) => AppMessages(),
        Categories.id: (context) => Categories(),
        AppUsers.id: (context) => AppUsers(),
        SearchData.id: (context) => SearchData(),
        LoginScreen.id: (context) => LoginScreen(),
        AddCategory.id: (context) => AddCategory(),
        SubCategories.id: (context) => SubCategories(),
        Products.id: (context) => Products(),
        AddSubCategory.id: (context) => AddSubCategory(),
        Orders.id: (context) => Orders(),
        SubCategoryItem.id: (context) => SubCategoryItem(),
        UpdateSubCategory.id: (context) => UpdateSubCategory(),
      },
    );
  }
}
