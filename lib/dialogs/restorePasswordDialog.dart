// // import 'package:awael_bmi/Providers/LoginProvider.dart';
// // import 'package:awael_bmi/blocs/forgetPassword/forget_password_cubit.dart';
// // import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
//
// import '../app_localizations.dart';
//
// AlertDialog restorePasswordDialog(
//     BuildContext context, LoginProvider provider) {
//   return AlertDialog(
//     title: Text(AppLocalizations.of(context).translate("forgotPassword")),
//     content: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
//       cubit: ForgetPasswordCubit(provider),
//       builder: (context, state) {
//         if (state is ForgetPasswordInitial) {
//           return MainContent();
//         } else if (state is ForgetPasswordLoading) {
//           return Container(
//             height: 128,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (state is ForgetPasswordLoaded) {
//           return Container(
//             height: 128,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (state is ForgetPasswordError) {
//           // TODO: Error Message for ForgotPassword
//         }
//       },
//     ),
//
//   );
// }
//
// class MainContent extends StatefulWidget {
//
//
//
//   @override
//   _MainContentState createState() => _MainContentState();
// }
//
// class _MainContentState extends State<MainContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         //email
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Text('${AppLocalizations.of(context).translate("email")}: '),
//             Expanded(
//               child: Consumer<LoginProvider>(
//                 builder:(_,provider,__)=> TextFormField(
//                   // controller: _controller,
//                   decoration: InputDecoration(
//                     // prefixIcon: Icon(Icons.lock_open, color: Colors.grey),
//                     // hintText: 'Confirm Password',
//                     errorText:provider.emailValidator?null:"error",
//
//                     // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                   ),
//                   onChanged: (value) {
//                     provider.emailValidator = EmailValidator.validate(value);
//                     // print(widget.provider.emailValidator);
//                     provider.usingEmailToRestore = value;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   // inputFormatters: <TextInputFormatter>[
//                   //   FilteringTextInputFormatter.allow(RegExp(
//                   //       r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
//                   // ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // SizedBox(
//         //   height: 8.0,
//         // ),
//         // //phone number
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.center,
//         //   mainAxisSize: MainAxisSize.max,
//         //   children: [
//         //     Text('${AppLocalizations.of(context).translate("phone")}: '),
//         //     Expanded(
//         //       child: TextFormField(
//         //         onChanged: (value) {
//         //           provider.usingPhoneToRestore = value;
//         //         },
//         //         keyboardType: TextInputType.phone,
//         //         // inputFormatters: <TextInputFormatter>[
//         //         //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//         //         // ],
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         SizedBox(
//           height: 8.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             FlatButton(
//               textColor: Theme.of(context).primaryColor,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 AppLocalizations.of(context).translate("cancel"),
//               ),
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             Consumer<LoginProvider>(
//               builder:(_,provider,__)=> FlatButton(
//
//                 disabledColor: Colors.black45,
//                 disabledTextColor: Colors.white,
//                 color: Theme.of(context).primaryColor,
//                 textColor: Colors.white,
//                 onPressed:provider.emailValidator? () {
//                   //TODO :send password request
//                 }:null,
//                 child: Text(
//                   AppLocalizations.of(context).translate("ok"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
// // Widget mainContent(BuildContext context, LoginProvider provider) {
// //   TextEditingController _controller =  TextEditingController();
// //   return
// // }
