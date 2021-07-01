import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController mainSC;
  late ScrollController backGroundSC;

  double height = 0;

  @override
  void initState() {
    super.initState();
    mainSC = ScrollController();
    backGroundSC = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        print('extentInside: ${mainSC.position.extentInside}');
        print('extentAfter: ${mainSC.position.extentAfter}');

        height =
            mainSC.position.extentInside + mainSC.position.extentAfter - 40;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          backGroundSC.jumpTo(mainSC.offset);
          return false;
        },
        child: Stack(
          // fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: backGroundSC,
              padding: EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(40),
              physics: ClampingScrollPhysics(),
              controller: mainSC,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 40,
              itemBuilder: (context, index) {
                print('$index');

                return Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.black12,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$index',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                );
              },
            )
            /* ListView.builder(
              itemExtent: 100,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              controller: mainSC,
              padding: EdgeInsets.all(20),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.black12,
                  child: Text(
                    '$index',
                    style: TextStyle(fontSize: 36),
                  ),
                );
              },
            ), */
          ],
        ),
      ),
    );
  }
}
