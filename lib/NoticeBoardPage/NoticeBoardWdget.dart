import 'package:flutter/material.dart';
import 'package:bd_class/models/notice_board.model.dart';
import 'package:bd_class/repository/notice_board.repository.dart';
import 'package:intl/intl.dart';

class NoticeBoardPage extends StatefulWidget {
  @override
  _NoticeBoardPageState createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  NoticeBoardRepository _noticeBoardRepository = NoticeBoardRepository();
  List<NoticeBoardModel> notices;
  bool isLoading;

  @override
  void initState() {
    this.getNotices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          this.getNotices();
        },
        child: this.isLoading == false ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Notice Board",
                  style: TextStyle(fontSize: 25, letterSpacing: 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              NoticeBoardWidget(notices: this.notices),
            ],
          ),
        ) : Center(child: CircularProgressIndicator()));
  }

  void getNotices() async {
    this.isLoading = true;
    await this._noticeBoardRepository.fetchAllNotices().then((results) {
      setState(() {
        this.notices = results;
        this.isLoading = false;
      });
    });
  }
}

class NoticeBoardWidget extends StatelessWidget {
  final List<NoticeBoardModel> notices;

  NoticeBoardWidget({this.notices});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, n) {
          NoticeBoardModel notice = notices[n];
          return Card(
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          notice.title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMEd().add_jm().format(
                              DateTime.parse(notice.added)
                                  .add(Duration(hours: 6))),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SelectableText(
                      notice.body,
                      style: TextStyle(color: Colors.grey[400]),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
