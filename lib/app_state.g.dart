// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on AppStateBase, Store {
  late final _$l1Atom = Atom(name: 'AppStateBase.l1', context: context);

  @override
  double get l1 {
    _$l1Atom.reportRead();
    return super.l1;
  }

  @override
  set l1(double value) {
    _$l1Atom.reportWrite(value, super.l1, () {
      super.l1 = value;
    });
  }

  late final _$l2Atom = Atom(name: 'AppStateBase.l2', context: context);

  @override
  double get l2 {
    _$l2Atom.reportRead();
    return super.l2;
  }

  @override
  set l2(double value) {
    _$l2Atom.reportWrite(value, super.l2, () {
      super.l2 = value;
    });
  }

  late final _$AppStateBaseActionController =
      ActionController(name: 'AppStateBase', context: context);

  @override
  void setL1(double l1) {
    final _$actionInfo =
        _$AppStateBaseActionController.startAction(name: 'AppStateBase.setL1');
    try {
      return super.setL1(l1);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setL2(double l2) {
    final _$actionInfo =
        _$AppStateBaseActionController.startAction(name: 'AppStateBase.setL2');
    try {
      return super.setL2(l2);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
l1: ${l1},
l2: ${l2}
    ''';
  }
}
