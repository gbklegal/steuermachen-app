import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/quick_tax_wrapper.dart';

class QuickTaxProvider extends ChangeNotifier {
  bool _busyStateQuickTax = true;
  bool get getBusyStateQuickTax => _busyStateQuickTax;
  set setBusyStateQuickTax(bool _isBusy) {
    _busyStateQuickTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getQuickTaxViewData() async {
    try {
      setBusyStateQuickTax = true;
      var res = await firestore.collection("quick_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      QuickTaxWrapper quickTaxWrapper = QuickTaxWrapper.fromJson(x);
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(status: true, data: quickTaxWrapper);
    } catch (e) {
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore 
  // JSON//filepath: quick_tax_view.json
  Future<CommonResponseWrapper> addQuickTaxViewData() async {
    try {
      await firestore.collection("quick_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "Quick tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }
}

var json ={
  "en": [
    {
      "title": "Select your annual gross income (approx.)",
      "option_type": "single_select",
      "options": [
        {
          "name": "up to 9,000 euros",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "10.000 Euro - 14.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "15.000 Euro - 34.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "35.000 Euro - 54.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "55.000 Euro - 69.000 Euro",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "over 70,000 euros",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Choose your tax class",
      "option_type": "single_select",
      "options": [
        {
          "name": "Tax class 1",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Tax class 2",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Tax class 3",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "Tax class 4",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Tax class 5",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "Tax class 6",
          "point": 1,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Enter your commute in km (one way)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Have you had one or more professional training courses?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Yes",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "No",
          "point": 0,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Choose the number of your children",
      "option_type": "single_select",
      "options": [
        {
          "name": "1",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "2",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "3",
          "point": 3,
          "decision": "next"
        },
        {
          "name": "4",
          "point": 3,
          "decision": "next"
        },
        {
          "name": "5",
          "point": 3,
          "decision": "next"
        },
        {
          "name": "5 oder mehr",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Are you married?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Yes",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "No",
          "point": 0,
          "decision": "complete"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Select the annual gross income of your partner (approx.)",
      "option_type": "single_select",
      "options": [
        {
          "name": "up to 9,000 euros",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "10.000 Euro - 14.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "15.000 Euro - 34.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "35.000 Euro - 54.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "55.000 Euro - 69.000 Euro",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "over 70,000 euros",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "What tax bracket is your partner in?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Tax class 3",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Tax class 4",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Tax class 5",
          "point": 0,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Enter your partner's commute to work in km (one way)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Did your partner have one or more vocational training courses?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Yes",
          "point": 1,
          "decision": "complete"
        },
        {
          "name": "No",
          "point": 0,
          "decision": "complete"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    }
  ],
  "du": [
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        {
          "name": "bis 9.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "10.000 Euro - 14.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "15.000 Euro - 34.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "35.000 Euro - 54.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "55.000 Euro - 69.000 Euro",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "über 70.000 Euro",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Wähle deine Steuerklasse aus",
      "option_type": "single_select",
      "options": [
        {
          "name": "Steuerklasse 1",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 2",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 3",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 4",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 5",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 6",
          "point": 1,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Gib deinen Arbeitsweg in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hattest du eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Ja",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Nein",
          "point": 0,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Wie viele Weiterbildungen hattest du?",
      "option_type": "single_select",
      "options": [
        {
          "name": "1",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "2",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "3",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "4",
          "point": 3,
          "decision": "next"
        },
        {
          "name": "5",
          "point": 3,
          "decision": "next"
        },
        {
          "name": "5 oder mehr",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Bist du bereits verheiratet?aus",
      "option_type": "single_select",
      "options": [
        {
          "name": "Ja",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "Nein",
          "point": 0,
          "decision": "complete"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        {
          "name": "bis 9.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "10.000 Euro - 14.000 Euro",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "15.000 Euro - 34.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "35.000 Euro - 54.000 Euro",
          "point": 1,
          "decision": "next"
        },
        {
          "name": "55.000 Euro - 69.000 Euro",
          "point": 2,
          "decision": "next"
        },
        {
          "name": "über 70.000 Euro",
          "point": 3,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "In welcher Steuerklasse ist dein Partner?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Steuerklasse 3",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 4",
          "point": 0,
          "decision": "next"
        },
        {
          "name": "Steuerklasse 5",
          "point": 0,
          "decision": "next"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    },
    {
      "title": "Gib den Arbeitsweg deines Partners in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hatte dein Partner eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        {
          "name": "Ja",
          "point": 1,
          "decision": "complete"
        },
        {
          "name": "Nein",
          "point": 0,
          "decision": "complete"
        }
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": true
    }
  ]
};