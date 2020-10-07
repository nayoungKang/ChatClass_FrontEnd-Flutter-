import 'package:condition/condition.dart';
import 'package:flutter/material.dart';
import '../widgets/manage_todo_widget.dart';
import '../models/questiondetail.dart';
import '../services/api_service.dart';
import '../screens/modules.dart';

class QuestionDetailScreen extends StatefulWidget {
  static const String id = 'question_detail_screen';

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    final DetailScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _apiService.getQuestionDetails(
              args.questionId), // Get quetionDetails which returns a future
          builder: (BuildContext context,
              AsyncSnapshot<List<QuestionDetail>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Called when the future is resolved (i.e: when the result is returned from the server)
              List<QuestionDetail> questionDetails = snapshot.data;
              return _buildListView(questionDetails);
            } else {
              return Center(
                child:
                    CircularProgressIndicator(), // Loading with the request is being processed
              );
            }
          },
        ),
      ),
    );
  }

// Build todos list
  Widget _buildListView(List<QuestionDetail> questionDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: questionDetails == null
            ? 0
            : questionDetails.length, //toDos.length,
        itemBuilder: (context, index) {
          QuestionDetail detail = questionDetails[index];
          return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () => {},
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            detail.qContent,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Conditioned(
                            cases: [
                              Case(
                                detail.category == 1,
                                builder: () => TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '80',
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8),
                                  ),
                                ),
                              ),
                              Case(detail.category == 2,
                                  builder: () => Icon(Icons.home)),
                            ],
                            defaultBuilder: () => Icon(Icons.wb_sunny),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
