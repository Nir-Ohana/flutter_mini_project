import 'package:bgu_course_grader/models/appBar.dart';
import 'package:bgu_course_grader/models/favoritesList.dart';
import 'package:flutter/material.dart';
import 'menu_choice_list.dart';

import 'package:bgu_course_grader/screens/my_reviews.dart';
import 'package:bgu_course_grader/screens/courses_list.dart';
import 'package:bgu_course_grader/screens/contact_us.dart';
import 'package:bgu_course_grader/screens/advanced_search.dart';


class Menu extends StatelessWidget {


  void _navigator(int index, BuildContext context) {
    List<Function> targets = [
          () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CourseList(favorites: true, filtered: false, finalExam: false,))),
          () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => AdvancedSearch())),
          () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyReviews())),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CourseList(favorites: false, filtered: false, finalExam: false,))),
          () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ContactUs()))
    ];
    targets[index].call();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      appBar: MyAppBar(),
      body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[buildCardWithIcon(Icons.search_outlined,
            context,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AdvancedSearch();
                  },
                ),
              );
            },
            "חיפוש מתקדם",
          ),
            buildCardWithIcon(Icons.rate_review_sharp,
              context,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyReviews();
                    },
                  ),
                );
              },
              "הביקורות שלי",
            ),
            buildCardWithIcon(Icons.search_outlined,
              context,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CourseList(favorites: false, filtered: false, finalExam: false);
                    },
                  ),
                );
              },
              "רשימת קורסים",
            ),
            buildCardWithIcon(Icons.search_outlined,
              context,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FavoriteList();
                    },
                  ),
                );
              },
              "מועדפים",
            ),
            buildCardWithIcon(Icons.hearing_outlined,
              context,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ContactUs();
                    },
                  ),
                );
              },
              "צרו קשר",
            )
          ]
      ),
    ));
  }


  //     ListView.builder(
  //       itemCount: 5,
  //       itemBuilder: (context, index){
  //           return Padding(
  //               padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
  //             child: Card(
  //               color: Colors.orange[200],
  //               child: ListTile(
  //                 onTap: (){_navigator(index, context);},                              // routing to required menu option
  //                 title: Text(
  //                   choices[index]
  //                 ),
  //               ),
  //             ),
  //           );
  //       },
  //     ),
  //   )
//     // );
//   }
// }

  Padding buildCardWithIcon(IconData icon, context, VoidCallback onTap,
      String pageName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 8,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 70,
                  color: Color(0xFFEE7C21),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  pageName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFCB6B03),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
