// import 'package:awael_bmi/Modals/CartItem.dart';
// import 'package:awael_bmi/Modals/product.dart';
// import 'package:awael_bmi/Providers/shoppingCartProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../app_localizations.dart';
//
// AlertDialog addPurchaseAlertDialog(
//     CartItem item,
//     Product product,
//     BuildContext context,
//     ShoppingCartProvider provider,
//     AnimationController controller,
//     GlobalKey<ScaffoldState> key) {
//   return AlertDialog(
//     title: Text(AppLocalizations.of(context).translate("addingToShoppingCart")),
//     content: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Text('${AppLocalizations.of(context).translate("quantity")}: '),
//         Expanded(
//           child: TextFormField(
//             onChanged: (value) {
//               provider.quantity = value;
//               // if (value.isNotEmpty) {
//               //   double no = double.parse(value);
//               //   provider.quantity = value;
//               // } else {
//               //   SnackBar snackbar =
//               //       SnackBar(content: Text("you didn't add quantity"));
//               //   // Scaffold.of(key.currentContext).showSnackBar(snackbar);
//               //   key.currentState.showSnackBar(snackbar);
//               // }
//             },
//             keyboardType: TextInputType.number,
//             inputFormatters: <TextInputFormatter>[
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             ],
//           ),
//         ),
//       ],
//     ),
//     actions: [
//       FlatButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(AppLocalizations.of(context).translate("cancel"))),
//       FlatButton(
//           onPressed: () {
//             double no;
//             //TODO: check product Quantity before ordering
//             if (provider.quantity.isNotEmpty) {
//               no = double.parse(provider.quantity);
//             } else {
//               Navigator.pop(context);
//               SnackBar snackbar = SnackBar(
//                   content: Text(AppLocalizations.of(context)
//                       .translate("youDidntAddQuantity")));
//               key.currentState.showSnackBar(snackbar);
//             }
//             if (no < (double.parse(product.quantity))) {
//               CartItem temp = CartItem(
//                   product: product,
//                   productId: item.productId,
//                   nameAr: item.nameAr,
//                   nameEn: item.nameEn,
//                   productNumber: item.productNumber,
//                   quantity: item.quantity,
//                   productPrice: item.productPrice,
//                   totalPrice: item.quantity * item.productPrice,
//                   image: item.image);
//               provider.addItem(temp);
//               print(provider.quantity);
//               provider.quantity = '';
//               Navigator.pop(context);
//               if(controller!=null) {
//                 controller.forward().then((value) {
//                   controller.reverse();
//                 });
//               }
//             } else {
//               /*TODO: sufficient quantity
//               * don't forget parsing the message
//               * by the the thresholds */
//               Navigator.pop(context);
//               SnackBar snackbar = SnackBar(
//                   content: Text(AppLocalizations.of(context)
//                       .translate("unsufficientQuantity")));
//               key.currentState.showSnackBar(snackbar);
//             }
//           },
//           child: Text(AppLocalizations.of(context).translate("add"))),
//     ],
//   );
// }
