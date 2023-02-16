import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/database/repositories/subjects/implemtations/subject_repository.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/pages/home_controller.dart';
import 'package:mybooknote/pages/subject_page/subject_page.dart';
import 'package:mybooknote/widgets/subjectCard/subject_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController controller = HomeController();

  List<SubjectEntity> selectedSubjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Olá, Carlos.'),
                ElevatedButton(
                    onPressed: controller.criarNoFirebase, child: const Text('Criar listar fotos')),
                SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: controller.subjects.snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return const CircularProgressIndicator();
                        return 
                        ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            SubjectEntity subject = SubjectEntity.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                            return SubjectCard(
                                name: subject.name,
                                professor: subject.professor,
                                onLongPress: () => print('LONG PRESS'),
                                onTap: () => context.push('/subject/${snapshot.data!.docs[index].id}'),
                                selected: false);
                          },
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemCount: snapshot.data!.docs.length,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                    child: SafeArea(
                      child: Form(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded)),
                              const Text("Criar nova disciplina"),
                            ],
                          ),
                          TextFormField(
                            controller: controller.subjectTextfieldController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Nome da disciplina',
                            ),
                          ),
                          TextFormField(
                            controller: controller.professorTextfieldController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Nome do professor',
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () => controller.createNewSubject(
                                  name: controller.subjectTextfieldController.text,
                                  professor: controller.professorTextfieldController.text),
                              child: const Text('Criar')),
                        ],
                      )),
                    ),
                  ));
        },
      ),
    );
  }
}
