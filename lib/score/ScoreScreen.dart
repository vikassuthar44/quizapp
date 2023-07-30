import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../database/ResultModel.dart';
import '../database/local_database.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final LocalDatabase localDatabase = LocalDatabase();
  late List<ResultModel> resultModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Previous Result",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75)),
        ),
        centerTitle: true,
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
            ),
            FutureBuilder(
              future: localDatabase.getResultModelList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  resultModel = snapshot.data!;
                  resultModel = resultModel.reversed.toList();
                  return ListView.builder(
                      itemCount: resultModel.length,
                      itemBuilder: (context, index) {
                        ResultModel singleResultModel = resultModel[index];
                        int noOfQuestions = int.parse(singleResultModel.totalQuestion);
                        int totalScore = int.parse(singleResultModel.score);
                        double percentage = (totalScore/(noOfQuestions*5));
                        String percentageText;
                        if(percentage == 1.0) {
                          percentageText = (percentage*100).toString().substring(0,3);
                        } else {
                          if(percentage == 0.0) {
                            percentageText = (percentage*100).toString().substring(0,1);
                          } else {
                            percentageText = (percentage*100).toString().substring(0,2);
                          }
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Quiz: ${singleResultModel.categoryName}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Text(
                                      "Total Questions: ${singleResultModel.totalQuestion}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  Text("Date: ${singleResultModel.dateAndTime}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  Text("Your Score: ${singleResultModel.score}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ],
                              ),
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 10.0,
                                percent: percentage,
                                animationDuration: 1200,
                                circularStrokeCap: CircularStrokeCap.round,
                                center:  Text( "$percentageText%"),
                                progressColor: percentage > 0.4 ? Colors.green : Colors.red,
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Container(
                      padding: const EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: const Center(
                        child: Text("Result here..."),
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
    ;
  }

}
