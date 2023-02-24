// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthenticationController on _AuthenticationControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_AuthenticationControllerBase.isLoading', context: context);

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

  late final _$authenticateAsyncAction = AsyncAction(
      '_AuthenticationControllerBase.authenticate',
      context: context);

  @override
  Future<void> authenticate() {
    return _$authenticateAsyncAction.run(() => super.authenticate());
  }

  late final _$_AuthenticationControllerBaseActionController =
      ActionController(name: '_AuthenticationControllerBase', context: context);

  @override
  dynamic checkUser() {
    final _$actionInfo = _$_AuthenticationControllerBaseActionController
        .startAction(name: '_AuthenticationControllerBase.checkUser');
    try {
      return super.checkUser();
    } finally {
      _$_AuthenticationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validateEmail(String? value) {
    final _$actionInfo = _$_AuthenticationControllerBaseActionController
        .startAction(name: '_AuthenticationControllerBase.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_AuthenticationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validatePassword(String? value) {
    final _$actionInfo = _$_AuthenticationControllerBaseActionController
        .startAction(name: '_AuthenticationControllerBase.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_AuthenticationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
