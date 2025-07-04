import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';

//編集対象のTodoをオプション引数(this.todo)で受け取る。Todoがnullなら新規モードになる
class TodoEditScreen extends StatefulWidget {
  final Todo? todo;

  const TodoEditScreen({Key? key, this.todo}) : super(key: key);

  @override
  _TodoEditScreenState createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  //テキスト入力欄の状態を制御するためのコントローラー
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      //初期化時に既存タスクが存在するならタイトルを設定する
      text: widget.todo?.title ?? '',
    );
  }
  @override
  //終了時に破棄する（メモリリーク防止）
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    final title = _titleController.text.trim();
    if(title.isEmpty) return;
    //入力が空でなければ、Todoを作成する
    final updateTodo = Todo(
      id: const Uuid().v4(),
      title: title,
      isDone: widget.todo?.isDone ?? false,
    );
    //新しいTodoを返して画面を閉じる
    Navigator.pop(context, updateTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'タスク追加' : 'タスク編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'タスク名を入力'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _saveTodo,
                child: Text('保存')
            )
          ],
        ),
      ),
    );
  }

}