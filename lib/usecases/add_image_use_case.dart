import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/image_entity.dart';

class AddImageUsecase {

  final ISubjectRepository _subjectRepository;
  AddImageUsecase(this._subjectRepository);

  Future<ImageEntity> call({required String id, required String urlImage}) async {
    ImageEntity image = await _subjectRepository.addImage(id: id, urlImage: urlImage);
    return image;
    //await _subjectRepository.addImage(id: id, urlImage: urlImage);
  }
}