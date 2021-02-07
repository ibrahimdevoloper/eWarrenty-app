import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddNewCustomer extends StatefulWidget {
  @override
  _AddNewCustomerState createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  String _birthdayDate;

  String _religion;
  List _religions = ["Muslim", "Christian", "Other"];
  String _country;
  List _countrys = [
    "Syria",
    "Sudan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer",style: GoogleFonts.cairo(),),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Firstname in English",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Firstname in Arabic",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Lastname in English",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Lastname in Arabic",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          FlatButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(_birthdayDate ?? "Birthday Date"),
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().add(Duration(days: -365 * 120)),
                      lastDate: DateTime.now().add(Duration(days: 1)),
                      helpText: "Select Bill Date")
                  .then((value) {
                setState(() {
                  _birthdayDate = "${value.year}/${value.month}/${value.day}";
                });
              });
            },
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DropdownButton<String>(
                  onChanged: (e) {
                    setState(() {
                      _religion = e;
                    });
                  },
                  isExpanded: true,
                  hint: Text("Customer Religion"),
                  value: _religion,
                  items: _religions
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: ListTile(title: Text(e)),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: DropdownButton<String>(
                  onChanged: (e) {
                    setState(() {
                      _country = e;
                    });
                  },
                  isExpanded: true,
                  hint: Text("Customer Country"),
                  value: _country,
                  items: _countrys
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: ListTile(title: Text(e)),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Customer E-mail",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Add Username",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.black45),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    labelText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    labelText: "Confirm Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
