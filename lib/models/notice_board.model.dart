class NoticeBoardModel {
  int id;
  String title;
  String body;
  String added;
  String updated;
  int institute;

  NoticeBoardModel(
      {this.id,
      this.title,
      this.body,
      this.added,
      this.updated,
      this.institute});

  NoticeBoardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    added = json['added'];
    updated = json['updated'];
    institute = json['institute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['added'] = this.added;
    data['updated'] = this.updated;
    data['institute'] = this.institute;
    return data;
  }
}
