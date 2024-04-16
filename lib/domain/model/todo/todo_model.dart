class Todo {
  final int id;
  final String title;
  final String description;
  final bool isCheck;
  final DateTime created_at;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCheck,
      required this.created_at});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'],
        title: json['title'] as String,
        description: json['description'] as String,
        isCheck: json['isCheck'] as bool,
        created_at: json['created_at']);
  }
}

class TodoAllResponse {
  final int response_status;
  final List<Todo> response;

  TodoAllResponse({this.response_status = 400, this.response = const []});

  factory TodoAllResponse.fromJson(Map<String, dynamic> json) {
    return TodoAllResponse(
        response_status: json['response_status'] as int,
        response: List<Todo>.from(json['response'] as List)
            .map((todo) => Todo.fromJson(todo as dynamic))
            .toList());
  }
}
