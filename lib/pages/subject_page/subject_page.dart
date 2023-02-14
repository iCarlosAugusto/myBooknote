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
            Row(
              children: [
                GestureDetector(
                  onTap: subjectController.pickImageFromGalery,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, right: 6),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: subjectController.pickImageFromCamera,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: Observer(builder: (_) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          width: 200,
                          height: 250,
                          child: Image.file(
                            File(subjectController.images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: subjectController.images.length);
              }),
            ),

          ],
        ),
      ),
    );
  }
}
