import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/main.dart';
import 'package:mybooknote/usecases/add_image_use_case.dart';
import 'package:mybooknote/usecases/list_images_usecase.dart';

import '../../database/repositories/subjects/implemtations/subject_repository.dart';
part 'subject_controller.g.dart';

class SubjectController = _SubjectControllerBase with _$SubjectController;

abstract class _SubjectControllerBase with Store {
    
  final ImagePicker _picker = ImagePicker();

  ObservableList<String> images = ObservableList<String>(); 

  SubjectRepository subjectRepository = SubjectRepository();
  final ListImagesUseCase _listImagesUsecase = ListImagesUseCase(getIt<SubjectRepository>());
  final AddImageUsecase _addImageUsecase = AddImageUsecase(getIt<SubjectRepository>());

  _SubjectControllerBase() {
    loadImages();
  }

  @observable
  int count = 0;

  @action 
  void add() {
    count++;
  }

  @action
  Future<void> loadImages() async {
    List<String> imageList = await _listImagesUsecase.call();
    images.addAll(imageList);
  }

  @action
  Future<void> pickImageFromGalery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      images.add(image.path);
      _addImageUsecase.call(id: 1, urlImage: image.path);
    }
  }

  @action
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      images.add(image.path);
      _addImageUsecase.call(id: 1, urlImage: image.path);
    }
  }
}