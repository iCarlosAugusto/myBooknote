// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SubjectController on _SubjectControllerBase, Store {
  late final _$countAtom =
      Atom(name: '_SubjectControllerBase.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$_SubjectControllerBaseActionController =
      ActionController(name: '_SubjectControllerBase', context: context);

  @override
  void add() {
    final _$actionInfo = _$_SubjectControllerBaseActionController.startAction(
        name: '_SubjectControllerBase.add');
    try {
      return super.add();
    } finally {
      _$_SubjectControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count}
    ''';
  }
}
