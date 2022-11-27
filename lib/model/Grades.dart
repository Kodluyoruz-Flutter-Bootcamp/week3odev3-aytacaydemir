class Grades {
  int? id;
  String? lectureName;
  String? letterGrade;
  int? studentId;

  Grades(this.lectureName, this.letterGrade, this.studentId);

  Grades.withId(this.id, this.lectureName, this.letterGrade, this.studentId);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["lectureName"] = lectureName;
    map["letterGrade"] = letterGrade;
    map["studentId"] = studentId;

    return map;
  }

  Grades.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    lectureName = map["lectureName"];
    letterGrade = map["letterGrade"];
    studentId = map["studentId"];
  }
}
