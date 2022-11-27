// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../components/CustomCard.dart';
import '../components/MyButton.dart';
import '../components/Paddings.dart';
import '../components/TxtField.dart';
import '../model/Student.dart';
import '../utils/dbHelper.dart';
import 'StudentInfo_Page.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final textApp = const Text("Student Registration Page");

  List<Student> lstStudent = <Student>[];
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtId = TextEditingController();

  DataBaseHelper dbhelper = DataBaseHelper();

  int selectedId = -1;

  @override
  void initState() {
    super.initState();

    setState(() {
      getStudent();
    });
  }

  getStudent() async {
    var result = await dbhelper.getAllStudents();
    setState(() {
      lstStudent = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: textApp,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: ProjectPadding.elementPadding,
            child: TxtField(
                txt: 'Enter Name', controller: txtName, obsecureText: false),
          ),
          Padding(
            padding: ProjectPadding.elementPadding,
            child: TxtField(
                txt: 'Enter Last Name',
                controller: txtLastName,
                obsecureText: false),
          ),
          Padding(
            padding: ProjectPadding.elementPadding,
            child: TxtField(
                txt: 'Enter Student ID',
                controller: txtId,
                obsecureText: false),
          ),
          Padding(
            padding: ProjectPadding.elementPadding,
            child: MyButton(
              onPressed: saveStudent,
              txt: 'Save',
              color: const Color.fromARGB(66, 38, 237, 45),
            ),
          ),
          lstStudent.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: lstStudent.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          subtitle:
                              const Text('Click for adding Letter Grades'),
                          text: Text(
                              "${lstStudent[index].name} ${lstStudent[index].lastname!}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentInfo_Page(
                                    studentId: lstStudent[index].id!),
                              ),
                            );
                          },
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      }),
                )
              : const Card(),
        ],
      ),
    );
  }

  saveStudent() {
    if (txtName.text.isNotEmpty &&
        txtLastName.text.isNotEmpty &&
        txtId.text.isNotEmpty) {
      Student student =
          Student(txtName.text.toString(), txtLastName.text.toString());
      save(student);
    }
  }

  Future<void> save(Student student) async {
    dbhelper.insertStudent(student);
    setState(() {
      getStudent();
    });
  }
}
