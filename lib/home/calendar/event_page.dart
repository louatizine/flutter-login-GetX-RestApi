import 'package:flutter/material.dart';
import 'package:flutterapp/home/calendar/util.dart';
import 'package:flutterapp/home/calendar/event.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';

class EventPage extends StatefulWidget {

  final Event? event;

  const EventPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.event==null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours:2));
    }
  }
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)=>Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formkey,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              const SizedBox(height: 12,),
              buildDataTimePicker(),
            ],
        ),
      ),
    ),

    );

    List<Widget>buildEditingActions() =>
        [ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
        onPressed: saveForm,
        icon: const Icon(Icons.done),
        label: const Text('save'),
    )
    ];



    Widget buildTitle()=> TextFormField(
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'ADD TITTLE',
      ),
      onFieldSubmitted: (_)=>saveForm(),
      validator:(title)=>
        title !=null && title.isEmpty ? 'Title Cannot be Empty':null,
      controller: titleController,
    );

    Widget  buildDataTimePicker()=> Column(
      children: [
        buildForm(),
        buildTo(),
      ],
    );


    Widget buildForm()=> buildHeader(
      header: 'From',
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: buildDropDownField(
                text: Utils.toDate(fromDate),
                onClicked:() =>pickFromDateTime(pickDate:true),
              ),
          ),
          Expanded(
            child: buildDropDownField(
              text: Utils.toTime(fromDate),
              onClicked:() =>pickFromDateTime(pickDate:true),
            ),
          ),
        ],
      ),
    );

  Widget buildTo()=> buildHeader(
    header: 'To',
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: buildDropDownField(
            text: Utils.toDate(toDate),
            onClicked:() =>pickToDateTime(pickDate:true),
          ),
        ),
        Expanded(
          child: buildDropDownField(
            text: Utils.toTime(toDate),
            onClicked:() =>pickToDateTime(pickDate:false),
          ),
        ),
      ],
    ),
  );


  /// time
  Future pickFromDateTime({required bool pickDate}) async{
    final date = await pickDateTime(fromDate, pickDate:pickDate);
    if(date==null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year,date.month,date.day,toDate.hour,toDate.minute
      );
    }

    setState(() => fromDate= date);
  }

  Future pickToDateTime({required bool pickDate}) async{
    final date = await pickDateTime(
        toDate,
        pickDate: pickDate,
        firstDate: pickDate? fromDate:null,

    );
    if(date==null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year,date.month,date.day,toDate.hour,toDate.minute
      );
    }

    setState(() => toDate= date);
  }

////
  Future<DateTime?>pickDateTime(
     DateTime initialDate,{
     required bool pickDate,
       DateTime? firstDate,
  }) async{
    if(pickDate){
      final date = await showDatePicker
        (context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2021)
        );
      if(date ==null) return null;

      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    }else{
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if(timeOfDay== null) return null;

      final date =
          DateTime(initialDate.year,initialDate.month,initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
 }

///end of time
    Widget  buildDropDownField({
          required String text,
          required VoidCallback onClicked,
        }) => ListTile
        (
             title: Text(text),
             trailing : const Icon(Icons.arrow_drop_down_circle),
             onTap: onClicked,
        );

  Widget  buildHeader({
    required String header,
    required Widget child,
}) => Column(
    crossAxisAlignment:  CrossAxisAlignment.start,
    children: [
      Text(header, style: const TextStyle(fontWeight: FontWeight.bold),)
    ],
  );




Future saveForm()async{
  final isValid = _formkey.currentState!.validate();

  if(isValid){
    final event= Event(
      title:titleController.text,
      from: fromDate,
      to: toDate,
      isAllDay:false,
      description: 'Description',
      backgroundColor: Colors.grey,
    );
    final isEditing = widget.event !=null;
    final provider = Provider.of<EventProvider>(context, listen: true);

    if(isEditing){
      provider.editEvent(event, widget.event!);
      Navigator.of(context).pop();

    }
    else{
      provider.addEvent(event);
    }
    Navigator.of(context).pop();
  }
}


}
