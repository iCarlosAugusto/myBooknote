import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mybooknote/pages/subject_page/subject_controller.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    SubjectController subjectController = SubjectController();

    return Scaffold(
      appBar: AppBar(title: const Text('Materia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Imagens'),
            GestureDetector(
              onTap: subjectController.pickImageFromGalery,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
            Container(
              height: 500,
              child: Observer(builder: (_) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Image.file(
                          File(subjectController.images[index].path),
                          width: 300,
                          height: 300,
                        ),
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                    itemCount: subjectController.images.length);
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            print(subjectController.images[0].path);
          },
          child: const Text('add')),
    );
  }
}
