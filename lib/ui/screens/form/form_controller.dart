import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyjs_projile/model/form_model.dart';
import 'package:surveyjs_projile/model/survey_js_form.dart';
import 'package:surveyjs_projile/utils/survey_engine.dart';
import 'package:surveyjs_projile/utils/x_controller.dart';

class FormController extends XController {
  FormModel formModel = Get.arguments as FormModel;
  late SurveyJSForm surveyJsForm;


  @override
  void onInit() {
    super.onInit();
    surveyJsForm = SurveyJSForm.fromJson(formModel.formJsonContent??{},formModel.formResponse??{});
  }

  void submitForm(response) {
    toggleLoading();
    if(formModel.docId!=null){
      fireStore.collection('form_responses').doc(formModel.docId).update({
        'response': response,
        'updated_at': DateTime.now(),
      }).then((value) {
        toggleLoading();
        Get.back();
      }).catchError((error) {
        toggleLoading();
        Get.snackbar('Error', error.toString());
      });
      return;
    }
    fireStore.collection('form_responses').add({
      'formId': formModel.formId,
      'formTitle': formModel.formName,
      'response': response,
      'created_at': DateTime.now(),
    }).then((value) {
      toggleLoading();
      Get.back();
    }).catchError((error) {
      toggleLoading();
      Get.snackbar('Error', error.toString());
    });

  }

  void clearElementsDependentOn(Elements elements) {
    surveyJsForm.pages?.forEach((page) {
      page.elements?.forEach((element) {
        if (element.type == "text"&&element.textValue!=elements.textValue) {
          element.textValue = null;
        } else if (element.type == "dropdown"&&element.dropdownValue!=elements.dropdownValue) {
          element.dropdownValue = null;
        } else if (element.type == "radiogroup" && element.radioValue != elements.radioValue) {
          element.radioValue = null;
        } else if (element.type == "checkbox" && element.checkboxValue != elements.checkboxValue) {
          element.checkboxValue = [];
        }
      });
    });
  }

}
