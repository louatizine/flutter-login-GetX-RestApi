import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/home/calendar/event_provider.dart';
import 'package:flutterapp/src/features/authentification/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'calendar/calendar_widget.dart';
import 'calendar/event_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);


  runApp(const Conge());
}


Widget build(BuildContext context) => ChangeNotifierProvider(
  create: (context)=> EventProvider(),
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark(),
    home: Conge(),
  ),
);

class Conge extends StatelessWidget {
  const Conge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
        centerTitle: true,
      ),
      body: const CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EventPage())),
        child: const Icon(Icons.add, color:Colors.white),
      ),
    );
  }
}

