import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components.dart';
import '../shared/cubit.dart';
import '../shared/states.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({super.key});

  @override

    Widget build(BuildContext context) {
      return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,stste){
          var tasks = AppCubit.get(context).archiveTasks;
          return tasksBuilder(tasks: tasks);
        },
      );

    }
  }