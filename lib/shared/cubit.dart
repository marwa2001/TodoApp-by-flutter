import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/shared/states.dart';

import '../archive_task/archive_task.dart';
import '../done_task/done_task.dart';
import '../new_tasks/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen = [
    NewTasksScreen(),
   DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  List<String> title = [
    "NewTaskes",
    "DoneTaskes",
    "ArchivedTaskes",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavigationBar());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase('todo.db'
        , version: 1,
        onCreate: (database, version) {
      //id intger
      // title String
      //date String
      //time String
      //status String

      print("database created");
      database
          .execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)")
          .then((value) {})
          .catchError((error) {
        print("Error when creating table${error.toString()}");
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);

      print("database opened");
    }).then((value) {
      database = value;
      emit(AppCreatDataBaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("${title}","${date}","${time}","new" )')
          .then((value) {
        print('$value inserted scucessfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });

      return null;
    });
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(AppGetDataBaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archiveTasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete(
      'DELETE FROM Tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppDeletDataBaseState());
    });
  }

  bool isBotttomSheet = false;
  IconData facIcon = Icons.edit;

  void changeBotomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBotttomSheet = isShow;
    facIcon = icon;
    emit(AppChangeBottomSheetState());
  }




}
