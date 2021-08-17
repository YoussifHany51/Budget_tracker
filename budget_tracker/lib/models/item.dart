class Item {
  int _id = 0;
  String _title = '';
  String _price = '';
  String _date = '';
  int _category = 0;

  Item(this._title, this._price, this._date, this._category);
  Item.withId(this._id, this._title, this._price, this._date, this._category);

  int get id => _id;
  String get title => _title;
  String get price => _price;
  String get date => _date;
  int get category => _category;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set price(String newPrice) {
    if (newPrice.length <= 255) {
      this._price = newPrice;
    }
  }

  set category(int newCategory) {
    if (newCategory >= 1 && newCategory <= 5) {
      this._category = newCategory;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['price'] = _price;
    map['date'] = _date;
    map['category'] = _category;
    // map.removeWhere((key, value) => value == null);
    return map;
  }

  // Item.fromMapObject(Map<String, dynamic> map) {
  //   this._id = map['id'];
  //   this._title = map['title'];
  //   this._price = map['price'];
  //   this._date = map['date'];
  //   this._category = map['category'];
  // }
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item.withId(
        map['id'], map['title'], map['price'], map['date'], map['category']);
  }
}
