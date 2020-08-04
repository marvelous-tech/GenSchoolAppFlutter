import 'package:flutter/material.dart';

class TSNumberPageView extends StatefulWidget {
  @override
  _TSNumberPageViewState createState() => _TSNumberPageViewState();
}

class _TSNumberPageViewState extends State<TSNumberPageView> {
  int _teachersNumber = 169;
  int _studentsNumber = 34720;
  final TextStyle _numberStyle = new TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.0
  );
  final _pageViewController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: PageView(
        controller: this._pageViewController,
        children: <Widget>[
          this.tsPages(
              context: context,
              name: 'Teachers',
              number: _teachersNumber,
          ),
          this.tsPages(
              context: context,
              name: 'Students',
              number: _studentsNumber,
          ),
        ],
      ),
    );
  }

  Widget tsPages({BuildContext context, String name, int number}) {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 15.0, 30.0),
          child: Column(
            children: [
              Text(
                number.toString().replaceAllMapped(
                    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'
                ),
                style: _numberStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    letterSpacing: 1.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
