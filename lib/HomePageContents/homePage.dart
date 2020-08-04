import 'package:flutter/material.dart';
import 'package:bd_class/HomePageContents/TSNumberWidget.dart';
import 'package:bd_class/HomePageContents/instituteWidget.dart';
import 'package:bd_class/HomePageContents/principalWidget.dart';
import 'package:bd_class/models/home/home.model.dart';
import 'package:bd_class/services/home/home.services.dart';
import 'package:http/http.dart' as http;

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  Future<HomeContentModel> _futureHomeContentModel;
  HomeService _homeService = HomeService();
  Future<http.Response> response;

  @override
  void initState() {
    this._futureHomeContentModel = this._homeService.getHomePageContents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeContentModel>(
        future: this._futureHomeContentModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return this.view(snapshot.data);
          } else if (snapshot.hasError) {
            return SnackBar(
              content: Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget view(HomeContentModel homeContentModel) {
    return Container(
      child: ListView(
        children: [
          InstituteWidget(
            schoolName: homeContentModel.homeSchoolModel.name,
            type: homeContentModel.homeSchoolModel.type,
            year: homeContentModel.homeSchoolModel.year,
            eiinCode: homeContentModel.homeSchoolModel.eiinCode,
          ),
          TSNumberWidget(
            teachersNumber: homeContentModel.homeTSModel.teachersNumber,
            studentsNumber: homeContentModel.homeTSModel.studentsNumber,
          ),
          // TSNumberPageView(),
          PrincipalWidget(
            name: homeContentModel.homePrincipalModel.name,
          ),
        ],
      ),
    );
  }
}
