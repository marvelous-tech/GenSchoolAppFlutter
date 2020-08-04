class CourseModel {
  int id;
  String subjectName;
  String instructorName;
  String studentGroupName;
  String name;
  String created;
  String updated;
  int institute;
  int subject;
  int instructor;
  int studentGroup;

  CourseModel(
      {this.id,
      this.subjectName,
      this.instructorName,
      this.studentGroupName,
      this.name,
      this.created,
      this.updated,
      this.institute,
      this.subject,
      this.instructor,
      this.studentGroup});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    instructorName = json['instructor_name'];
    studentGroupName = json['student_group_name'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
    institute = json['institute'];
    subject = json['subject'];
    instructor = json['instructor'];
    studentGroup = json['student_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_name'] = this.subjectName;
    data['instructor_name'] = this.instructorName;
    data['student_group_name'] = this.studentGroupName;
    data['name'] = this.name;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['institute'] = this.institute;
    data['subject'] = this.subject;
    data['instructor'] = this.instructor;
    data['student_group'] = this.studentGroup;
    return data;
  }
}
