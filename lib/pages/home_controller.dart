import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/database/repositories/subjects/implemtations/subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/create_new_subject_usecase.dart';
import 'package:mybooknote/usecases/get_all_subjects_usecase.dart';
import 'package:mybooknote/usecases/list_images_usecase.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase() {
    getAllSubjects();
  }

  final GetAllSubjectsUsecase _getAllSubjectsUsecase = GetAllSubjectsUsecase(getIt<SubjectRepository>());
  final CreateNewSubjectUseCase _createNewSubjectUseCase =
      CreateNewSubjectUseCase(getIt<SubjectRepository>());

  TextEditingController subjectTextfieldController = TextEditingController();
  TextEditingController professorTextfieldController = TextEditingController();

  late CollectionReference subjects;

  @observable
  bool isLoading = true;

  @action
  getAllSubjects() async {
    subjects = _getAllSubjectsUsecase.call();
  }

  @action
  Future<void> createNewSubject({required String name, required String professor}) async {
    await _createNewSubjectUseCase.call(name: name, professor: professor);
  }

  criarNoFirebase() async {
    var a = await ListImagesUseCase(getIt<SubjectRepository>()).call(id: 'id');
    print(a);
  }
}
