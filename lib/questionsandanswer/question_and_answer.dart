import 'package:flutter/material.dart';

import '../utils/questions_data.dart';

class QuestionAndAnswer extends StatefulWidget {
  List<Questions> questionsList;

  QuestionAndAnswer({required this.questionsList, super.key});

  @override
  State<QuestionAndAnswer> createState() => _QuestionAndAnswerState();
}

class _QuestionAndAnswerState extends State<QuestionAndAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "Question And Answer",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75)),
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blue.shade50,
              child: ListView.builder(
                  itemCount: widget.questionsList.length,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        /*boxShadow: [
                            BoxShadow(
                                offset: const Offset(10, 10),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.black.withOpacity(0.3))
                          ]*/
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Q: ${index + 1} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.75),
                                    fontSize: 22),
                              ),
                              Expanded(
                                child: Text(
                                  widget.questionsList[index].questions,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black.withOpacity(0.75),
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Your Answer: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 16),
                              ),
                              Text(
                                widget.questionsList[index].yourAnswer,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Correct Answer: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 16),
                              ),
                              Text(
                                widget.questionsList[index].correctOption,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          widget.questionsList[index].yourAnswer.isNotEmpty ==
                                  true
                              ? ListTile(
                                  leading: widget
                                              .questionsList[index].isCorrect ==
                                          true
                                      ? Icon(Icons.check,
                                          color: Colors.blue.withOpacity(0.75))
                                      : Icon(Icons.close,
                                          color: Colors.red.withOpacity(0.75)),
                                  title: Text(
                                    widget.questionsList[index].isCorrect ==
                                            true
                                        ? "Correct answer"
                                        : "Wrong Answer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: widget.questionsList[index]
                                                    .isCorrect ==
                                                true
                                            ? Colors.blue.withOpacity(0.75)
                                            : Colors.red.withOpacity(0.75),
                                        fontSize: 16),
                                  ),
                                )
                              : ListTile(
                                  leading: Icon(Icons.error_outline_sharp,
                                      color: Colors.black.withOpacity(0.75)),
                                  title: Text(
                                    "Not Attempt",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.75),
                                        fontSize: 16),
                                  ),
                                )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
