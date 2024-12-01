
import 'package:flutter/material.dart';
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
        return 'Slider (0-5)';
      case EntryType.slider0to3:
        return 'Slider (0-3)';
      case EntryType.slider0to7:
        return 'Slider (0-7)';
      case EntryType.slider0to11:
        return 'Slider (0-11)';
      case EntryType.text:
        return 'Text Input';
      case EntryType.number:
        return 'Number Input';
      case EntryType.checkbox:
        return 'Checkbox';
      case EntryType.decimal:
        return 'Decimal Input';
      case EntryType.intNeg:
        return 'Integer Input (Negatives)';
      case EntryType.decNeg:
        return 'Decimal Input (Negatives)';
      case EntryType.toggle:
        return 'Toggle Switch';
      default:
        return 'Unknown Type';
    }
  }
}