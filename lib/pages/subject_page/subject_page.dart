import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/entities/anotation_entity.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/pages/subject_page/subject_controller.dart';

class SubjectPage extends StatelessWidget {
  final String subjectID;
  const SubjectPage({super.key, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    SubjectController subjectController = SubjectController(subjectID: subjectID);
    List<ImageEntity> selectedImages = [];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Observer(builder: (_) {
          return AppBar(
              leading: subjectController.selectedImages.isNotEmpty
                  ? IconButton(
                      onPressed: subjectController.clearSelectedImages, icon: const Icon(Icons.close))
                  : null,
              title: Text(subjectController.selectedImages.isEmpty
                  ? 'Matéria'
                  : subjectController.selectedImages.length.toString()));
        }),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              StreamBuilder(
                stream: subjectController.snapshot,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  final docs = snapshot.data!.docs;
                  return SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final data = docs[index].data();
                        //AnotationEntity anotation  = AnotationEntity.fromJson(data);
                        //print(anotation);
                        return Text(data['title']);
                      }, itemCount: docs.length),
                  );
                },
              ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/createAnotation/$subjectID'),
          ),
    );
  }
}
