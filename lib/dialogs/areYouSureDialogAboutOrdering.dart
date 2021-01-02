// import 'package:awael_bmi/Modals/CartItem.dart';
// import 'package:awael_bmi/Providers/shoppingCartProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../app_localizations.dart';
//
// AlertDialog areYouSureDialogAboutOrdering(BuildContext context,{Function yes ,Function no,List<CartItem> list}) {
//
//   double mTotalPrice  =0;
//   for(int i=0;i<list.length;i++)
//     mTotalPrice+=list[i].totalPrice;
//
//   double mTotalItemsCount  =0;
//   for(int i=0;i<list.length;i++)
//     mTotalItemsCount+=list[i].quantity;
//
//   // double mTotalCategoryCount  =list.length as double;
//
//   String content =
//   '''${AppLocalizations.of(context).translate("totalPriceOfTheOrder")}: $mTotalPrice
// ${AppLocalizations.of(context).translate("totalItemsOfTheOrder")}: $mTotalItemsCount
// ${AppLocalizations.of(context).translate("totalCategoryOfTheOrder")}: ${list.length}''';
//
//   return AlertDialog(
//     title: Text(AppLocalizations.of(context).translate("areYouSureAboutOrderingTheseItems")),
//     content: SingleChildScrollView(child: Text(content)),
//     actions: [
//       FlatButton(
//         onPressed: yes,
//         child: Text(AppLocalizations.of(context).translate("yes")),
//       ),
//       FlatButton(
//         onPressed: no,
//         child: Text(AppLocalizations.of(context).translate("no")),
//       ),
//     ],
//   );
// }
