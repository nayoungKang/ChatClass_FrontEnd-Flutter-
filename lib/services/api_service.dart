import 'dart:convert';
import 'dart:collection';

import 'package:http/http.dart' as Http;

import 'package:http/io_client.dart';
import '../models/question.dart';
import '../models/questiondetail.dart';
import 'dart:io';

import 'package:http_logger_library/http_logger.dart';
import 'package:http_logger_library/log_level.dart';
import 'package:http_logger_library/logger.dart';
import 'package:http_logger_library/logging_middleware.dart';
import 'package:http_middleware_library/http_middleware.dart';

class ApiService {
  //final String baseUrl = "https://172.30.72.10:44368/api"; //response : 400
  //final String baseUrl = "https://10.0.2.2:44368/api"; //response : 400
  //final String baseUrl = "http://172.30.72.10:2683/api"; //response :400
  //final String baseUrl = "http://10.0.2.2:2683/api"; //response:400

  //final String baseUrl = "http://10.0.2.2:8080/api";
  final String baseUrl = "http://10.0.2.2:80/ChatClassApi/api";

  //Client client = Client();
  //HttpClient client = new HttpClient(); //io
  HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<List<Question>> getQuestions() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    try {
      var request = await client.getUrl(Uri.parse('$baseUrl/Question'));

      HttpClientResponse result = await request.close();
      if (result.statusCode == 200) {
        print('api call done');
        return (jsonDecode(await result.transform(utf8.decoder).join()) as List)
            .map((i) => Question.fromJson(i))
            .toList();
      } else {
        print(result.statusCode);
        print('api call failed');
        return null;
      }
    } catch (err) {
      print("response Arrived: $err");
    }

    /*HttpClientRequest request = await client
        .postUrl(Uri.parse("https://${serverConstants.serverUrl}$reqType"));

    request.headers.set('Content-Type', 'application/json');
    if (isTokenHeader) {
      request.headers.set('Authorization', 'Bearer $token');
    }
    request.add(utf8.encode(jsonEncode(model)));
     HttpClientResponse result = await request.close();*/

    /*
    final response = await client.get("$baseUrl/ToDos");
    if (response.statusCode == 200) {
      return fromJson(response.body);
    } else {
      return null;
    }*/
  }

//추후 클래스 분리 필요
  Future<List<QuestionDetail>> getQuestionDetails(String questionId) async {
    List<QuestionDetail> returnValue = null;
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    try {
      var request =
          await client.getUrl(Uri.parse('$baseUrl/DetailQuestion/$questionId'));
      HttpClientResponse result = await request.close();

      if (result.statusCode == 200) {
        print('getQuestionDetails api call done');
        returnValue =
            (jsonDecode(await result.transform(utf8.decoder).join()) as List)
                .map((i) => QuestionDetail.fromJson(i))
                .toList();
      } else {
        print(result.statusCode);
        print('getQuestionDetails api call failed');
      }
    } catch (err) {
      print("response Arrived: $err");
    }
    return returnValue;
  }

  // Update an existing DetailQuestion
  Future<bool> updateQuestionDetail(QuestionDetail data) async {
    print(questionDetailToJson(data));

    String url = "$baseUrl/DetailQuestion/${data.id}";
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';

    Http.Response response = await httpClient.put(url,
        headers: headers,
        body: questionDetailToJson(data),
        encoding: Encoding.getByName('utf-8'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(response.toString());
    /*final response = await client.put(
      Uri.parse("$baseUrl/DetailQuestion/${data.id}"),
      headers: {"content-type": "application/json"},
      body: questionDetailToJson(data),
    );
    if (response.statusCode == 204) {
      print('updateQuestionDetail api call done');
      return true;
    } else {
      print('updateQuestionDetail api call failed');
      print(response.statusCode);
      print(response.toString());
      return false;
    }*/
  }

// Update an existing Todo
  Future<bool> updateToDo(Question data) async {
    /*final response = await client.put(
      "$baseUrl/ToDos/${data.id}",
      headers: {"content-type": "application/json"},
      body: questionToJson(data),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }*/
  }

// Create a new Todo
  Future<bool> addToDo(Question data) async {
    /*final response = await client.post(
      "$baseUrl/ToDos",
      headers: {"content-type": "application/json"},
      body: questionToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }*/
  }

// Delete a Todo
  Future<bool> deleteTodo(String todoId) async {
    /*final response = await client.delete(
      "$baseUrl/ToDos/$todoId",
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }*/
  }

// Get list of all Todo Statuses
  Future<List<String>> getStatuses() async {
    /*final response = await client.get("$baseUrl/Config");
    if (response.statusCode == 200) {
      var data = (jsonDecode(response.body) as List<dynamic>).cast<String>();
      return data;
    } else {
      return null;
    }*/
  }
}
