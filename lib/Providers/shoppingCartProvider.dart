// import 'package:awael_bmi/Modals/CartItem.dart';
// import 'package:flutter/material.dart';
//
// class ShoppingCartProvider extends ChangeNotifier {
//
//   String _quantity='';
//   List<CartItem> _cartList=[];
//   String _deliveryEmployee ="";
//   bool _isOpend = false;
//
//
//   bool get isOpend => _isOpend;
//
//   set isOpend(bool value) {
//     _isOpend = value;
//   }
//
//   bool updateList(int i,CartItem item) {
//     if(_cartList.isNotEmpty){
//       if(_cartList.length>=i){
//         _cartList[i]=item;
//         notifyListeners();
//         return true;
//       }
//       return false;
//     }else{
//       return false;
//     }
//   }
//
//   bool addItem(CartItem item) {
//     _cartList.add(item);
//     notifyListeners();
//     return true;
//   }
//
//   bool deleteItem(int i) {
//     if (_cartList.isNotEmpty) {
//       if (_cartList.length >= i) {
//         _cartList.removeAt(i);
//         notifyListeners();
//         return true;
//       }
//       return false;
//     } else {
//       return false;
//     }
//   }
//
//   List<CartItem> get cartList => _cartList;
//
//   set cartList(List<CartItem> value) {
//     _cartList = value;
//     notifyListeners();
//   }
//
//
//   String get quantity => _quantity;
//
//   set quantity(String value) {
//     _quantity = value;
//   }
//
//   String get deliveryEmployee => _deliveryEmployee;
//
//   set deliveryEmployee(String value) {
//     _deliveryEmployee = value;
//     notifyListeners();
//   }
// }