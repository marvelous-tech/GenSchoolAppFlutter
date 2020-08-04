class StudentGroupModel {
  String groupName;
  String description;
  List<StudentModel> students;

  StudentGroupModel({this.groupName, this.description, this.students});

  StudentGroupModel.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
    description = json['description'];
    if (json['students'] != null) {
      students = new List<StudentModel>();
      json['students'].forEach((v) {
        students.add(new StudentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    data['description'] = this.description;
    if (this.students != null) {
      data['students'] = this.students.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentModel {
  int id;
  String studentUuid;
  String studentId;
  String studentRoll;
  String firstName;
  String lastName;
  String admitted;
  String birthDate;
  String gender;
  int institute;
  int studentAccount;
  int address;

  StudentModel(
      {this.id,
        this.studentUuid,
        this.studentId,
        this.studentRoll,
        this.firstName,
        this.lastName,
        this.admitted,
        this.birthDate,
        this.gender,
        this.institute,
        this.studentAccount,
        this.address});

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentUuid = json['student_uuid'];
    studentId = json['student_id'];
    studentRoll = json['student_roll'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    admitted = json['admitted'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    institute = json['institute'];
    studentAccount = json['student_account'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_uuid'] = this.studentUuid;
    data['student_id'] = this.studentId;
    data['student_roll'] = this.studentRoll;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['admitted'] = this.admitted;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['institute'] = this.institute;
    data['student_account'] = this.studentAccount;
    data['address'] = this.address;
    return data;
  }
}
