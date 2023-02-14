import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';

class ListImagesUseCase {
  final ISubjectRepository _subjectRepository;
  ListImagesUseCase(this._subjectRepository);

  Future<List<String>>call() async {
    List<String> list = await _subjectRepository.listImages();
    return list;
  }
}