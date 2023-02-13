import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mybooknote/entities/subject_entity.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Olá, Carlos.'),
              Container(
                height: 300,
                child: Observer(builder: (_) {
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) => SubjectCard(
                          name: controller.subjects[index]['name'],
                          professor: controller.subjects[index]['professor'],
                          onLongPress: () => selectedSubjects.add(controller.subjects[index]),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SubjectPage()),
                            );
                          },
                          selected: selectedSubjects.contains(controller.subjects[index])),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: controller.subjects.length);
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Padding(
                    padding: EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 900,
                        child: Form(
                            child: Column(
                          children: [
                            const Text("Criar nova disciplina"),
                            TextFormField(controller: controller.subjectTextfieldController),
                            TextFormField(controller: controller.professorTextfieldController),
                            ElevatedButton(
                                onPressed: () => controller.createNewSubject(
                                    name: controller.subjectTextfieldController.text,
                                    professor: controller.professorTextfieldController.text),
                                child: const Text('Criar')),
                          ],
                        )),
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
