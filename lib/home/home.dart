import'package:flutter/material.dart';
import 'package:flutterapp/add_conge/screens/home.dart';
import 'package:flutterapp/home/profile.dart';
import 'package:flutterapp/home/validation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'conge.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight = 0;
  double screenWidth = 0;
  int currentIndex= 0;

  Color primary = const Color(0xFF26A69A);
  List<IconData> navigationIcons=[
    Icons.calendar_month_rounded,
    Icons.check_circle_outline,
    Icons.supervised_user_circle_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeConge(),
          Validation(),
          Profile(),

        ],
      ),
        bottomNavigationBar: Container(
          height: 70,
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 24,
            ),
            decoration:const BoxDecoration(
                  color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2)
                )
              ]
            ),
           child: ClipRRect(
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                for(int i=0;i<navigationIcons.length;i++)...<Expanded>{
                  Expanded(child:
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(navigationIcons[i],
                              color: i == currentIndex ? primary: Colors.black26,
                              size:  i == currentIndex ?30: 26,
                            ),
                            i == currentIndex ? Container(
                              margin: const EdgeInsets.only(top:6),
                              height: 3,
                              width: 22,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                color: primary,
                              ),
                            ): const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  )
                  )
                }
               ],
             ),
           ),
        )

    );

  }
}
