// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getAllSubjectsAsyncAction =
      AsyncAction('_HomeControllerBase.getAllSubjects', context: context);

  @override
  Future getAllSubjects() {
    return _$getAllSubjectsAsyncAction.run(() => super.getAllSubjects());
  }

  late final _$createNewSubjectAsyncAction =
      AsyncAction('_HomeControllerBase.createNewSubject', context: context);

  @override
  Future<void> createNewSubject(
      {required String name, required String professor}) {
    return _$createNewSubjectAsyncAction
        .run(() => super.createNewSubject(name: name, professor: professor));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
