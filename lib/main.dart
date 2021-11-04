import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My Todo App1',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  List<String> todoList = [
    '111',
    '222',
    '333',
    'title',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final text = todoList[index];
          return Dismissible(
            key: Key(text),
            secondaryBackground: Container(
              padding: EdgeInsets.only(
                right: 10,
              ),
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),

            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.orangeAccent[200],
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Icon(Icons.thumb_up, color: Colors.white),
              ),
            ),

            // direction: DismissDirection.startToEnd,
            //direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // 右から左にスワイプされた時
              } else {
                // それ以外
                print('onDismissed');
                todoList.removeAt(index);
              }
            },
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// リスト追加画面用Widget
class TodoAddPage extends StatefulWidget {
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('リスト追加画面'),
        ),
        body: Container(
            padding: EdgeInsets.all(64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_text, style: TextStyle(color: Colors.blue)),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (String value) {
                    setState(() {
                      _text = value;
                    });
                  },
                ),
                const SizedBox(
                  //リスト追加ボタン
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_text);
                    },
                    child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                    //キャンセルボタン
                    height: 8),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('キャンセル'),
                  ),
                )
              ],
            )));
  }
}
