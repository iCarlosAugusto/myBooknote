import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';

class CreateNewSubjectUseCase {

  final ISubjectRepository _subjectRepository;
  CreateNewSubjectUseCase(this._subjectRepository);

  call({required String name, required String professor }) {
    _subjectRepository.create(name: name, professor: professor);
  }
}