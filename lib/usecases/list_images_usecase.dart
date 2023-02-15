import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';

class ListImagesUseCase {
  final ISubjectRepository _subjectRepository;
  ListImagesUseCase(this._subjectRepository);

  Future<List> call({required String id}) async {
    List list = await _subjectRepository.listImages(id: id);
    return list;
  }
}