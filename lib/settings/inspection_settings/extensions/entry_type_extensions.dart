import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:repositories/repositories.dart';

extension EntryTypeExtensions on EntryType {
  Icon get icon {
    switch (this) {
      case EntryType.slider0to5:
      case EntryType.slider0to3:
      case EntryType.slider0to7:
      case EntryType.slider0to11:
        return const Icon(Icons.linear_scale);
      case EntryType.text:
        return const Icon(Icons.text_fields);
      case EntryType.number:
        return const Icon(Icons.looks_one);
      case EntryType.checkbox:
        return const Icon(Icons.check_box);
      case EntryType.decimal:
        return const Icon(Icons.looks_two);
      case EntryType.intNeg:
        return const Icon(Icons.exposure_neg_1);
      case EntryType.decNeg:
        return const Icon(Icons.exposure_neg_2);
      case EntryType.toggle:
        return const Icon(Icons.toggle_on);
      default:
        return const Icon(Icons.help_outline);
    }
  }

  String get description {
    switch (this) {
      case EntryType.slider0to5:
        return 'slider_0_5'.tr();
      case EntryType.slider0to3:
        return 'slider_0_3'.tr();
      case EntryType.slider0to7:
        return 'slider_0_7'.tr();
      case EntryType.slider0to11:
        return 'slider_0_11'.tr();
      case EntryType.text:
        return 'text_input'.tr();
      case EntryType.number:
        return 'number_input'.tr();
      case EntryType.checkbox:
        return 'checkbox_input'.tr();
      case EntryType.decimal:
        return 'decimal_input'.tr();
      case EntryType.intNeg:
        return 'integer_neg_input'.tr();
      case EntryType.decNeg:
        return 'decimal_neg_input'.tr();
      case EntryType.toggle:
        return 'toggle_switch'.tr();
      default:
        return 'unknown_type'.tr();
    }
  }
}