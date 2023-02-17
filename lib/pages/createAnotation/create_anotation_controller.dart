import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/add_image_use_case.dart';

import '../../database/repositories/subjects/implemtations/subject_repository.dart';
part 'create_anotation_controller.g.dart';

class CreateAnotationController = _CreateAnotationControllerBase with _$CreateAnotationController;

abstract class _CreateAnotationControllerBase with Store {
  ObservableList<ImageEntity> images = ObservableList<ImageEntity>();
  final ImagePicker _picker = ImagePicker();
  final AddImageUsecase _addImageUsecase = AddImageUsecase(getIt<SubjectRepository>());

  createAnotation() async {
    //Create
    //FirebaseFirestore db = FirebaseFirestore.instance;
    //var collectionData = db.collection("subjects").doc('5M9geOM4qoDARvcXDGW8').collection('anotations');
    //await collectionData.add({
    //  'title': 'Geo aula 12',
    //  'description': 'Aula feita com o Sales',
    //  'images': [],
//
    //});

    //AddImage


    FirebaseFirestore db = FirebaseFirestore.instance;
    var collectionData = db
        .collection("subjects")
        .doc('5M9geOM4qoDARvcXDGW8')
        .collection('anotations')
        .doc('SVDql2ksXroWaZspBFuY');
    var get = await collectionData.get();
    var images = get.data()?['images'] as List;
    images = [...images, 'foto2'];


    await collectionData.set({
      'images': images
    }, SetOptions(merge: true));
  }

  @action
  Future<void> pickImageFromGalery({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      ImageEntity newImage = await _addImageUsecase.call(id: subjectID, urlImage: image.path);
      images.add(newImage);
    }
  }

  @action
  Future<void> pickImageFromCamera({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ImageEntity newImage = await _addImageUsecase.call(id: subjectID, urlImage: image.path);
      images.add(newImage);
    }
  }
}
