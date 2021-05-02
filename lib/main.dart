import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gaming_app/detail.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController(viewportFraction: 0.5);
  var currentPageValue = 0.0;
  int menuActive = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(Icons.search),
          ),
        ),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/2.jpg"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Orix",
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                    Text(
                      "Gaming",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 35),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailPage()));
                  },
                  child: Icon(
                    Icons.assistant_rounded,
                    size: 50,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 450,
            child: PageView.builder(
                controller: pageController,
                itemCount: 8,
                itemBuilder: (context, position) {
                  if (position == currentPageValue) {
                    return Transform.scale(
                      scale: 1,
                      child: GamePage(position),
                    );
                  } else if (position < currentPageValue) {
                    return Transform.scale(
                      scale: max(1 - (currentPageValue - position), 0.5),
                      child: GamePage(position),
                    );
                  } else {
                    return Transform.scale(
                      scale: max(1 - (position - currentPageValue), 0.5),
                      child: GamePage(position),
                    );
                  }
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(menuActive, (index) {
        setState(() {
          menuActive = index;
        });
      }),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final int activeIndex;
  final Function(int) menuCallback;

  BottomMenu(this.activeIndex, this.menuCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MenuItem(1, Icons.home, activeIndex == 1, menuCallback),
          MenuItem(2, Icons.videogame_asset_outlined, activeIndex == 2,
              menuCallback),
          MenuItem(3, Icons.favorite, activeIndex == 3, menuCallback),
          MenuItem(
              4, Icons.account_circle_outlined, activeIndex == 4, menuCallback),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;
  final IconData iconData;
  final bool active;
  final Function(int) menuCallback;

  MenuItem(this.index, this.iconData, this.active, this.menuCallback);

  @override
  Widget build(BuildContext context) {
    return active
        ? Container(
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          )
        : GestureDetector(
            onTap: () {
              menuCallback(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(iconData),
            ));
  }
}

class GamePage extends StatelessWidget {
  final int index;

  GamePage(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Image.asset(
              "assets/${index + 1}.jpg",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.3)),
                        child: Text(
                          "1.5k Playing",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orangeAccent),
                        child: Text(
                          "Live",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lego",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          Text(
                            "Spider-Kid",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
