import 'package:get/get.dart';

class Binding<T> extends Bindings {

  final ItemCreator<T> creator;

  Binding(this.creator);

  @override
  void dependencies() {
    Get.lazyPut(() {
      T item = creator();
      return item;
    });
  }
}

typedef ItemCreator<S> = S Function();
