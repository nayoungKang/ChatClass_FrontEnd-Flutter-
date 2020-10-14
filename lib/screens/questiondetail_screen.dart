import 'package:condition/condition.dart';
import 'package:flutter/material.dart';
import '../widgets/manage_todo_widget.dart';
import '../models/questiondetail.dart';
import '../services/api_service.dart';
import '../screens/modules.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class QuestionDetailScreen extends StatefulWidget {
  static const String id = 'question_detail_screen';

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  ApiService _apiService;
  Future<List<QuestionDetail>> _questionDetails;

  double _currentSliderValue = 20; //슬라이더 value
  int _currentHorizontalIntValue = 10; //numpicker value
  DateTime _dateTime = DateTime.now();

  /*List<DropdownMenuItem<ListItem>> _dropdownMenuItems; //Dropdown*/
  /*ListItem _selectedItem;*/
  /*List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];*/

  @override
  void initState() {
    var args;
    super.initState();
    _apiService = ApiService();
    //_dropdownMenuItems = buildDropDownMenuItems(_dropdownItems); //Dropdown init
    //String _selectedItem; // = _dropdownMenuItems[0].value;

    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
      });
      //print(args['questionId']);
      _questionDetails = _apiService.getQuestionDetails(args.questionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final DetailScreenArguments args =ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:
              _questionDetails, //_apiService.getQuestionDetails(args.questionId),
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

  Widget _buildListView(List<QuestionDetail> questionDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questionDetails == null
                  ? 0
                  : questionDetails.length, //toDos.length,
              itemBuilder: (context, index) {
                QuestionDetail detail = questionDetails[index];

                /*if (_initStateCount == 0 && detail.category == 2) {
                  print('itemBuilder function trial');
                  _getListItem(detail.rContent);
                  _initStateCount++; //처음 시작 시에만 if문 적용 위함
                }*/

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
                                      detail.category == 1, //textfield
                                      builder: () => TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: detail.rContent,
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(8),
                                        ),
                                        onChanged: (text) {
                                          detail.rContent = text;
                                        },
                                      ),
                                    ),
                                    Case(detail.category == 3,
                                        builder: () =>
                                            /*TimePickerSpinner(
                                              is24HourMode: false,
                                              normalTextStyle: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.deepOrange),
                                              highlightedTextStyle: TextStyle(
                                                  fontSize: 24, color: Colors.yellow),
                                              spacing: 50,
                                              itemHeight: 80,
                                              isForce2Digits: true,
                                              onTimeChange: (time) {
                                                setState(() {
                                                  _dateTime = time;
                                                });
                                              },
                                            )),*/
                                            TimePickerSpinner(
                                              spacing: 40,
                                              minutesInterval: 15,
                                              onTimeChange: (time) {
                                                /*setState(() {
                                                  _dateTime = time;
                                                });*/
                                              },
                                            )),
                                    /*NumberPicker.horizontal(
                                              initialValue:
                                                  _currentHorizontalIntValue,
                                              minValue: 10,
                                              maxValue: 100,
                                              step: 10,
                                              zeroPad: false,
                                              onChanged: (value) => setState(() =>
                                                  _currentHorizontalIntValue = value),
                                            )),*/
                                    Case(detail.category == 2,
                                        builder: () =>
                                            /*DropdownButton<ListItem>(
                                            hint: Text('Choose one option'),
                                            items: buildDropDownMenuItems(
                                                detail.rList),
                                            onChanged: (selectedItem) {
                                              */ /*print(selectedItem.value);*/ /*
                                              setState(() {
                                                detail.rContent =
                                                    selectedItem.value;
                                              });
                                            })),*/
                                            DropdownButton<String>(
                                                hint: Text('Choose one option'),
                                                value: detail.rContent,
                                                items: buildDropDownMenuItems(
                                                    detail.rList),
                                                onChanged: (selectedItem) {
                                                  setState(() {
                                                    detail.rContent =
                                                        selectedItem;
                                                  });
                                                })),
                                    Case(detail.category == 4, //
                                        builder: () => RatingBar(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                //print(rating);
                                                detail.rContent =
                                                    rating.toString();
                                              },
                                            )),
                                    Case(detail.category == 5,
                                        builder: () => Slider(
                                              value: _currentSliderValue,
                                              min: 0,
                                              max: 100,
                                              divisions: 5,
                                              label: _currentSliderValue
                                                  .round()
                                                  .toString(),
                                              onChanged: (double value) {
                                                setState(() {
                                                  _currentSliderValue = value;
                                                  detail.rContent =
                                                      _currentSliderValue
                                                          .toString();
                                                });
                                              },
                                            )),
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
          ),
          FlatButton(
            onPressed: () {
              for (var i = 0; i < questionDetails.length; i++) {
                print(
                    '${questionDetails[i].id} ${questionDetails[i].questionId} ${questionDetails[i].rContent}');
                _apiService.updateQuestionDetail(questionDetails[i]);
              }
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  /*ListItem _getListItem(String rContent) {
    print('_getListItem entered');
    var selectedItem =
        _dropdownItems.where((element) => element.value == rContent).toList();
    return (selectedItem != null && selectedItem.length > 0)
        ? selectedItem[0]
        : _dropdownMenuItems[0].value;
    */ /*if (selectedItem != null && selectedItem.length > 0)
      _selectedItem = selectedItem[0];
    else {
      _selectedItem = _dropdownMenuItems[0].value;
    }
    return _selectedItem;*/ /*
  }*/
}
