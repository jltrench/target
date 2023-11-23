import 'package:mobx/mobx.dart';

part 'texting_store.g.dart';

class TextingStore = TextingBase with _$TextingStore;

abstract class TextingBase with Store {
  @observable
  String savedText = '';

  @action
  void saveText(String text) {
    savedText = text;
  }
}
