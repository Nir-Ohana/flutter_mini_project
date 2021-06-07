
import 'package:bgu_course_grader/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bgu_course_grader/screens/loading.dart';
import 'package:bgu_course_grader/models/courseTile.dart';

class CoursesList extends StatefulWidget {
  final bool filtered;
  final String dep;
  final String courseName;
  final String courseNum;
  final bool hasTest;
  final bool favorites;
  CoursesList({this.filtered, this.dep, this.courseName,
  this.courseNum, this.hasTest, this.favorites});


  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {


  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Stream returnAll(){
    return _firestore
        .collection('courses').snapshots();
  }

  Stream returnFiltered(){
    





    Query collection = _firestore
        .collection('courses');

    if (widget.dep != ''){
      collection = collection.where('department_name', isEqualTo: widget.dep);
    }
    if (widget.courseName != ''){
      collection = collection.where('course_name', isGreaterThanOrEqualTo: widget.courseName).where('course_name', isLessThan: widget.courseName + 'z' );
    }
    if(widget.courseNum != ''){
      collection = collection.where('course_number', isEqualTo: widget.courseNum);
    }
    if(!widget.hasTest){
      collection = collection.where('test_exists', isEqualTo: widget.hasTest);
    }

      return collection.snapshots();
  }

  Stream returnFavorites(){
    return _firestore
        .collection('Favorites').snapshots();
  }
  //
  // Future<bool> isInFavorites(String courseName) async {
  //   bool exists = await _firestore.collection('Favorites').doc(loggedInUser.email).get().then(
  //           (value) {
  //         final docData = (value.data()['liked'] as List<dynamic>);
  //         return docData.contains(courseName);
  //       });
  //   return exists;
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: widget.filtered ? returnFiltered() : widget.favorites ? returnFavorites() : returnAll(),
          builder: (context, snapshot) {
          List<CourseTile> coursesList = [];
          if (snapshot.hasData) {
            final courses = snapshot.data.docs;
            for (var course in courses) {
              final courseData = (course.data() as Map<String, dynamic>);
              final courseName = courseData['course_name'];
              final courseNum = courseData['course_number'];
              final courseCredit = courseData['credit_point'];
              final courseDepName = courseData['department_name'];
              final courseTest = courseData['test_exists'];
              final courseSummary = courseData['course_summary'];
              final Course courseToBuild = Course(name: courseName,
              courseNumber: courseNum, credits: courseCredit, depName: courseDepName,
              test: courseTest, courseSummary: courseSummary);
              final courseWidget = CourseTile(course: courseToBuild, favorite: false,);
              coursesList.add(courseWidget);
            }
          } else {
            return Loading();
          }
          return ListView(
              children: coursesList,
          );
        });
  }
}

















// class CoursesList extends StatefulWidget {
//   @override
//   _CoursesListState createState() => _CoursesListState();
// }
//
// class _CoursesListState extends State<CoursesList>{
//
//   @override
//   Widget build(BuildContext context) {
//
//     final courses = Provider.of<List<Course>>(context); // can also solve with ?? []
//     if (courses == null){
//       return Loading();
//     } else {
//       courses.forEach((element) {
//         print(element.name);
//         print(element.courseNumber);
//         print(element.openIn);
//       }
//       );
//     }
//     return ListView.builder(
//       itemCount: courses.length,
//       itemBuilder: (context, index){
//         return CourseTile(course: courses[index]);
//       },
//     );
//   }
// }
