import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/result/result_screen.dart';

import '../utils/questions_data.dart';

class QuestionsScreen extends StatefulWidget {
  late String categoryName;
  late String docId;

  QuestionsScreen({required this.categoryName, required this.docId, super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late List<Questions> questionsLists =
      []; // = QuestionsList.generalKnowledgeQuestions();
  int currentQuestionIndex = 0;
  int correctAnswer = 0, wrongAnswer = 0;

  bool isOptionSelect = false;
  int selectAnswerOption = 0;
  Color optionSelectColor = Colors.white;
  double progressMaxWidth =  0;
  double progressWidth = 0;

  @override
  void initState() {
    super.initState();

    getQuestions(widget.docId);
    startTimer();
  }

  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        progressWidth = progressMaxWidth - (_start/10)*progressMaxWidth;
      });
        if (_start == 0) {
          setState(() {
            _start = 10;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void getQuestions(String docId) async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    //DocumentSnapshot<Map<String, dynamic>> snapshot = await firebase.collection("listofquestions").doc(docId).get();

    List<String> list = docId.split("/").toList();
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firebase.collection(list[0]).doc(list[1]).get();

    snapshot.exists
        ? FirebaseQuestionsList.fromDocumentSnapshot(snapshot.data()!)
        : null;
    List<dynamic> questionsList = snapshot.data()!['questionslist'];
    print("list" + questionsList.isEmpty.toString());
    Questions singleQuestions;
    for (var i = 0; i < questionsList.length; i++) {
      Map<String, dynamic> data = questionsList[i];
      String questions = data['question'];
      String option1 = data['option1'];
      String option2 = data['option2'];
      String option3 = data['option3'];
      String option4 = data['option4'];
      String correctOption = data['correct'];
      String questiojsLevel = data['type'];
      singleQuestions = Questions(
          questions: questions,
          option1: option1,
          option2: option2,
          option3: option3,
          option4: option4,
          correctOption: correctOption,
          questiojsLevel: questiojsLevel);
      setState(() {
        questionsLists.add(singleQuestions);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      progressMaxWidth = MediaQuery.sizeOf(context).width;
    });
    return Scaffold(
      appBar: AppBar(
        //"$currentQuestionIndex/${questionsLists.length}
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "  ${currentQuestionIndex+1}/${questionsLists.length}",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.75)),
            ),
          ],
        ),/*IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios))*/
        title: Text(
          widget.categoryName,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75)),
        ),
        /* actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Time: ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.8)),
              ),
              Text(
                _start.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.8)),
              ),
              const SizedBox(width: 20)
            ],
          )
        ],*/
        backgroundColor: Colors.blue.shade200,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blue.shade200,
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            questionsLists.length != 0
                ? Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Stack(
                              children: [
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade200
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  height: 20,
                                  width: progressWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue.shade200
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Q:${currentQuestionIndex + 1} ",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Text(
                                    questionsLists[currentQuestionIndex]
                                        .questions,
                                    softWrap: true,
                                    maxLines: 10,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              answerOption(1,
                                  1 == selectAnswerOption,
                                  questionsLists[currentQuestionIndex]
                                      .option1),
                              answerOption(2,
                                  2 == selectAnswerOption,
                                  questionsLists[currentQuestionIndex]
                                      .option2),
                              answerOption(3,
                                  3 == selectAnswerOption,
                                  questionsLists[currentQuestionIndex]
                                      .option3),
                              answerOption(4,
                                  4 == selectAnswerOption,
                                  questionsLists[currentQuestionIndex]
                                      .option4)
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (currentQuestionIndex > 0) {
                                      currentQuestionIndex--;
                                    }
                                    if(questionsLists[currentQuestionIndex].yourAnswer.isNotEmpty) {
                                      if(questionsLists[currentQuestionIndex].isCorrect) {
                                        correctAnswer--;
                                      } else {
                                        wrongAnswer--;
                                      }
                                    } else {

                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.75),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (currentQuestionIndex + 1 == questionsLists.length) {
                                      if (questionsLists[currentQuestionIndex].yourAnswer == questionsLists[currentQuestionIndex].correctOption) {
                                        correctAnswer++;
                                        questionsLists[currentQuestionIndex].isCorrect = true;
                                      } else {
                                        if (questionsLists[currentQuestionIndex].yourAnswer.isNotEmpty) {
                                          wrongAnswer++;
                                        }
                                        questionsLists[currentQuestionIndex].isCorrect = false;
                                      }
                                      //_timer.cancel();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              backgroundColor:
                                                  Colors.blue.shade100,
                                              title: const Text(
                                                  'Are you sure want to finish Quiz?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      startTimer();
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    selectAnswerOption = 0;
                                                    Navigator.pop(context);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ResultScreen(
                                                        category:
                                                            widget.categoryName,
                                                        correct: correctAnswer,
                                                        wrong: wrongAnswer,
                                                        score:
                                                            correctAnswer * 5,
                                                        questionsList:
                                                            questionsLists,
                                                      );
                                                    }));
                                                  },
                                                  child: const Text('Submit',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      selectAnswerOption = 0;
                                      if (questionsLists[currentQuestionIndex].yourAnswer ==
                                          questionsLists[currentQuestionIndex].correctOption) {
                                        correctAnswer++;
                                        questionsLists[currentQuestionIndex].isCorrect = true;
                                      } else {
                                        if (questionsLists[currentQuestionIndex].yourAnswer.isNotEmpty) {
                                          wrongAnswer++;
                                        }
                                        questionsLists[currentQuestionIndex].isCorrect = false;
                                      }
                                      currentQuestionIndex++;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    currentQuestionIndex + 1 ==
                                            questionsLists.length
                                        ? "Finish Quiz"
                                        : "Next",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.75),
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  Widget answerOption(int index, bool isSelect, String optionValue) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectAnswerOption = index;
          questionsLists[currentQuestionIndex].yourAnswer = optionValue;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: isSelect == true ? Colors.blue.shade200 : Colors.white,
            border: Border.all(color: Colors.blue.shade200, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /* Checkbox(value: value, onChanged: (newValue) {
                setState(() {
                  value = newValue!;
                });
              }),*/
            Expanded(
                child: Text(optionValue,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: isSelect == true
                            ? Colors.white
                            : Colors.black.withOpacity(0.8))))
          ],
        ),
      ),
    );
  }
}
