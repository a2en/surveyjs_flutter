import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surveyjs_projile/model/survey_js_form.dart';
import 'package:surveyjs_projile/ui/screens/form/form_controller.dart';

class SurveyEngine extends StatelessWidget {

  SurveyEngine({super.key});

  final FormController formController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return generateFormWidget();
  }

  Widget generateFormWidget() {
    return Form(
      key: _formKey,
      child: ListView(children: [
        ...formController.surveyJsForm.pages!.map((pages) {
          return GetBuilder(
            init: formController,
            builder: (controller) {
              return Column(
                children: [
                  buildVerticalSpacing(),
                  buildTitle(pages),
                  buildVerticalSpacing(),
                  ...pages.elements!.map((elements) {
                    return Column(
                      children: [
                        buildElement(elements),
                      ],
                    );
                  }).toList(),
                  buildVerticalSpacing(),
                  buildSubmitButton(),
                  buildVerticalSpacing(),
                ],
              );
            }
          );
        }).toList()
      ]),
    );
  }

  SizedBox buildVerticalSpacing() {
    return const SizedBox(
      height: 20,
    );
  }

  Text buildTitle(Pages pages) => Text(pages.title ?? "", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  buildElement(Elements element) {
    switch (element.type) {
      case "text":
        return buildText(element);
      case "radiogroup":
        return buildRadioGroup(element);
      case "checkbox":
        return buildCheckBox(element);
      case "dropdown":
        return buildDropDown(element);
      default:
        return Container();
    }
  }

  buildText(Elements element) {
    return Visibility(
      visible: isElementVisible(element),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildVerticalSpacing(),
              buildQuestion(element),
              buildVerticalSpacing(),
              buildTextField(element),
              buildVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }

  buildQuestion(Elements element) {
    return Text(element.title ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  buildTextField(Elements element) {
    return TextFormField(
      onChanged: (value) {
        element.textValue = value;
      },
      initialValue: element.textValue,
      validator: (value) {
        if ((element.isRequired==true)&&(value == null || value.isEmpty)) {
          return 'Response required.';
        }
        if(element.inputType=="number" && value!=null && value.isNotEmpty){
          if(int.tryParse(value)==null){
            return 'Please enter a valid number.';
          }
        }
        if(element.inputType=="email" && value!=null && value.isNotEmpty){
          if(GetUtils.isEmail(value)==false){
            return 'Please enter a valid email.';
          }
        }
        return null;
      },
      inputFormatters: [if(element.inputType=="number") FilteringTextInputFormatter.digitsOnly],
      keyboardType: element.inputType=="number"?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: element.title ?? "",
      ),
    );
  }

  buildRadioGroup(Elements element) {
    return Visibility(
      visible: isElementVisible(element),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildErrorElement(element),
              buildVerticalSpacing(),
              buildQuestion(element),
              buildVerticalSpacing(),
              ...element.choices!.map((choice) {
                return Column(
                  children: [
                    buildRadio(choice, element),
                    buildVerticalSpacing(),
                  ],
                );
              }).toList(),
              buildVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }

  buildRadio(Choices choice, Elements element) {
    return Row(
      children: [
        Radio(
          value: choice.value,
          groupValue: element.radioValue,
          onChanged: (value) {
            element.radioValue = value;
            formController.clearElementsDependentOn(element);
            formController.update();
          },
        ),
        Text(choice.text ?? "")
      ],
    );
  }

  buildCheckBox(Elements element) {
    return Visibility(
      visible: isElementVisible(element),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildErrorElement(element),
              buildVerticalSpacing(),
              buildQuestion(element),
              buildVerticalSpacing(),
              ...element.choices!.map((choice) {
                return Column(
                  children: [
                    buildCheckBoxWidget(choice, element),
                    buildVerticalSpacing(),
                  ],
                );
              }).toList(),
              buildVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }

  buildCheckBoxWidget(Choices choice, Elements element) {
    return Row(
      children: [
        Checkbox(
          value: element.checkboxValue.contains(choice.value)==true,
          onChanged: (value) {
            if (value ==true) {
              element.checkboxValue.add(choice.value??"");
            } else {
              element.checkboxValue.remove(choice.value);
            }
            formController.update();
          },
        ),
        Text(choice.text ?? "")
      ],
    );
  }

  buildDropDown(Elements element) {
    return Visibility(
      visible: isElementVisible(element),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildErrorElement(element),
              buildVerticalSpacing(),
              buildQuestion(element),
              buildVerticalSpacing(),
              buildDropDownWidget(element),
              buildVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }

  buildDropDownWidget(Elements element) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: element.title ?? "",
      ),
      value: element.dropdownValue,
      items: element.choices!.map((choice) {
        return DropdownMenuItem(
          value: choice.value,
          child: Text(choice.text ?? ""),
        );
      }).toList(),
      onChanged: (value) {
        element.dropdownValue = value;
        formController.update();
      },
    );
  }

  bool isElementVisible(Elements elements) {
    if(elements.visibleIf==null){
      return true;
    }
    var visibilityValues = elements.visibleIf?.split("=")??[];
    if(visibilityValues.length!=2){
      return true;
    }
    var key = visibilityValues[0].removeAllWhitespace.replaceAll("{", "").replaceAll("}", "");
    var value = visibilityValues[1].removeAllWhitespace.replaceAll("'", "").replaceAll("'", "");

    var pageToCheck = formController
        .surveyJsForm.pages!
        .firstWhere((page) {
          return page.elements!.any((element) => element.name == key);
        }, orElse: () => Pages());
    if(pageToCheck.name==null){
      return true;
    }

    var elementToCheck = pageToCheck.elements!.firstWhere((element) => element.name == key, orElse: () => Elements());
    if(elementToCheck.name==null){
      return true;
    }

    if(elementToCheck.type=="radiogroup"){
      if(elementToCheck.radioValue==value){
        return true;
      }
    } else if(elementToCheck.type=="checkbox"){
      if(elementToCheck.checkboxValue.contains(value)==true){
        return true;
      }
    } else if(elementToCheck.type=="dropdown"){
      if(elementToCheck.dropdownValue==value){
        return true;
      }
    } else if(elementToCheck.type=="text"){
      if(elementToCheck.textValue==value){
        return true;
      }
    }

    return false;

  }

  buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()&&isFormValid()) {
              _formKey.currentState!.save();
              var response = formController.surveyJsForm.getValuesAsJson();
              formController.submitForm(response);
            }
            formController.update();
          },
          child: const Text("Submit"),
        ),
      ),
    );
  }

  bool isFormValid() {
    var isValid = true;
    for (var page in formController.surveyJsForm.pages!) {
      for (var element in page.elements!) {
        if(element.isRequired==true){
          if(element.type=="radiogroup"){
            if(element.radioValue==null){
              element.isRequiredErrorText = "Response required.";
              isValid = false;
            }else{
              element.isRequiredErrorText = null;
            }
          } else if(element.type=="checkbox"){
            if(element.checkboxValue.isEmpty){
              element.isRequiredErrorText = "Response required.";
              isValid = false;
            }else{
              element.isRequiredErrorText = null;
            }
          } else if(element.type=="dropdown"){
            if(element.dropdownValue==null){
              element.isRequiredErrorText = "Response required.";
              isValid = false;
            }else{
              element.isRequiredErrorText = null;
            }
          } else if(element.type=="text"){
            if(element.textValue==null || element.textValue!.isEmpty){
              isValid = false;
            }else{
              element.isRequiredErrorText = null;
            }
          }
        }
      }
    }
    return isValid;
  }

  buildErrorElement(Elements element) {
    return Visibility(
      visible: element.isRequiredErrorText!=null,
      child: Container(
        color: Colors.red.withOpacity(0.2),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Text(element.isRequiredErrorText??"", style: const TextStyle(color: Colors.red),),
      ),
    );
  }
}

