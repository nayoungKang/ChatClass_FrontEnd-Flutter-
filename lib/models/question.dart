import 'dart:convert';

// A flutter class that resemble our rest API's request response data
class Question {
  final String id;
  String title;
  String status;
  String createdAt;
  String respondedAt;
  bool isChecked;

// Flutter way of creating a constructor
  Question(
      {this.id = '',
      this.title = '',
      this.status = 'Pending',
      this.createdAt,
      this.respondedAt,
      this.isChecked});

// factory for mapping JSON to current instance of the Todo class
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json['id'],
        title: json['title'],
        status: json['status'],
        createdAt: json['createdAt'],
        respondedAt: json['respondedAt'],
        isChecked: json['isChecked']);
  }

// Instance method for converting a todo item to a map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "status": status,
      "createdAt": createdAt,
      "respondedAt": respondedAt,
      "isChecked": isChecked
    };
  }
}

List<Question> questionFromJson(String jsonData) {
  // Decode json to extract a map
  final data = json.decode(jsonData);

  // Map each todo JSON to a Todo object and return the result as a List<ToDo>
  return List<Question>.from(data.map((item) => Question.fromJson(item)));
}

// A helper method to convert the todo object to JSON String
String questionToJson(Question data) {
  // First we convert the object to a map
  final jsonData = data.toMap();

  // Then we encode the map as a JSON string
  return json.encode(jsonData);
}
