import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class XController extends GetxController with Base {
  var isLoading = false;
  VoidCallback? onRefresh;
  var fireStore = FirebaseFirestore.instance;

  void toggleLoading() {
    isLoading = !isLoading;
    update(["loading"]);
  }



  Future<dynamic> navigateTo(String routeName,{dynamic arguments}) async {
    return Get.toNamed(routeName,arguments: arguments);
  }
}

abstract class Base {
  static Base init(Type cls) {
    switch (cls) {
      default:
        return XController();
    }
  }
}
