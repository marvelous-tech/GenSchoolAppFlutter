class ClassRoomModel {
  int id;
  String instructorName;
  String courseName;
  int total;
  String instructorDesignation;
  String instructorSubject;
  String classRoomName;
  String classRoomUuid;
  String className;
  String sectionName;
  String description;
  String created;
  String updated;
  int institute;
  int course;
  int instructor;
  int studentGroup;

  ClassRoomModel(
      {this.id,
      this.instructorName,
      this.courseName,
      this.total,
      this.instructorDesignation,
      this.instructorSubject,
      this.classRoomName,
      this.classRoomUuid,
      this.className,
      this.sectionName,
      this.description,
      this.created,
      this.updated,
      this.institute,
      this.course,
      this.instructor,
      this.studentGroup});

  ClassRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorName = json['instructor_name'];
    courseName = json['course_name'];
    total = json['total'] == null ? 0 : json['total'];
    instructorDesignation = json['instructor_designation'];
    instructorSubject = json['instructor_subject'];
    classRoomName = json['class_room_name'];
    classRoomUuid = json['class_room_uuid'];
    className = json['class_name'];
    sectionName = json['section_name'];
    description = json['description'];
    created = json['created'];
    updated = json['updated'];
    institute = json['institute'];
    course = json['course'];
    instructor = json['instructor'];
    studentGroup = json['student_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_name'] = this.instructorName;
    data['course_name'] = this.courseName;
    data['total'] = this.total;
    data['instructor_designation'] = this.instructorDesignation;
    data['instructor_subject'] = this.instructorSubject;
    data['class_room_name'] = this.classRoomName;
    data['class_room_uuid'] = this.classRoomUuid;
    data['class_name'] = this.className;
    data['section_name'] = this.sectionName;
    data['description'] = this.description;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['institute'] = this.institute;
    data['course'] = this.course;
    data['instructor'] = this.instructor;
    data['student_group'] = this.studentGroup;
    return data;
  }
} // ClassRoomModel

class Class {
  int id;
  Attendance attendance;
  int classRoom;
  String classUuid;
  String lessonName;
  String taken;
  String classDescription;
  String classPlatform;
  String classLink;
  String created;
  String updated;
  bool isDeleted;
  int institute;

  Class(
      {this.id,
      this.attendance,
      this.classRoom,
      this.classUuid,
      this.lessonName,
      this.taken,
      this.classDescription,
      this.classPlatform,
      this.classLink,
      this.created,
      this.updated,
      this.isDeleted,
      this.institute});

  Class.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendance = json['attendance'] != null
        ? new Attendance.fromJson(json['attendance'])
        : Attendance(id: 0, total: 0);
    classRoom = json['class_room'];
    classUuid = json['class_uuid'];
    lessonName = json['lesson_name'];
    taken = json['taken'];
    classDescription = json['class_description'];
    classPlatform = json['class_platform'];
    classLink = json['class_link'];
    created = json['created'];
    updated = json['updated'];
    isDeleted = json['is_deleted'];
    institute = json['institute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attendance != null) {
      data['attendance'] = this.attendance.toJson();
    }
    data['class_room'] = this.classRoom;
    data['class_uuid'] = this.classUuid;
    data['lesson_name'] = this.lessonName;
    data['taken'] = this.taken;
    data['class_description'] = this.classDescription;
    data['class_platform'] = this.classPlatform;
    data['class_link'] = this.classLink;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['is_deleted'] = this.isDeleted;
    data['institute'] = this.institute;
    return data;
  }
}


class Attendance {
  int total;
  int id;

  Attendance({this.total, this.id});

  Attendance.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['id'] = this.id;
    return data;
  }
}

class ClassAddModel {
  String lessonName;
  String classLink;
  String classDescription;
  String taken;

  ClassAddModel({this.lessonName, this.classDescription, this.taken, this.classLink});

  ClassAddModel.fromJson(Map<String, dynamic> json) {
    lessonName = json['lesson_name'];
    classDescription = json['class_description'];
    classLink = json['class_link'];
    taken = json['taken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lesson_name'] = this.lessonName;
    data['class_description'] = this.classDescription;
    data['class_link'] = this.classLink;
    data['taken'] = this.taken;
    return data;
  }
}
