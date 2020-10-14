import 'dart:convert';

// A flutter class that resemble our rest API's request response data
class QuestionDetail {
  final String id;
  String questionId;
  String qContent;
  int category;
  List rList;
  String rContent;

  QuestionDetail(
      // constructor
      {this.id = '',
      this.questionId = '',
      this.qContent = '',
      this.category,
      this.rList,
      this.rContent});

// factory for mapping JSON to current instance of the Todo class
  factory QuestionDetail.fromJson(Map<String, dynamic> json) {
    return QuestionDetail(
        id: json['id'],
        questionId: json['questionId'],
        qContent: json['qContent'],
        category: json['category'],
        rList: json['rList'],
        rContent: json['rContent']);
  }

// Instance method for converting a todo item to a map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "questionId": questionId,
      "qContent": qContent,
      "category": category,
      "rList": rList,
      "rContent": rContent
    };
  }

  //  A helper method that converts a json array into List<ToDo>

}

List<QuestionDetail> questionDetailFromJson(String jsonData) {
  // Decode json to extract a map
  final data = json.decode(jsonData);

  // Map each todo JSON to a Todo object and return the result as a List<ToDo>
  return List<QuestionDetail>.from(
      data.map((item) => QuestionDetail.fromJson(item)));
}

// A helper method to convert the todo object to JSON String
String questionDetailToJson(QuestionDetail data) {
  // First we convert the object to a map
  final jsonData = data.toMap();

  // Then we encode the map as a JSON string
  return json.encode(jsonData);
}
