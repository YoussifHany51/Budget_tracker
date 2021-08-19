import 'package:budget_tracker/models/itemList.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  const ListItemWidget({
    Key? key,
    required this.item,
    required this.animation,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: buildItem(),
      );

  Widget buildItem() => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: item.col,
            )),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: item.col,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            item.price + ' LE ' + ' - ' + item.date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: IconButton(
              onPressed: onClicked,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
              )),
        ),
      );
}
