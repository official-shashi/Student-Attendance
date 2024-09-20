import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addStudent(Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .set(studentInfoMap);
  }

  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return await FirebaseFirestore.instance.collection("Student").snapshots();
  }

  updateAttendence(String attendanceCase, String id) async {
    if (attendanceCase == "Present") {
      await FirebaseFirestore.instance.collection("Student").doc(id).update({
        "Present": true,
        "Absent": false,
      });
    } else if (attendanceCase == "Absent") {
      await FirebaseFirestore.instance.collection("Student").doc(id).update({
        "Present": false,
        "Absent": true,
      });
    }
  }

  deleteStudentData(String id) async {
    return await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .delete();
  }
}
