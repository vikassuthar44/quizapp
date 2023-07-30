import 'package:flutter/material.dart';
import 'package:quiz_app/database/ResultModel.dart';
import 'package:quiz_app/home/home_screen.dart';
import 'package:quiz_app/home/main_screen.dart';
import 'package:quiz_app/questionsandanswer/question_and_answer.dart';

import '../database/local_database.dart';
import '../utils/questions_data.dart';

@immutable
class ResultScreen extends StatefulWidget {
  final int score, correct, wrong;
  final String category;
  final List<Questions> questionsList;

  const ResultScreen(
      {required this.category,
      required this.score,
      required this.correct,
      required this.wrong,
      required this.questionsList,
      super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final LocalDatabase localDatabase = LocalDatabase();

  @override
  void initState() {
    super.initState();

    saveResult();
  }

  void saveResult() {
    DateTime dateTime = DateTime.now();
    String dateAndTime =
        "${dateTime.day}/${dateTime.month}/${dateTime.year} Time: ${dateTime.hour}:${dateTime.minute}";
    ResultModel resultModel = ResultModel(
        categoryName: widget.category,
        totalQuestion: widget.questionsList.length.toString(),
        dateAndTime: dateAndTime,
        score: widget.score.toString());
    localDatabase.insert(resultModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Image.asset("images/congratulate.png"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Your Score: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Colors.black.withOpacity(0.75)),
                ),
                Text(
                  "${widget.score}/${widget.questionsList.length * 5}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: Colors.blue.withOpacity(0.75)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "You have successfully completed quiz",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Text(
              widget.category,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.75)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Correct Questions: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    trailing: Text(
                      widget.correct.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blue.withOpacity(0.75)),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "Wrong Questions: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    trailing: Text(
                      widget.wrong.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.red.withOpacity(0.75)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Not Attempt Questions: ${(widget.questionsList.length - widget.correct - widget.wrong).toString()}",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QuestionAndAnswer(questionsList: widget.questionsList);
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Show Questions and Answer",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }), (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Back to Home",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
