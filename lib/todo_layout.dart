

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/calender_widget.dart';
import 'package:todo_list/shared/cubit.dart';
import 'package:todo_list/shared/states.dart';

import 'components.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.calendar_month_sharp,
                    color:  HexColor("#756AB6"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Calender()
                    )) ; },
                )
              ],
              title: Container(

                child:   GradientText(
                    cubit.title[cubit.currentIndex],
                  colors: [
                   HexColor("#756AB6"),
                     HexColor("#AC87C5"),
                     HexColor("#E0AED0"),
                    HexColor("#FFE5E5")
                  ],
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),


              ),

            ),

            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor:HexColor("#FFE5E5"),

              onPressed: () {
                if (cubit.isBotttomSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                                title: titleController.text,
                                time: timeController.text,
                                date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                         color:HexColor("#FFE5E5#"),

                                padding: EdgeInsets.all(20),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defualtFormField(
                                        controller: titleController,
                                        inputType: TextInputType.text,
                                        onTap: () {
                                          print('title tapped');
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return "title must not be empty";
                                          }
                                          return null;
                                        },
                                        labelText: 'task time',
                                        prefix: Icons.title,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      defualtFormField(
                                        controller: timeController,
                                        inputType: TextInputType.datetime,
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value.format(context));
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return "time must not be empty";
                                          }
                                          return null;
                                        },
                                        labelText: 'task time',
                                        prefix: Icons.watch_later_outlined,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      defualtFormField(
                                        controller: dateController,
                                        inputType: TextInputType.datetime,
                                        onTap: () {
                                          showDatePicker(

                                    context: context,
                            initialDate:DateTime.now(),
                            firstDate:DateTime.now(),
                             lastDate:DateTime(2025),
                                           ).then((value){
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return "date must not be empty";
                                          }
                                          return null;
                                        },
                                        labelText: 'task date',
                                        prefix: Icons.calendar_today,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 15)
                      .closed
                      .then((value) {
                    cubit.changeBotomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBotomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.facIcon),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.white,
              color: HexColor("#AC87C5"),
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [

                CurvedNavigationBarItem(
                  child: Icon(Icons.menu),
                  label: 'Taskes',
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),

              ],



            ),
          );
        },
      ),
    );
  }
}
//
// Future<String> getName() async {
//   return "osama hamed";
// }
