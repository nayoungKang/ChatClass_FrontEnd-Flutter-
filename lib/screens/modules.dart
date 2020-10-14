import 'package:flutter/material.dart';

class DetailScreenArguments {
  final String questionId;

  DetailScreenArguments(this.questionId);
}

class ListItem {
  //DropDown List Item
  int index;
  String value;

  ListItem(this.index, this.value);
}

/*List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
  print(listItems);
  List<DropdownMenuItem<ListItem>> items = List();

  listItems.asMap().forEach((i, value) {
    print('index=$i, value=$value');
    items.add(
      DropdownMenuItem(
        child: Text(value),
        value: new ListItem(i, value),
      ),
    );
  });

  return items;
}*/
List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
  /*print(listItems);*/
  List<DropdownMenuItem<String>> items = List();

  listItems.asMap().forEach((i, value) {
    /*print('index=$i, value=$value');*/
    items.add(
      DropdownMenuItem(
        child: Text(value),
        value: value,
      ),
    );
  });

  return items;
}
