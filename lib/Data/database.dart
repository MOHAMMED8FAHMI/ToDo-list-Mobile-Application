import 'package:hive/hive.dart';

class ToDoDatabase {
  // list to do list

  List toDolist = [];
  // refrence our box
  final _myBox = Hive.box('NewBox');

  // run this method if this is te 1st time ever opening this app
  void createInitialDate() {
    toDolist = [
      ["Flutter Course", false],
      ["Debug the code", false],
    ];
  }

  // load the data from database
  void loadData() {
    toDolist = _myBox.get("TODOLIST");
  }

// update teh database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDolist);
  }
}
