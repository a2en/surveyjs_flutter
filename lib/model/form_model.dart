
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormModel {
  Map<String,dynamic>? formJsonContent;
  String? formName;
  Map<String,dynamic>? formResponse;
  String? formId;
  String? docId;

  FormModel({this.formJsonContent, this.formName, this.formResponse,this.formId,this.docId});

  FormModel.fromJson(String json, String filePath) {
    final jsonResult = jsonDecode(json);
    formJsonContent = jsonResult;
    formId = filePath;
    formName = jsonResult['pages'][0]['title'];
  }

  static fromMap(Map<String, dynamic> data, String docId) async{
    String response = await DefaultAssetBundle.of(Get.context!).loadString(data['formId']);
    return FormModel(
      formJsonContent: jsonDecode(response),
      formId: data['formId'],
      docId: docId,
      formName: data['formTitle'],
      formResponse: data['response'],
    );
  }
}