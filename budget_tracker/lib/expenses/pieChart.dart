import 'package:budget_tracker/models/item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartItem extends StatefulWidget {
  // PieChartItem(PieChartData pieChartData, {Key? key}) : super(key: key);

  @override
  _PieChartItemState createState() => _PieChartItemState();
}

class _PieChartItemState extends State<PieChartItem> {
  late List<PieChartSectionData> _sections;
  List<Item>? items;

  @override
  void initState() {
    super.initState();
    PieChartSectionData food = PieChartSectionData(
        color: Colors.red,
        value: 28,
        radius: 50,
        titleStyle: TextStyle(fontSize: 20, color: Colors.black));
    PieChartSectionData entertainment = PieChartSectionData(
        color: Colors.blue,
        value: 28,
        radius: 50,
        titleStyle: TextStyle(fontSize: 20, color: Colors.black));
    PieChartSectionData transportation = PieChartSectionData(
        color: Colors.yellow,
        value: 28,
        radius: 50,
        titleStyle: TextStyle(fontSize: 20, color: Colors.black));
    PieChartSectionData personal = PieChartSectionData(
        color: Colors.green,
        value: 50,
        radius: 50,
        titleStyle: TextStyle(fontSize: 20, color: Colors.black));
    PieChartSectionData other = PieChartSectionData(
        color: Colors.blueGrey,
        value: 28,
        radius: 50,
        titleStyle: TextStyle(fontSize: 20, color: Colors.black));
    _sections = [food, entertainment, transportation, personal, other];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
            flex: 4,
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraint) => Container(
                    height: height * 0.2,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(193, 214, 233, 1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: -10,
                            blurRadius: 17,
                            offset: Offset(-5, -5),
                            color: Colors.white,
                          ),
                          BoxShadow(
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(7, 7),
                            color: Color.fromRGBO(146, 182, 216, 1),
                          ),
                        ]),
                    child: PieChart(PieChartData(
                      sections: _sections,
                    )),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
