import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/home/calendar/event.dart';
import 'package:flutterapp/home/calendar/event_provider.dart';
import 'package:provider/provider.dart';

import 'eventEditing.dart';

class EventViewingPage extends StatelessWidget {

final Event event ;


  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:  AppBar(
      leading: const CloseButton(),
      actions: buildViewingActions(context, event),
    ),
    body: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
        buildDateime(event),
        const SizedBox(height: 32),
        Text(event.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    ],
  ),
  );

  buildViewingActions(BuildContext context, Event event) {
    IconButton(
      icon:Icon(Icons.edit) ,
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> EventEditingPage(event : event ),),
      ),
    );
    IconButton(
        icon:Icon(Icons.delete) ,
    onPressed: (){
          final provider = Provider.of<EventProvider>(context,listen: true);

        }
    );
  }

  buildDateime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'all-day' : 'From', event.from),
        if(!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  buildDate(String s, DateTime from) {

  }
}
