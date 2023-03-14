import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_data_source.dart';
import 'event_provider.dart';
import 'package:flutterapp/home/calendar/event_viewing_page.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context, listen: true);
    final selectedEvents = provider.eventsOfSelectedDate;

    if(selectedEvents.isEmpty){
      return const Center(
        child : Text('No Event found', style: TextStyle(color: Colors.black, fontSize:24 ),
        ),
      );
    }
    return SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: const BoxDecoration(color: Colors.transparent),
        onTap: (details){
          if(details.appointments==null)return;
          final event = details.appointments!.first;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventViewingPage(event: event),
          ),
          );
        },
    );
  }

  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details,
      ){
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration:  BoxDecoration(color: Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(12)
    ),
      child:Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black,fontSize:16,fontWeight: FontWeight.bold ),
        ),
      ) ,
    );
  }
}
