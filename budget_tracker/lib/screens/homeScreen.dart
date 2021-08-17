import 'package:budget_tracker/expenses/expenses_view.dart';
import 'package:budget_tracker/models/item.dart';
import 'package:budget_tracker/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

import 'addItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Item>? itemList;

  @override
  Widget build(BuildContext context) {
// ignore: unnecessary_null_comparison
    if (itemList == null) {
      // ignore: deprecated_member_use
      itemList = <Item>[];
      updateListView();
    }
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Budget Tracker',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToAdd(Item(' ', ' ', ' ', 2), 'Add Item');
          },
          tooltip: 'Add Item',
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey[600]),
      body: SafeArea(
        child: Container(
          height: height,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  height: height * 0.35,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.35,
                    // width: 200.0,
                    child: ExpensesView(),
                  )),
              Positioned(
                  //top: 280,
                  top: height * 0.38,
                  //height: height * 0.88,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.35,
                    // width: 200.0,
                    child: getItemList(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ListView getItemList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 8,
            child: Container(
              margin: EdgeInsets.all(0.8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2.0,
                    color: getCategoryColor(this.itemList![position].category),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ]),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      getCategoryColor(this.itemList![position].category),
                ),
                title: Text(
                  this.itemList![position].title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  this.itemList![position].price +
                      ' LE ' +
                      '  -  ' +
                      this.itemList![position].date,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: InkWell(
                    onTap: () {
                      _delete(context, itemList![position]);
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    )),
              ),
            ),
          );
        });
  }

  static Color getCategoryColor(int category) {
    switch (category) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.yellow;
      case 5:
        return Colors.blueGrey;
      default:
        return Colors.white;
    }
  }

  // ignore: unused_element
  void _delete(BuildContext context, Item item) async {
    int result = await databaseHelper.deleteItem(item.id);
    if (result != 0) {
      _showSnackBar(context, "Item deleted");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Item>> itemListFuture = databaseHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }

  void navigateToAdd(Item item, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddItem(item, title);
    }));
    if (result == true) {
      updateListView();
    }
  }
}
