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
        print(
            'max:${mainSC.position.maxScrollExtent} min:${mainSC.position.minScrollExtent}');
        print('height:${context.size?.height}');
        height = mainSC.position.maxScrollExtent - 40;
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
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            print(constraints.maxHeight);
            return Stack(
              children: [
                SingleChildScrollView(
                  controller: backGroundSC,
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: height + constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ListView.builder(
                  itemExtent: 100,
                  controller: mainSC,
                  padding: EdgeInsets.all(20),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    print('$index');
                    return Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.black12,
                      child: Text(
                        '$index',
                        style: TextStyle(fontSize: 36),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
