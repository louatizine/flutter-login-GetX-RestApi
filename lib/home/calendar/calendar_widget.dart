import 'package:flutter/material.dart';
import 'package:flutterapp/home/calendar/task_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_data_source.dart';
import 'event_provider.dart';

class CalendarWidget extends StatelessWidget{
  const CalendarWidget({super.key});

@override
Widget build(BuildContext context) {
  final events = Provider.of<EventProvider>(context,listen: true).events;

  return SfCalendar(
    view: CalendarView.day,
    //dataSource:EventDataSource(events),
    initialSelectedDate: DateTime.now(),
    cellBorderColor: Colors.transparent,
    // onLongPress: (details){
    //   final provider = Provider.of<EventProvider>(context,listen: true );
    //   provider.setDate(details.date!);
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) => const TaskWidget(),
    //   );
    // }

  );
}
}