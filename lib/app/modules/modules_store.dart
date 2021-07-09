import 'package:mobx/mobx.dart';

part 'modules_store.g.dart';

class ModulesStore = _ModulesStoreBase with _$ModulesStore;
abstract class _ModulesStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}