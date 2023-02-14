import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';

class AddImageUsecase {

  final ISubjectRepository _subjectRepository;
  AddImageUsecase(this._subjectRepository);

  Future<void> call({required int id, required String urlImage}) async {
    await _subjectRepository.addImage(id: id, urlImage: urlImage);
  }
}