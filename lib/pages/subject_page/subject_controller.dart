import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/add_image_use_case.dart';
import 'package:mybooknote/usecases/list_images_usecase.dart';

import '../../database/repositories/subjects/implemtations/subject_repository.dart';
part 'subject_controller.g.dart';

class SubjectController = _SubjectControllerBase with _$SubjectController;

abstract class _SubjectControllerBase with Store {
    
  final ImagePicker _picker = ImagePicker();

  ObservableList<ImageEntity> images = ObservableList<ImageEntity>(); 

  SubjectRepository subjectRepository = SubjectRepository();
  final ListImagesUseCase _listImagesUsecase = ListImagesUseCase(getIt<SubjectRepository>());
  final AddImageUsecase _addImageUsecase = AddImageUsecase(getIt<SubjectRepository>());

  _SubjectControllerBase({required String subjectID}) {
    loadImages(id: subjectID);
  }

  @observable
  int count = 0;

  @action 
  void add() {
    count++;
  }

  @action
  Future<void> loadImages({required String id}) async {
    List<ImageEntity> list = await _listImagesUsecase(id: id);
    images.addAll(list.reversed);
  }

  addFotoTeste() async{
  }

  @action
  Future<void> pickImageFromGalery({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      ImageEntity newImage = await _addImageUsecase.call(id: subjectID, urlImage: image.path);
      images.add(newImage);
    }
  }

  @action
  Future<void> pickImageFromCamera({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      ImageEntity newImage = await _addImageUsecase.call(id: subjectID, urlImage: image.path);
      images.add(newImage);
    }
  }
}