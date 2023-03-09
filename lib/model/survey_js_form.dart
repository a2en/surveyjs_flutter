class SurveyJSForm {
  List<Pages>? pages;

  SurveyJSForm({this.pages});

  SurveyJSForm.fromJson(Map<String, dynamic> json, Map<String, dynamic> response) {
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(Pages.fromJson(v));
      });
    }
    pages?.forEach((page) {
      page.elements?.forEach((element) {
        if (element.type == "text"&&response.containsKey(element.name)&&response[element.name!]!=null) {
          element.textValue = response[element.name!];
        } else if (element.type == "dropdown"&&response.containsKey(element.name)&&response[element.name!]!=null) {
          element.dropdownValue = response[element.name!];
        } else if (element.type == "radiogroup"&&response.containsKey(element.name)&&response[element.name!]!=null) {
          element.radioValue = response[element.name!];
        } else if (element.type == "checkbox"&&response.containsKey(element.name)&&response[element.name!]!=null) {
          element.checkboxValue = response[element.name!].cast<String>();
        }
      });
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  getValuesAsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    for (var page in pages??[]) {
      for (var element in page.elements??[]) {
        if (element.type == "text"&&element.textValue!=null) {
          data[element.name!] = element.textValue;
        } else if (element.type == "dropdown"&&element.dropdownValue!=null) {
          data[element.name!] = element.dropdownValue;
        } else if (element.type == "radiogroup"&&element.radioValue!=null) {
          data[element.name!] = element.radioValue;
        } else if (element.type == "checkbox"&&element.checkboxValue.isNotEmpty) {
          data[element.name!] = element.checkboxValue;
        }
      }
    }
    return data;
  }
}

class Pages {
  String? name;
  List<Elements>? elements;
  String? title;

  Pages({this.name, this.elements, this.title});

  Pages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Elements {
  String? type;
  String? name;
  String? title;
  bool? isRequired;
  String? inputType;
  List<Choices>? choices;
  String? textValue;
  String? dropdownValue;
  String? radioValue;
  String? isRequiredErrorText;
  List<String>  checkboxValue = [];
  String? visibleIf;

  Elements({this.type, this.name, this.title, this.isRequired, this.inputType, this.choices, this.visibleIf});

  Elements.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    title = json['title'];
    isRequired = json['isRequired'];
    inputType = json['inputType'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    visibleIf = json['visibleIf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['title'] = title;
    data['isRequired'] = isRequired;
    data['inputType'] = inputType;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    data['visibleIf'] = visibleIf;
    return data;
  }
}

class Choices {
  String? value;
  String? text;

  Choices({this.value, this.text});

  Choices.fromJson(dynamic json) {
    if (json is String) {
      value = json;
      text = json;
    } else {
      value = json['value'];
      text = json['text'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
