import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String user;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;
  final Set colorList;
  final Set sizeList;

  CartItem({
    @required this.id,
    @required this.user,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imgUrl,
    @required this.colorList,
    @required this.sizeList,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {

    return {..._items};

  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId,
      double price,
      int quantity,
      String title,
      String imgUrl,
      String user,
      Set colorList,
      Set sizeList,
      ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
            (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            imgUrl:existingCartItem.imgUrl,
              user: existingCartItem.user,
              colorList: existingCartItem.colorList,
              sizeList: existingCartItem.sizeList

        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
            id: productId,
            title: title,
            price: price,
            quantity: quantity,
            imgUrl: imgUrl,
              user: user,
              colorList: colorList,
              sizeList: sizeList

        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
            imgUrl: existingCartItem.imgUrl,
                user: existingCartItem.user,
                sizeList: existingCartItem.sizeList,
                colorList: existingCartItem.colorList
          ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}