// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppStateData _$AppStateDataFromJson(Map<String, dynamic> json) =>
    AppStateData()..x = (json['x'] as num).toDouble();

Map<String, dynamic> _$AppStateDataToJson(AppStateData instance) =>
    <String, dynamic>{
      'x': instance.x,
    };

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

  late final _$xAtom = Atom(name: 'AppStateBase.x', context: context);

  @override
  double get x {
    _$xAtom.reportRead();
    return super.x;
  }

  @override
  set x(double value) {
    _$xAtom.reportWrite(value, super.x, () {
      super.x = value;
    });
  }

  late final _$yAtom = Atom(name: 'AppStateBase.y', context: context);

  @override
  double get y {
    _$yAtom.reportRead();
    return super.y;
  }

  @override
  set y(double value) {
    _$yAtom.reportWrite(value, super.y, () {
      super.y = value;
    });
  }

  late final _$endXAtom = Atom(name: 'AppStateBase.endX', context: context);

  @override
  double get endX {
    _$endXAtom.reportRead();
    return super.endX;
  }

  @override
  set endX(double value) {
    _$endXAtom.reportWrite(value, super.endX, () {
      super.endX = value;
    });
  }

  late final _$endYAtom = Atom(name: 'AppStateBase.endY', context: context);

  @override
  double get endY {
    _$endYAtom.reportRead();
    return super.endY;
  }

  @override
  set endY(double value) {
    _$endYAtom.reportWrite(value, super.endY, () {
      super.endY = value;
    });
  }

  late final _$floodFillIsBeingComputedAtom =
      Atom(name: 'AppStateBase.floodFillIsBeingComputed', context: context);

  @override
  bool get floodFillIsBeingComputed {
    _$floodFillIsBeingComputedAtom.reportRead();
    return super.floodFillIsBeingComputed;
  }

  @override
  set floodFillIsBeingComputed(bool value) {
    _$floodFillIsBeingComputedAtom
        .reportWrite(value, super.floodFillIsBeingComputed, () {
      super.floodFillIsBeingComputed = value;
    });
  }

  late final _$imageAtom = Atom(name: 'AppStateBase.image', context: context);

  @override
  ui.Image? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(ui.Image? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$computeFloodFillAsyncAction =
      AsyncAction('AppStateBase.computeFloodFill', context: context);

  @override
  Future<void> computeFloodFill() {
    return _$computeFloodFillAsyncAction.run(() => super.computeFloodFill());
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
  void setX(double x) {
    final _$actionInfo =
        _$AppStateBaseActionController.startAction(name: 'AppStateBase.setX');
    try {
      return super.setX(x);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setY(double y) {
    final _$actionInfo =
        _$AppStateBaseActionController.startAction(name: 'AppStateBase.setY');
    try {
      return super.setY(y);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndX(double x) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.setEndX');
    try {
      return super.setEndX(x);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndY(double y) {
    final _$actionInfo = _$AppStateBaseActionController.startAction(
        name: 'AppStateBase.setEndY');
    try {
      return super.setEndY(y);
    } finally {
      _$AppStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
l1: ${l1},
l2: ${l2},
x: ${x},
y: ${y},
endX: ${endX},
endY: ${endY},
floodFillIsBeingComputed: ${floodFillIsBeingComputed},
image: ${image}
    ''';
  }
}
