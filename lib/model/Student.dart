// ignore_for_file: file_names

class Student {
  int? id;
  String? name;
  String? lastname;

  Student(this.name, this.lastname);

  Student.withId(this.id, this.name, this.lastname);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map["id"] = id;
    map["name"] = name;
    map["lastname"] = lastname;

    return map;
  }

  Student.getMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    lastname = map["lastname"];
  }
}
