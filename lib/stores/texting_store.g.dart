// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextingStore on TextingBase, Store {
  late final _$savedTextAtom =
      Atom(name: 'TextingBase.savedText', context: context);

  @override
  String get savedText {
    _$savedTextAtom.reportRead();
    return super.savedText;
  }

  @override
  set savedText(String value) {
    _$savedTextAtom.reportWrite(value, super.savedText, () {
      super.savedText = value;
    });
  }

  late final _$TextingBaseActionController =
      ActionController(name: 'TextingBase', context: context);

  @override
  void saveText(String text) {
    final _$actionInfo =
        _$TextingBaseActionController.startAction(name: 'TextingBase.saveText');
    try {
      return super.saveText(text);
    } finally {
      _$TextingBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
savedText: ${savedText}
    ''';
  }
}
