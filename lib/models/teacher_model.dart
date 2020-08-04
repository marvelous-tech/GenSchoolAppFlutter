class TeacherModel {
  int id;
  String subject;
  String instructorAccount;
  String address;
  String institute;
  String department;
  String email;
  String firstName;
  String lastName;
  String gender;
  String facebook;
  String tweeter;
  String instagram;
  String designation;
  String description;

  TeacherModel(
      {this.id,
      this.subject,
      this.instructorAccount,
      this.address,
      this.institute,
      this.department,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.facebook,
      this.tweeter,
      this.instagram,
      this.designation,
      this.description});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    instructorAccount = json['instructor_account'];
    address = json['address'];
    institute = json['institute'];
    department = json['department'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    facebook = json['facebook'];
    tweeter = json['tweeter'];
    instagram = json['instagram'];
    designation = json['designation'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['instructor_account'] = this.instructorAccount;
    data['address'] = this.address;
    data['institute'] = this.institute;
    data['department'] = this.department;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['facebook'] = this.facebook;
    data['tweeter'] = this.tweeter;
    data['instagram'] = this.instagram;
    data['designation'] = this.designation;
    data['description'] = this.description;
    return data;
  }
}
