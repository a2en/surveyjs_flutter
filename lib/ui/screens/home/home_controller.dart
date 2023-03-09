import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyjs_projile/constants/app_constants.dart';
import 'package:surveyjs_projile/model/form_model.dart';
import 'package:surveyjs_projile/utils/x_controller.dart';

class HomeController extends XController {
  Iterable<String> forms = [];
  var documents = <FormModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssets();
    getFormResponses();
  }

  void handleForm() {
    // Dialog to select form
    Get.defaultDialog(
      title: "Select Form",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Add forms to assets/forms folder",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          ...forms.map((filePath) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                onPressed: () {
                  goToForm(filePath);
                },
                child: Text(filePath.split("/").last.split(".").first)),
              ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void getAssets() async {
    final manifestJson = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');
    forms = json.decode(manifestJson).keys.where((String key) => key.startsWith('assets/forms'));
  }

  void goToForm(String filePath) async {
    Get.back();
    String data = await DefaultAssetBundle.of(Get.context!).loadString(filePath);
    Get.toNamed(RoutePaths.form, arguments: FormModel.fromJson(data, filePath));
  }

  void goToFormFormModel(FormModel form) async {
    Get.back();
    Get.toNamed(RoutePaths.form, arguments: form);
  }

  void getFormResponses() async{
    fireStore.collection('form_responses').snapshots().listen((event) async {
      documents.clear();
      var forms = event.docs.map((e) => FormModel.fromMap(e.data(),e.id)).toList();
      for (var element in forms) {
        var model = await element;
        documents.add(model as FormModel);
      }
    });
  }
}
