import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canpmemo/src/memo/model/memo_notifier.dart';
import 'package:canpmemo/src/memo/memo_add.dart';
import 'memo_detail.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
      create: (_) => Model(),
      child: Scaffold(
        backgroundColor: Color(0xffECEAD8),
        appBar: AppBar(
          title: const Text(
            'メモ一覧',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xff3D6E55),
        ),
        body: Consumer<Model>(
          builder: (context, model, child) {
            final content = model.content;
            return ListView.builder(
              itemCount: content.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
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
                                      ? '${content[index].title.substring(0, 16)}...'
                                      : content[index].title,
                                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                );
              },
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
          backgroundColor: const Color(0xff3D6E55),
          child: const Icon(Icons.note_add, color: Colors.white),
        ),
      ),
    );
  }
}

