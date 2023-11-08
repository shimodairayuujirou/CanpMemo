import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memoapp/src/model.dart';
import 'package:memoapp/src/add.dart';
import 'detail.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
      create: (_) => Model()..fetchContent(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          title: const Text(
            'メモ一覧',
            style: TextStyle(color: Color.fromARGB(255, 227, 191, 32), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        ),
        body: Consumer<Model>(
          builder: (context, model, child) {
          final content = model.content;
          return ListView.builder(
              itemCount: content.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        height: 80,
                        child: Card(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              print(content[index].Id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    detail: content[index].detail,
                                    title: content[index].title,
                                    Id: content[index].Id,
                                  )
                                ),
                              );
                            },
                            child: Row(
                              children:[
                                const Padding(padding: EdgeInsets.only(left: 10),),
                                Text(
                                  content[index].title.length > 16
                                    ? '${content[index].title.substring(0, 16)}...' // 17文字を超える場合、17文字まで切り取って "..." を追加
                                    : content[index].title,
                                  // 17文字以下の場合はそのまま表示
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ]
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                );
              }
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          child: const Icon(Icons.note_add,color: Color.fromARGB(255, 227, 191, 32),),
        ),
      )
    );
  }
}
