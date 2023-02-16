import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/image_entity.dart';

class ListImagesUseCase {
  final ISubjectRepository _subjectRepository;
  ListImagesUseCase(this._subjectRepository);

  Future<List<ImageEntity>> call({required String id}) async {
    List<ImageEntity> list = await _subjectRepository.listImages(id: id);
    return list;
  }
}