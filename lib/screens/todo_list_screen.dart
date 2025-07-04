import 'package:flutter/material.dart';
import 'package:flutter_study_app/models/todo.dart';
import 'todo_edit_screen.dart';

// 画面のWidgetクラス。StatefulWidgetはチェックボックスとかの状態管理を行う画面で使う
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  //表示するToDoのサンプルデータ
  List<Todo> todos = [
    Todo(id: '0', title: '牛乳を買う'),
    Todo(id: '1', title: '掃除する'),
    Todo(id: '2', title: 'Flutterの勉強'),
  ];
  //チェック状謡のON/OFFを切り替える関数。
  void toggleTodo(String id) {
    setState(() {
      final index = todos.indexWhere((todo) => todo.id == id);
      //要素が見つかった場合に入る。indexWhereの返却値で要素が見つからない場合-1を返す。
      if (index != -1){
        //ここで逆にさせる
        todos[index].isDone = !todos[index].isDone;
      }
    });
  }

  @override
  // buildは画面の見た目を構築する関数。WidgetはUIを構築するためのクラス
  Widget build(BuildContext context){
    //ScaffoldはFlutterでよく見る骨組み
    return Scaffold(
      //AppBarは画面上部のタイトルバー
      appBar: AppBar(
        title: const Text('ToDoリスト'),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              todos.removeWhere((todo) => todo.isDone);
            });
          }, icon: const Icon(Icons.delete))
        ],
      ),
      //ListViewはスクロール可能なリスト。mapの処理でtodoの中身を1件ずつ処理してく。
      body: ListView(
        children: todos.map((todo) {
          return ListTile(
            leading: Icon(
              //チェック済みかどうかでIconを変える
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            onTap: () => toggleTodo(todo.id),
          );
        }).toList(),
      ),
      // Scaffoldの中に以下を追加してください
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // TodoEditScreen に遷移し、新しいTodoを取得
          final newTodo = await Navigator.push<Todo>(
            context,
            MaterialPageRoute(
              builder: (context) => TodoEditScreen(),
            ),
          );

          // 戻り値が null でなければ追加
          if (newTodo != null) {
            setState(() {
              todos.add(newTodo);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}