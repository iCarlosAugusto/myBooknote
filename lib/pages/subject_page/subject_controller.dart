import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/add_image_use_case.dart';
import 'package:mybooknote/usecases/list_images_usecase.dart';

import '../../database/repositories/subjects/implemtations/subject_repository.dart';
part 'subject_controller.g.dart';

class SubjectController = _SubjectControllerBase with _$SubjectController;

abstract class _SubjectControllerBase with Store {
    
  final ImagePicker _picker = ImagePicker();

  ObservableList images = ObservableList(); 

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
    List list = await _listImagesUsecase(id: id);
    images.addAll(list);
  }

  addFotoTeste() async{
    var count = 0;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var result = await db.collection("subjects")
      .doc("nPFz8RVcSYHJQWfq5dMA")
      .get();
    var subject = SubjectEntity.fromMap(result);
    var images = ['Adicionada teste $count', ...subject.images];
    db.collection("subjects").doc("nPFz8RVcSYHJQWfq5dMA").update({
      'images': images
    });
    count++;
      //.update({
      //  'images': ['Novo teste 15 fev']
      //});
  }

  @action
  Future<void> pickImageFromGalery({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      images.add(image.path);
      _addImageUsecase.call(id: subjectID, urlImage: image.path);
    }
  }

  @action
  Future<void> pickImageFromCamera({required String subjectID}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      images.add(image.path);
      _addImageUsecase.call(id: subjectID, urlImage: image.path);
    }
  }
}