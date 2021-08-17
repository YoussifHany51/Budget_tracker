import 'package:budget_tracker/expenses/cat_row.dart';
import 'package:budget_tracker/expenses/pieChart.dart';
import 'package:flutter/material.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(193, 214, 233, 1),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: height * 0.43,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Row(
                children: [
                  //Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    child: CategoriesRow(),
                    flex: 3,
                  ),
                  Expanded(
                    child: PieChartItem(),
                    flex: 4,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
