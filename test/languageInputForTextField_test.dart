import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:ewarrenty/Blocs/InitData/init_data_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() {
  testWidgets(
      'English only TextInputField test where the input is english text without formaters ',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var _fullNameTextEditingController = TextEditingController();
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        Locale testLocale = Locale("en");
        return MaterialApp(
          locale: testLocale,
          home: Material(
            child: TextFormField(
              onTap: () {
                // BlocProvider.of<InitDataCubit>(context)
                //     .fullNameIsError = false;
                // BlocProvider.of<InitDataCubit>(context)
                //     .emit(InitDataFullNameReset());
              },
              controller: _fullNameTextEditingController,
              // inputFormatters: [
              //   // testLocale.languageCode.contains("ar")
              //   //     ? FilteringTextInputFormatter.allow(
              //   //         RegExp('[\p{Arabic}\s\p{N}]'))
              //   //     :
              //   FilteringTextInputFormatter.allow(RegExp('[a-z\sA-Z]')),
              // ],
              decoration: InputDecoration(
                // errorText:
                // ((state is InitDataFullNameError) ||
                //     (BlocProvider.of<InitDataCubit>(
                //         context)
                //         .addressIsError))
                //     ? AppLocalizations.of(context)
                //     .translate("addFullName")
                //     : null,
                // labelText: AppLocalizations.of(context).translate("yourName"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (value) {
                //TODO: make the user enter his name in english
                BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
                BlocProvider.of<InitDataCubit>(context).fullName = value;
              },
            ),
          ),
        );
      },
    ));

    var textEditFieldFinder = find.byType(TextFormField);
    var testText = "hello from the other side";
    await tester.enterText(textEditFieldFinder, testText);
    await tester.pump();
    // Verify that our counter starts at 0.
    expect(find.text(testText), findsOneWidget);
  });
  testWidgets(
      'English only TextInputField test where the input is english text with formaters ',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var _fullNameTextEditingController = TextEditingController();
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        Locale testLocale = Locale("en");
        return MaterialApp(
          locale: testLocale,
          home: Material(
            child: TextFormField(
              onTap: () {
                // BlocProvider.of<InitDataCubit>(context)
                //     .fullNameIsError = false;
                // BlocProvider.of<InitDataCubit>(context)
                //     .emit(InitDataFullNameReset());
              },
              controller: _fullNameTextEditingController,
              inputFormatters: [
                testLocale.languageCode.contains("ar")
                    ? FilteringTextInputFormatter.allow(
                    RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
                    : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
              ],
              decoration: InputDecoration(
                // errorText:
                // ((state is InitDataFullNameError) ||
                //     (BlocProvider.of<InitDataCubit>(
                //         context)
                //         .addressIsError))
                //     ? AppLocalizations.of(context)
                //     .translate("addFullName")
                //     : null,
                // labelText: AppLocalizations.of(context).translate("yourName"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (value) {
                //TODO: make the user enter his name in english
                BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
                BlocProvider.of<InitDataCubit>(context).fullName = value;
              },
            ),
          ),
        );
      },
    ));

    var textEditFieldFinder = find.byType(TextFormField);
    var testText = "Ibrahim Tarek Shaglil ";
    await tester.enterText(textEditFieldFinder, testText);
    await tester.pump();
    // Verify that our counter starts at 0.
    expect(find.text(testText), findsOneWidget);
  });
  testWidgets(
      'arabic only TextInputField test where the input is english text with formaters ',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var _fullNameTextEditingController = TextEditingController();
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        Locale testLocale = Locale("ar");
        return MaterialApp(
          locale: testLocale,
          home: Material(
            child: TextFormField(
              onTap: () {
                // BlocProvider.of<InitDataCubit>(context)
                //     .fullNameIsError = false;
                // BlocProvider.of<InitDataCubit>(context)
                //     .emit(InitDataFullNameReset());
              },
              controller: _fullNameTextEditingController,
              inputFormatters: [
                testLocale.languageCode.contains("ar")
                    ? FilteringTextInputFormatter.allow(
                    RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
                    : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
              ],
              decoration: InputDecoration(
                // errorText:
                // ((state is InitDataFullNameError) ||
                //     (BlocProvider.of<InitDataCubit>(
                //         context)
                //         .addressIsError))
                //     ? AppLocalizations.of(context)
                //     .translate("addFullName")
                //     : null,
                // labelText: AppLocalizations.of(context).translate("yourName"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (value) {
                //TODO: make the user enter his name in english
                BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
                BlocProvider.of<InitDataCubit>(context).fullName = value;
              },
            ),
          ),
        );
      },
    ));

    var textEditFieldFinder = find.byType(TextFormField);
    var testText = "Ibrahim Tarek Shaglil";
    await tester.enterText(textEditFieldFinder, testText);
    await tester.pump();
    // Verify that our counter starts at 0.
    expect(find.text("  "), findsOneWidget);
  });
  testWidgets(
      'arabic only TextInputField test where the input is arabic text with formaters ',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var _fullNameTextEditingController = TextEditingController();
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        Locale testLocale = Locale("ar");
        return MaterialApp(
          locale: testLocale,
          home: Material(
            child: TextFormField(
              onTap: () {
                // BlocProvider.of<InitDataCubit>(context)
                //     .fullNameIsError = false;
                // BlocProvider.of<InitDataCubit>(context)
                //     .emit(InitDataFullNameReset());
              },
              controller: _fullNameTextEditingController,
              inputFormatters: [
                testLocale.languageCode.contains("ar")
                    ? FilteringTextInputFormatter.allow(
                        RegExp(r"[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF ]"))
                    : FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
              ],
              decoration: InputDecoration(
                // errorText:
                // ((state is InitDataFullNameError) ||
                //     (BlocProvider.of<InitDataCubit>(
                //         context)
                //         .addressIsError))
                //     ? AppLocalizations.of(context)
                //     .translate("addFullName")
                //     : null,
                // labelText: AppLocalizations.of(context).translate("yourName"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (value) {
                //TODO: make the user enter his name in english
                BlocProvider.of<InitDataCubit>(context).fullNameIsError = false;
                BlocProvider.of<InitDataCubit>(context).fullName = value;
              },
            ),
          ),
        );
      },
    ));

    var textEditFieldFinder = find.byType(TextFormField);
    var testText = "أبجد هوز حطي كلمن سعفص قرشت ثخذ ضظغ";
    await tester.enterText(textEditFieldFinder, testText).then((value) => null);
    await tester.pump();
    // Verify that our counter starts at 0.
    expect(find.text(testText), findsOneWidget);
  });
}
