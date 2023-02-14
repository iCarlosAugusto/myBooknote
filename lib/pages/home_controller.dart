import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/database/repositories/subjects/implemtations/subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/create_new_subject_usecase.dart';
import 'package:mybooknote/usecases/get_all_subjects_usecase.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase() {
    Future.delayed(const Duration(seconds: 2), () {
      getAllSubjects();
    });
  }

  final GetAllSubjectsUsecase _getAllSubjectsUsecase = GetAllSubjectsUsecase(getIt<SubjectRepository>());
  final CreateNewSubjectUseCase _createNewSubjectUseCase =
      CreateNewSubjectUseCase(getIt<SubjectRepository>());

  TextEditingController subjectTextfieldController = TextEditingController();
  TextEditingController professorTextfieldController = TextEditingController();

  ObservableList subjects = ObservableList();
  @observable
  bool isLoading = true;

  @action
  Future<void> getAllSubjects() async {
    var result = await _getAllSubjectsUsecase();
    subjects.addAll(result);
    isLoading = false;
  }

  @action
  Future<void> createNewSubject({required String name, required String professor}) async {
    SubjectEntity subject = await _createNewSubjectUseCase.call(name: name, professor: professor);
    subjects.add(subject);
  }

  criarNoFirebase() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = <String, dynamic>{"first": "Ada", "last": "Lovelace", "born": 1815};
    db.collection("users").add(user).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
