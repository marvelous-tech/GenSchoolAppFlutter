class HomeContentApiModel {
  Institute institute;
  TsNumber tsNumber;
  Principal principal;

  HomeContentApiModel({this.institute, this.tsNumber, this.principal});

  HomeContentApiModel.fromJson(Map<String, dynamic> json) {
    institute = json['institute'] != null
        ? new Institute.fromJson(json['institute'])
        : null;
    tsNumber = json['tsNumber'] != null
        ? new TsNumber.fromJson(json['tsNumber'])
        : null;
    principal = json['principal'] != null
        ? new Principal.fromJson(json['principal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.institute != null) {
      data['institute'] = this.institute.toJson();
    }
    if (this.tsNumber != null) {
      data['tsNumber'] = this.tsNumber.toJson();
    }
    if (this.principal != null) {
      data['principal'] = this.principal.toJson();
    }
    return data;
  }
}

class Institute {
  String name;
  String type;
  int year;
  String eiinCode;

  Institute({this.name, this.type, this.year, this.eiinCode});

  Institute.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    year = json['year'];
    eiinCode = json['eiinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['year'] = this.year;
    data['eiinCode'] = this.eiinCode;
    return data;
  }
}

class TsNumber {
  int teachersNumber;
  int studentsNumber;

  TsNumber({this.teachersNumber, this.studentsNumber});

  TsNumber.fromJson(Map<String, dynamic> json) {
    teachersNumber = json['teachersNumber'];
    studentsNumber = json['studentsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teachersNumber'] = this.teachersNumber;
    data['studentsNumber'] = this.studentsNumber;
    return data;
  }
}

class Principal {
  String name;

  Principal({this.name});

  Principal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
