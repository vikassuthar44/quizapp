import 'package:quiz_app/utils/questions_level.dart';

class FirebaseQuestionsList {
  late List<Questions> questionsList;

  FirebaseQuestionsList({required this.questionsList});

  FirebaseQuestionsList.fromDocumentSnapshot(Map<String, dynamic> data) {
    try {
      List<dynamic> list = data['questionslist'];
      for (var i = 0; i < list.length; i++) {
        Questions.fromDocumentSnapshot(list[i]);
      }
    } catch(e) {
      print("Exception: $e");
    }
  }
}
class Questions {
  late String questions;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String correctOption;
  late QuestionsLevel level;
  late String yourAnswer = "";
  late bool isCorrect = false;
  late String questiojsLevel;

  Questions(
      {required this.questions,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.correctOption,
      required this.questiojsLevel});

  Questions.fromDocumentSnapshot(Map<String, dynamic> data) {
    questions = data['question'];
    option1 = data['option1'];
    option2 = data['option2'];
    option3 = data['option3'];
    option4 = data['option4'];
    correctOption = data['correct'];
    questiojsLevel = data['type'];
  }
}

