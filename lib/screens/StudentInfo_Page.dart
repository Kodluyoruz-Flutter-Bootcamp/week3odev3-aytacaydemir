// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../components/CustomCard.dart';
import '../components/MyButton.dart';
import '../components/Paddings.dart';
import '../components/TxtField.dart';
import '../model/Grades.dart';
import '../utils/dbHelper.dart';

// ignore: camel_case_types
class StudentInfo_Page extends StatefulWidget {
  const StudentInfo_Page({super.key, required this.studentId});

  final int studentId;
  @override
  State<StudentInfo_Page> createState() => _StudentInfo_PageState();
}

// ignore: camel_case_types
class _StudentInfo_PageState extends State<StudentInfo_Page> {
  var text = const Text("Add/Update Student Info");
  DataBaseHelper dbHelper = DataBaseHelper();

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  List<Grades> lstGrades = <Grades>[];

  int selectedId = -1;

  @override
  void initState() {
    super.initState();
    setState(() {
      getGrades();
    });
  }

  void getGrades() async {
    List<Grades> gradeFuture = await dbHelper.getAllGrades();
    setState(() {
      lstGrades = gradeFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: ProjectPadding.elementPadding,
            child: TxtField(
                txt: 'Enter Lecture Name',
                controller: txtTitle,
                obsecureText: false),
          ),
          Padding(
            padding: ProjectPadding.elementPadding,
            child: TxtField(
                txt: 'Enter Letter Grade',
                controller: txtDescription,
                obsecureText: false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: ProjectPadding.elementPadding,
                child: MyButton(
                  onPressed: saveGrade,
                  txt: 'Save',
                  color: const Color.fromARGB(188, 22, 217, 87),
                ),
              ),
              Padding(
                padding: ProjectPadding.elementPadding,
                child: MyButton(
                  onPressed: updateGrade,
                  txt: 'Update',
                  color: const Color.fromARGB(189, 217, 214, 22),
                ),
              ),
            ],
          ),
          lstGrades.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: lstGrades.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        subtitle: Text(lstGrades[index].letterGrade.toString()),
                        text: Text(lstGrades[index].lectureName!),
                        onTap: () {
                          setState(
                            () {
                              txtTitle.text =
                                  lstGrades[index].lectureName.toString();
                              txtDescription.text =
                                  lstGrades[index].letterGrade.toString();
                              selectedId = lstGrades[index].id!;
                            },
                          );
                        },
                        trailing: const Icon(Icons.update),
                      );
                    },
                  ),
                )
              : const Card(),
        ],
      ),
    );
  }

  saveGrade() {
    if (txtTitle.text.isNotEmpty && txtDescription.text.isNotEmpty) {
      Grades grade = Grades(txtTitle.text.toString(),
          txtDescription.text.toString(), widget.studentId);
      dataSave(grade);
    }
  }

  dataSave(Grades grade) async {
    await dbHelper.insert(grade);
    setState(() {
      getGrades();
      txtTitle.text = "";
      txtDescription.text = "";
    });
  }

  updateGrade() {
    if (selectedId > 0) {
      update(Grades.withId(selectedId, txtTitle.text.toString(),
          txtDescription.text.toString(), widget.studentId));
    }
  }

  Future<void> update(Grades grade) async {
    await dbHelper.update(grade);
    setState(() {
      getGrades();
      txtDescription.text = "";
      txtTitle.text = "";
      selectedId = -1;
    });
  }
}
