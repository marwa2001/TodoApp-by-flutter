import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components.dart';
import '../shared/cubit.dart';
import '../shared/states.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
    builder: (context,stste){
    var tasks = AppCubit.get(context).newTasks;
    return tasksBuilder(tasks: tasks );
    },
    );

  }
}