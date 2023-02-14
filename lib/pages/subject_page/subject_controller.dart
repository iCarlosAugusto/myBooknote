import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/main.dart';

import '../../database/repositories/subjects/implemtations/subject_repository.dart';
part 'subject_controller.g.dart';

class SubjectController = _SubjectControllerBase with _$SubjectController;

abstract class _SubjectControllerBase with Store {
    
  final ImagePicker _picker = ImagePicker();

  ObservableList images = ObservableList(); 
  SubjectRepository subjectRepository = SubjectRepository();

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
  loadImages() async {
    List resultImages = await getIt<SubjectRepository>().listImages();
    images.addAll(resultImages);
  }

  @action
  pickImageFromGalery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      images.add(image.path);
      getIt<SubjectRepository>().addImage(id: 1, urlImage: image.path);
    }
  }

  @action
  pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      images.add(image.path);
    }
  }
}