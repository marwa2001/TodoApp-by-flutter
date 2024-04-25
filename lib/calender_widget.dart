import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Calender extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  SfCalendar(
       view: CalendarView. timelineWorkWeek,
        backgroundColor: Colors.white,


    );
  }
}
