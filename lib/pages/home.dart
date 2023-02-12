import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/pages/subject_page/subject_page.dart';
import 'package:mybooknote/widgets/subjectCard/subject_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController subjectTextfieldController = TextEditingController();
  TextEditingController professorTextfieldController = TextEditingController();

  List<SubjectEntity> subjects = [
    SubjectEntity(name: 'Direito civil', professor: 'Leonardo'),
  ];
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
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) => SubjectCard(
                        name: subjects[index].name,
                        professor: subjects[index].professor,
                        onLongPress: () => selectedSubjects.add(subjects[index]),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SubjectPage()),
                          );
                        },
                        selected: selectedSubjects.contains(subjects[index])),
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: subjects.length),
              )
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
                            TextFormField(controller: subjectTextfieldController),
                            TextFormField(controller: professorTextfieldController),
                            ElevatedButton(
                                onPressed: () {
                                  SubjectEntity newSubject = SubjectEntity(
                                      name: subjectTextfieldController.text,
                                      professor: professorTextfieldController.text);
                                  setState(() {
                                    subjects.add(newSubject);
                                  });
                                },
                                child: const Text('Criar'))
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
