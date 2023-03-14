import 'package:flutterapp/home/calendar/event.dart';
import 'package:flutter/cupertino.dart';

class EventEditingPage extends StatefulWidget {

  final Event? event ;
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {

  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.event==null){
      fromDate= DateTime.now();
      toDate = DateTime.now().add(const Duration(hours:2));
    }else{
      final event = widget.event!;
      titleController.text= event.title;
      fromDate= event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
