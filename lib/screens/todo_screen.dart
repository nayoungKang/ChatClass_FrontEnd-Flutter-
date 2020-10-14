import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/manage_todo_widget.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import '../screens/questiondetail_screen.dart';
import '../screens/modules.dart';
import '../lib/auth_provider.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app), //Icon(Icons.add),
            onPressed: () =>
                authProvider.signOut(), //_openManageTodoSheet(null, context),
          ),
        ],
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openManageTodoSheet(null, context),
      ),*/
      body: SafeArea(
        child: FutureBuilder(
          future:
              _apiService.getQuestions(), // Get todos which returns a future
          builder:
              (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Called when the future is resolved (i.e: when the result is returned from the server)
              List<Question> todos = snapshot.data;
              return _buildListView(todos);
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
  Widget _buildListView(List<Question> toDos) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: toDos == null ? 0 : toDos.length, //toDos.length,
        itemBuilder: (context, index) {
          Question toDo = toDos[index];
          return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    QuestionDetailScreen.id,
                    arguments: DetailScreenArguments(toDo.id),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          toDo.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(toDo.status),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                _apiService.deleteTodo(toDo.id).then((_) {
                                  setState(() {
                                    // Here we call set state in order to rebuild the widget and get todos
                                  });
                                });
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                _openManageTodoSheet(toDo, context);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Text(toDo.createdAt),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

// This method opens the modal bottom sheet which hosts the ManageTodoWidget which is responsible for editing or adding new Todos
  void _openManageTodoSheet(Question toDo, BuildContext context) {
    toDo = toDo ?? new Question();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: ManageTodoWidget(
            question: toDo,
            saveChanges:
                _saveChanges, // We pass a reference tho the _saveChanges so we can call it from the child widget
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _saveChanges(Question todo) {
    if (todo.id == '') {
      // New Todo with id zero
      _apiService.addToDo(todo).then((_) {
        Navigator.of(context).pop(); // Close Modal Bottom sheet
        setState(
            () {}); // Calling set state to rebuild the UI and get fresh todo list
      });
    } else {
      _apiService.updateToDo(todo).then((_) {
        Navigator.of(context).pop(); // Close Modal Bottom sheet
        setState(
            () {}); // Calling set state to rebuild the UI and get fresh todo list
      });
    }
  }
}
