import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/routes/global_context.dart';
import 'package:mybooknote/usecases/add_image_use_case.dart';
import 'package:go_router/go_router.dart';
import '../../database/repositories/subjects/implemtations/subject_repository.dart';
import 'package:file_picker/file_picker.dart';
part 'create_anotation_controller.g.dart';

class CreateAnotationController = _CreateAnotationControllerBase with _$CreateAnotationController;

abstract class _CreateAnotationControllerBase with Store {
  _CreateAnotationControllerBase({required this.subjectID}) {
    subjectID = subjectID;
  }
  late String subjectID;
  ObservableList<ImageEntity> images = ObservableList<ImageEntity>();
  final ImagePicker _picker = ImagePicker();
  final AddImageUsecase _addImageUsecase = AddImageUsecase(getIt<SubjectRepository>());

  TextEditingController titleTextfieldController = TextEditingController();
  TextEditingController descriptionTextfieldController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  createAnotation() async {
    if (!formKey.currentState!.validate()) return;

    List<Map<String, dynamic>> imagesAdded = images
        .map((element) =>
            ImageEntity(url: element.url, description: element.description, title: element.title).toJson())
        .toList();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var collectionData = db.collection("subjects").doc(subjectID).collection('anotations');
    await collectionData.add({
      'title': titleTextfieldController.text,
      'description': descriptionTextfieldController.text,
      'images': imagesAdded
    });
    // ignore: use_build_context_synchronously
    GlobalContext.navigatorKey.currentContext!.pop();
    ScaffoldMessenger.of(GlobalContext.navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text('Anotação criada com sucesso!')),
    );
  }

  @action
  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {

      var imagesFormatted = result.files.map((file) => ImageEntity(url: file.path!, title: 'Title Legal', description: 'Description Legal'));
      images.addAll(imagesFormatted);
    } else {
      // User canceled the picker
    }
  }

  @action
  Future<void> pickImageFromGalery() async {
    final List<XFile?> imagesPicked = await _picker.pickMultiImage();
    if (imagesPicked.isNotEmpty) {
      var imagesFormatted = imagesPicked.map(
          (image) => ImageEntity(url: image!.path, title: 'Title Legal', description: 'Description Legal'));
      images.addAll(imagesFormatted);
    }
  }

  @action
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      images.add(ImageEntity(url: image.path, title: 'Title Legal', description: 'Description legal'));
    }
  }
}
