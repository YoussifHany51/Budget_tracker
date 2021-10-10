import 'package:budget_tracker/models/item.dart';
import 'package:budget_tracker/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  final String appBartitle;
  final Item item;
  AddItem(this.item, this.appBartitle);

  @override
  AddItemState createState() => AddItemState(this.item, this.appBartitle);
}

class AddItemState extends State<AddItem> {
  static var _category = [
    'Food',
    'Personal',
    'Entertainment',
    'Transportation',
    'Other'
  ];

  DatabaseHelper helper = DatabaseHelper();

  Item? item;
  String appBartitle;

  String _title = '';
  String _price = '';
  // DateTime _date = DateTime.now();

  //TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  AddItemState(this.item, this.appBartitle);

  // final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  // _handleDatePicker() async {
  //   final DateTime? date = await showDatePicker(
  //       context: context,
  //       initialDate: _date,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100));
  //   if (date != null && date != _date) {
  //     setState(() {
  //       _date = date;
  //     });
  //     dateController.text = _dateFormatter.format(date);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    titleController.text = item!.title;
    priceController.text = item!.price;
    return Scaffold(
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () => moveToLastScreen(),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                size: 30,
                                color: Colors.blueGrey[900],
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(appBartitle,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextFormField(
                              // controller: titleController,
                              // onChanged: (value) {
                              //   updateTitle();
                              // },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextFormField(
                              //controller: priceController,
                              // onChanged: (value) {
                              //   updatePrice();
                              // },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText: 'Price',
                                  labelStyle: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 20, bottom: 20),
                          //   child: TextField(
                          //     readOnly: true,
                          //     controller: dateController,
                          //     onTap: _handleDatePicker,
                          //     decoration: InputDecoration(
                          //         labelText: 'Date',
                          //         labelStyle: TextStyle(
                          //             fontSize: 18, color: Colors.black),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         )),
                          //   ),
                          // ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 0.5)),
                                child: DropdownButton(
                                  hint: Text('Select Category'),
                                  iconSize: 28,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  items: _category
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(
                                        dropDownStringItem,
                                      ),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  //  value: getCatAsString(item!.category),
                                  value: getCatAsString(item!.category),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      debugPrint('user selected $value');
                                      updateCatAsInt(value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[500],
                                borderRadius: BorderRadius.circular(30)),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                // setState(() {
                                //   debugPrint('button clicked');
                                //   _save();
                                // });
                              },
                            ),
                          ),
                        ])))));
  }

  void updateCatAsInt(String value) {
    switch (value) {
      case 'Food':
        item!.category = 1;
        break;
      case 'Personal':
        item!.category = 2;
        break;
      case 'Entertainment':
        item!.category = 3;
        break;
      case 'Transportation':
        item!.category = 4;
        break;
      case 'Other':
        item!.category = 5;
        break;
    }
  }

  String getCatAsString(int value) {
    dynamic cat;
    switch (value) {
      case 1:
        cat = _category[0];
        break;
      case 2:
        cat = _category[1];
        break;
      case 3:
        cat = _category[2];
        break;
      case 4:
        cat = _category[3];
        break;
      case 5:
        cat = _category[4];
        break;
    }
    return cat;
  }

  void updateTitle() {
    item!.title = titleController.text;
  }

  void updatePrice() {
    item!.price = priceController.text;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    moveToLastScreen();
    item!.date = DateFormat.yMMMd().format(DateTime.now());
    // ignore: unused_local_variable
    final int result = await helper.insertItem(item!);

    // ignore: unnecessary_null_comparison
    // if (item!.id != 0) {
    //   result = await helper.updateItem(item!);
    // }
    // else {
    //   result = await helper.insertItem(item!);
    // }

    // if (result == 0) {
    //   _showAlert('Status', 'Item Saved');
    // } else {
    //   _showAlert('Status', 'Item Not Saved');
    // }
  }

  // void _showAlert(String title, String message) {
  //   AlertDialog alertDialog = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alertDialog);
  // }
}
