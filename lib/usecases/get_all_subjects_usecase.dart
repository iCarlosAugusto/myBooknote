import 'package:mybooknote/database/repositories/i_subject_repository.dart';

class GetAllSubjectsUsecase {

  final ISubjectRepository _subjectRepository;
  GetAllSubjectsUsecase(this._subjectRepository);

  Future<List> call() async {
    List subjects = await _subjectRepository.list();
    return subjects;
  }
}