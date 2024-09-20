import 'package:attendence/service/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController rollnocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const SizedBox(
                  width: 60,
                ),
                const Text(
                  "Add ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Student",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Student Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Student Name"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Student Age",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: agecontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter Student Age"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Student Roll No",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: rollnocontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Student Roll No"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                if (namecontroller.text.isNotEmpty &&
                    agecontroller.text.isNotEmpty &&
                    rollnocontroller.text.isNotEmpty) {
                  String addId = randomAlphaNumeric(10);
                  Map<String, dynamic> studentInfoMap = {
                    "Name": namecontroller.text,
                    "Age": agecontroller.text,
                    "RollNo": rollnocontroller.text,
                    "Absent": false,
                    "Present": false
                  };
                  try {
                    await DatabaseMethods().addStudent(studentInfoMap, addId);

                    namecontroller.clear();
                    agecontroller.clear();
                    rollnocontroller.clear();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Student data has been uploaded!!!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ));
                  } catch (e) {
                    debugPrint("Error uploading student data: $e");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Failed to upload student data: $e",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "All fields are required!",
                      style: TextStyle(fontSize: 16),
                    ),
                  ));
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
