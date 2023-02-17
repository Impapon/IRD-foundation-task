import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ird_foundation_task/utils/app_utils.dart';
import '../models/event_model.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/home_bg_color.dart';
import '../widgets/ui_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  @override
  void initState() {
    scrollController = ScrollController();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    opacityController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeBackgroundColor(opacity),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 70, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildCustomAppBar(),
                UIHelper.verticalSpace(20),
                buildTickTickTask(),
                UIHelper.verticalSpace(16),
                buildReminderTask(),
                UIHelper.verticalSpace(16),
                buildAllTask(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomePageButtonNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget buildCustomAppBar() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi,Habib',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    "assets/hand.png",
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
              Text(
                "Let's explore your note",
                style: TextStyle(
                    color: Colors.grey[300], fontSize: 15, letterSpacing: 1),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.greenAccent),
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image: AssetImage(
                'assets/per.jpg',
              ) as ImageProvider),
              //<-- SEE HERE
            ),
          )
        ],
      ),
    );
  }

  Widget buildTickTickTask() {
    return Card(
      color: Color(0xff214E45),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey, //<-- SEE HERE
        ),
      ),
      elevation: 1,
      child: Stack(
        children: [
          Container(
            color: Color(0xff214E45),
            height: 160,
            width: double.maxFinite,
          ),
          Positioned(
            left: 27.4,
            top: 10.275,
            //bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to TickTick Task',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your one-stop app for task managemnent. Simplify,\ntrack, and accomplish tasks with ease',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff24966D),
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Watch Video     ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/todo.png",
              height: 93,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReminderTask() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reminder Task",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Text(
                "See All",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          UIHelper.verticalSpace(16),
          SizedBox(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 100,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                // disableCenter: true,
                viewportFraction: 0.3,
                // enlargeCenterPage: true,
              ),
              items: upcomingEvents.map((event) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              event.image,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              event.name,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              event.description,
                              style: TextStyle(fontSize: 9, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAllTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Tasks",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            Text(
              "See All",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height:400,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: allTask.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final event = allTask[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        event.image,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            event.description,
                            style: TextStyle(fontSize: 9, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
