import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/functions/questions/question_functions.dart';
import 'package:cpd/widgets/app_bars/quiz_question_app_bar.dart';
import 'package:cpd/widgets/buttons/quiz/bottom_nav_buttons.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/quiz/finished_quiz_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../functions/firebase_functions.dart';
import 'home_screen.dart';

// Quiz page

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.documentId,
    required this.reference,
    required this.data,
  }) : super(key: key);

  final String documentId;
  final DocumentReference reference;
  final Map<String, dynamic> data;

  @override
  State<QuizScreen> createState() => _QuizScreenState();

  static _QuizScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_QuizScreenState>();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentPageIndex = 0;
  List<Widget> _pages = [];
  int _totalPoints = 0;
  bool _isLoading = true;

  // Used to update the question as a callback
  set currentPage(int currentPageIndex) => setState(
        () => _currentPageIndex = currentPageIndex,
      );

  // Used to update the points as a callback
  void points() {
    // Updates the Finished Quiz Page
    //  _pages.removeAt(_pages.length - 1);

    // Updates the total score
    //_totalPoints = totalPoints + _totalPoints;

    if (moduleName == "Module 1") {
      FirebaseFunctions().Module1.get().then((doc) {
        if (doc.data() != null) {
          _totalPoints = (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
        }
      });
    } else if (moduleName == "Module 2") {
      FirebaseFunctions().Module2.get().then((doc) {
        if (doc.data() != null) {
          _totalPoints = (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
        }
      });
    } else if (moduleName == "Module 3") {
      FirebaseFunctions().Module3.get().then((doc) {
        if (doc.data() != null) {
          _totalPoints = (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
        }
      });
    } else if (moduleName == "Module 4") {
      FirebaseFunctions().Module4.get().then((doc) {
        if (doc.data() != null) {
          _totalPoints = (doc.data() as Map<String, dynamic>)["correct"] ?? 99;
        }
      });
    }

    //  _pages.add(const FinishedQuizPage());

    //return _totalPoints;
  }

  // Gets the points
  int get currentPageIndex => _currentPageIndex;

  int get finalPoints => _totalPoints;

  // Gets the module name
  String get moduleName => widget.data["name"];

  // Gets the quiz questions
  Future<void> _prepareQuiz() async {
    if (moduleName == "Module 1") {
      FirebaseFunctions().Module1.get().then((doc) {
        _currentPageIndex =
            (doc.data() as Map<String, dynamic>)["progress"] ?? 0;
      });
    }
    if (moduleName == "Module 2") {
      FirebaseFunctions().Module2.get().then((doc) {
        _currentPageIndex =
            (doc.data() as Map<String, dynamic>)["progress"] ?? 0;
      });
    }
    if (moduleName == "Module 3") {
      FirebaseFunctions().Module3.get().then((doc) {
        _currentPageIndex =
            (doc.data() as Map<String, dynamic>)["progress"] ?? 0;
      });
    }
    if (moduleName == "Module 4") {
      FirebaseFunctions().Module4.get().then((doc) {
        _currentPageIndex =
            (doc.data() as Map<String, dynamic>)["progress"] ?? 0;
      });
    }

    await FirebaseFirestore.instance
        .collection("modules")
        .doc(widget.documentId)
        .collection("questions")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Gets the appropriate question layout based on the type
        _pages.add(
          QuestionFunctions().getQuestionType(
            type: data["type"],
            moduleId: widget.documentId,
            questionNumber: doc.id,
            data: data,
          ),
        );
      }
    }).then(
      (value) => setState(() {
        // TODO: Needs a pass check - restart the quiz if they have failed and show this on the last screen
        // Adds the finished page
        _pages.add(const FinishedQuizPage());
        _isLoading = false;
      }),
    );
  }

  reset() {
    bool complete = false;

    String name1 = moduleName;
    if (name1 == "Module 1") {
      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFunctions().Module1.get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc("Module1")
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
          }
          FirebaseFunctions().Module1.update({
            "progress": 0,
            "completed": complete,
            "correct": 0,
            "totalScore": totalScore
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });
    }

    if (name1 == "Module 2") {
      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFunctions().Module2.get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc("Module2")
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
          }
          FirebaseFunctions().Module2.update({
            "progress": 0,
            "completed": complete,
            "correct": 0,
            "totalScore": totalScore
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });
    }

    if (name1 == "Module 3") {
      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFunctions().Module3.get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc("Module3")
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
          }
          FirebaseFunctions().Module3.update({
            "progress": 0,
            "completed": complete,
            "correct": 0,
            "totalScore": totalScore
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });
    }

    if (name1 == "Module 4") {
      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFunctions().Module4.get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc("Module4")
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
          }
          FirebaseFunctions().Module4.update({
            "progress": 0,
            "completed": complete,
            "correct": 0,
            "totalScore": totalScore
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });
    }

    if (name1 == "Survey") {
      int correct = 0;
      int total = 0;
      double totalScore = 0;
      FirebaseFunctions().Module4.get().then((doc) {
        correct = (doc.data() as Map<String, dynamic>)["correct"] ?? 0;
        FirebaseFirestore.instance
            .collection("modules")
            .doc("Module4")
            .get()
            .then((doc) {
          total = (doc.data() as Map<String, dynamic>)["total"] ?? 0;
          totalScore = ((correct/total) *100) as double;
          if (totalScore >= 80) {
            complete = true;
          }
          FirebaseFunctions().Module4.update({
            "progress": 0,
            "completed": complete,
            "correct": 0,
            "totalScore": totalScore
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        });
      });
    }
  }

  @override
  void initState() {
    _prepareQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : QuizQuestionAppBar(
                        currentQuestionIndex: _currentPageIndex,
                        totalQuestions: _pages.length - 1,
                      ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContentArea(
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : IndexedStack(
                                  index: _currentPageIndex,
                                  children: _pages,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 32,
                        right: 32,
                        child: Center(
                          child: BottomNavButtons(
                            // Current page is first page if current page index is 0
                            isFirstPage: _currentPageIndex == 0,
                            // Current page is last page if current page number is the same as the number of pages
                            isLastPage:
                                (_currentPageIndex + 1) == _pages.length,
                            currentPageIndex: _currentPageIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
