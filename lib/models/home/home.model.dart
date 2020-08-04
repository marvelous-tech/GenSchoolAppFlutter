class HomeSchoolModel {
  String name;
  String type;
  int year;
  String eiinCode;

  HomeSchoolModel({
    this.name,
    this.year,
    this.type,
    this.eiinCode,
  });
}

class HomeTSModel {
  int teachersNumber;
  int studentsNumber;

  HomeTSModel({
    this.teachersNumber,
    this.studentsNumber,
  });
}

class HomePrincipalModel {
  String name;

  HomePrincipalModel({this.name});
}

class HomeContentModel {
  HomeSchoolModel homeSchoolModel;
  HomeTSModel homeTSModel;
  HomePrincipalModel homePrincipalModel;

  HomeContentModel({
    this.homePrincipalModel,
    this.homeTSModel,
    this.homeSchoolModel,
  });
}
