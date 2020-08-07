import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/ClassRoomPageContents/ClassRoomPage.dart';
import 'package:bd_class/NoticeBoardPage/NoticeBoardWdget.dart';
import 'package:bd_class/PaymentPage/PaymentListPage.dart';
import 'package:bd_class/drawer.dart';
import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/services/drawer.services.dart';
import 'package:bd_class/teachersPage/teacherDetailPage.dart';
import 'package:bd_class/teachersPage/teachersPage.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';
import 'CoursePageContents/CoursePage.dart';
import 'HomePageContents/homePage.dart';

import 'authentication/login/loginPage.dart';

/*
**************************************************
background-image: linear-gradient(to bottom left,
rgb(40, 45, 92),
rgb(46, 52, 107),
rgb(53, 60, 122),
rgb(59, 67, 136),
rgb(65, 75, 151),
rgb(72, 82, 166),
rgb(78, 90, 181),
rgb(85, 97, 196),
rgb(91, 105, 211),
rgb(97, 112, 225),
rgb(104, 120, 240),
rgb(110, 127, 255));
**************************************************
*/

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff212022),
        backgroundColor: Color(0xff212022),
        cardTheme: CardTheme(
          color: Color(0xff181818),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "BD Class",
      home: FutureBuilder(
          future: this._loginService.jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.hasData) {
              String token = snapshot.data;
              bool isExpired = _loginService.isExpired(token);
              if (!isExpired) {
                return MainActivity();
              } else {
                return LoginPage(isSessionExpired: true,);
              }
            } else {
              return LoginPage(isSessionExpired: false,);
            }
          }),
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainActivity(),
        '/teacher': (context) => TeachersPage(),
        '/teacher-detail': (context) => TeacherDetailPage(),
        '/courses': (context) => CoursePageWidget(),
        '/payments': (context) => PaymentListPage(),
      },
    );
  }
}

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainActivityState();
  }
}

class _MainActivityState extends State<MainActivity> {
  DrawerService _drawerService = DrawerService();
  User _user;

  int _currentIndex = 0;
  PageController _pageController;

  void getUser() async {
    await _drawerService.getFullName().then((User value) {
      setState(() {
        this._user = value;
        print(this._user.toJson().toString());
      });
    });
  }

  @override
  void initState() {
    this.getUser();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foreground,
      appBar: appBarThemed("BD CLASS"),
      drawer: DrawerWidget(user: this._user),
      body: SafeArea(
        child: PageView(
          onPageChanged: this.onPageChanged,
          controller: this._pageController,
          children: <Widget>[
            HomePageWidget(),
            ClassRoomPage(),
            NoticeBoardPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 50,
        animationDuration: Duration(milliseconds: 250),
        backgroundColor: foreground,
        selectedIndex: this._currentIndex,
        showElevation: true,
        onItemSelected: this.onItemSelected,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
              title: Text('Sweet Home'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: Colors.red,
              textAlign: TextAlign.center,
              title: Text(
                'Class Rooms',
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.class_)),
          BottomNavyBarItem(
              activeColor: Colors.lightBlueAccent,
              textAlign: TextAlign.center,
              title: Text('All Notices'),
              icon: Icon(Icons.assignment)),
        ],
      ),
    );
  }

  void onItemSelected(int index) {
    setState(() {
      this._currentIndex = index;
      this._pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  void onPageChanged(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }
}
