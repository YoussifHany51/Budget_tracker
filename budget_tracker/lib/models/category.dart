import 'dart:ui';

class Category {
  String name = '';
  double value = 0;
  Color color;

  Category(this.name, this.value, this.color);

  String get getname => name;
  double get getvalue => value;
}
