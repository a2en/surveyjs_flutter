import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyjs_projile/ui/screens/form/form_controller.dart';
import 'package:surveyjs_projile/utils/survey_engine.dart';


class FormScreen extends GetWidget<FormController> {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: GetBuilder(
        init: controller,
        id: 'loading',
        builder: (context) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SurveyEngine();
        }
      ),
    );
  }
}