class ResultModel {
  int? id;
  String categoryName;
  String totalQuestion;
  String dateAndTime;
  String score;

  ResultModel(
      {this.id,
      required this.categoryName,
      required this.totalQuestion,
      required this.dateAndTime,
      required this.score});

  ResultModel fromJson(json) {
    return ResultModel(
        id: json['id'],
        categoryName: json['categoryName'],
        totalQuestion: json['totalQuestion'],
        dateAndTime: json['dateAndTime'],
        score: json['score']);
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'totalQuestion': totalQuestion,
      'dateAndTime': dateAndTime,
      'score': score
    };
  }
}
