import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

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
  late LinkedScrollControllerGroup _controllers;
  late ScrollController mainSC;
  late ScrollController backGroundSC;

  double height = 0;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();

    mainSC = _controllers.addAndGet();
    backGroundSC = _controllers.addAndGet();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        print('extentInside: ${mainSC.position.extentInside}');
        print('extentAfter: ${mainSC.position.extentAfter}');

        height =
            mainSC.position.extentInside + mainSC.position.extentAfter - 330;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: backGroundSC,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(15),
              child: Container(
                margin: EdgeInsets.only(top: 300),
                height: height,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            CustomScrollView(
              physics: ClampingScrollPhysics(),
              controller: mainSC,
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(15),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      color: Colors.blue[200]?.withOpacity(0.85),
                      height: 300,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                    left: 30,
                    right: 30,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                      childCount: 100,
                    ),
                  ),
                )
              ],
            )
            /*  GridView.builder(
              padding: EdgeInsets.all(40),
              shrinkWrap: true,
              controller: mainSC,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 20,
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
            ) */
          ],
        ),
      ),
    );
  }
}
