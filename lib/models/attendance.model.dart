class AttendanceAddModel {
  String issueDate;
  List<int> studentsAdd;

  AttendanceAddModel({this.issueDate, this.studentsAdd});

  AttendanceAddModel.fromJson(Map<String, dynamic> json) {
    issueDate = json['issue_date'];
    studentsAdd = json['students_add'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['issue_date'] = this.issueDate;
    data['students_add'] = this.studentsAdd;
    return data;
  }
}

class AttendanceModel {
  String name;
  String roll;
  String sId;
  bool was;

  AttendanceModel({this.name, this.roll, this.sId, this.was});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roll = json['roll'];
    sId = json['s_id'];
    was = json['was'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['roll'] = this.roll;
    data['s_id'] = this.sId;
    data['was'] = this.was;
    return data;
  }
}
