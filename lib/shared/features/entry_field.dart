import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';

class EntryFieldCubit extends Cubit<Map<String, String?>> {
  EntryFieldCubit() : super({'_source': 'user'});

  void updateValue(String key, String? value) {
    final newState = Map<String, String?>.from(state);
    newState['_source'] = 'user';
    newState[key] = value;
    emit(newState);
  }
  void setDefaultValues(Map<String, String?> defaultValues) {
    final newState = Map<String, String?>.from(defaultValues);
    newState['_source'] = 'external';
    emit(newState);
  }
  Map<String, String?> getValues() {
    final newState = Map<String, String?>.from(state);
    newState.remove('_source');
    return newState;
  }

  void clear() {
    final newState = Map<String, String?>.from(state);
    for(final state in newState.keys) {
      newState[state] = null;
    }
    newState['_source'] = 'external';
    emit(newState);
  }
}

class EntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const EntryField({super.key, required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
      
      return EntryFieldView(
        entryMetadata: entryMetadata,
        value: value,
      );
    
  }
}

class EntryFieldView extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const EntryFieldView({
    super.key,
    required this.entryMetadata,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryFieldCubit, Map<String, String?>>(
      buildWhen: (previous, current) {
        return current['_source'] == 'external' || (previous[entryMetadata.id] != current[entryMetadata.id] 
        && entryMetadata.valueType != EntryType.decNeg &&
        entryMetadata.valueType != EntryType.decimal &&
        entryMetadata.valueType != EntryType.intNeg && 
        entryMetadata.valueType != EntryType.number && 
        entryMetadata.valueType != EntryType.text);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _createEntryInput(entryMetadata, state[entryMetadata.id], context),
        );
      },
    );
  }

  Widget _createEntryInput(EntryMetadata entryMetadata, String? value, BuildContext context) {
    final cubit = context.read<EntryFieldCubit>();
    switch (entryMetadata.valueType) {
      case EntryType.slider0to3:
        return _SliderEntryField(entryMetadata: entryMetadata, min: 1, max: 3, divisions: 2, value: value);
      case EntryType.slider0to5:
        return _SliderEntryField(entryMetadata: entryMetadata, min: 1, max: 5, divisions: 4, value: value);
      case EntryType.slider0to7:
        return _SliderEntryField(entryMetadata: entryMetadata, min: 1, max: 7, divisions: 6, value: value);
      case EntryType.slider0to11:
        return _SliderEntryField(entryMetadata: entryMetadata, min: 1, max: 11, divisions: 10, value: value);
      case EntryType.checkbox:
        return _CheckboxEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.text:
        return _TextEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.number:
        return _NumberEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.decimal:
        return _DecimalEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.intNeg:
        return _IntNegEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.decNeg:
        return _DecNegEntryField(entryMetadata: entryMetadata, value: value);
      case EntryType.toggle:
        return _ToggleEntryField(entryMetadata: entryMetadata, value: value);
      default:
        return const Text('Unsupported EntryType');
    }
  }
}

class _SliderEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final double min;
  final double max;
  final int divisions;
  final String? value;

  const _SliderEntryField({
    required this.entryMetadata,
    required this.min,
    required this.max,
    required this.divisions,
    this.value,
  });

  List<String> _getLabels() {
    if (min == 1 && max == 3) {
      return ['Bad', 'Normal', 'Good'];
    } else if (min == 1 && max == 5) {
      return ['Very Bad', 'Bad', 'Average', 'Good', 'Very Good'];
    } else if (min == 1 && max == 7) {
      return ['Very Bad', 'Bad', 'Below Average', 'Average', 'Above Average', 'Good', 'Very Good'];
    } else if (min == 1 && max == 11) {
      return ['Very Bad', 'Bad', 'Poor', 'Below Average', 'Average', 'Above Average', 'Good', 'Very Good', 'Excellent', 'Outstanding', 'Perfect'];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = _getLabels();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        Slider(
          value: value != null ? double.parse(value!) : min,
          min: min,
          max: max,
          divisions: divisions,
          label: labels.isNotEmpty ? labels[(value != null ? double.parse(value!) : min).toInt() - 1] : null,
          onChanged: (newValue) {
            context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue.toString());
          },
        ),
      ],
    );
  }
}

class _CheckboxEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _CheckboxEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Checkbox(
              value: value != null ? value!.toLowerCase() == 'true' : false,
              onChanged: (newValue) {
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue.toString());
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _TextEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _TextEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        TextField(
          decoration: InputDecoration(
            hintText: entryMetadata.hint.tr(),
          ),
          controller: controller,
          onChanged: (newValue) {
            context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
          },
        ),
      ],
    );
  }
}

class _NumberEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _NumberEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        Row(
          children: [
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.remove),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                controller.text = (currentValue - 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                controller.text = (currentValue + 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (newValue) {
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecimalEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _DecimalEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        Row(
          children: [
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.remove),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = double.tryParse(controller.text) ?? 0.0;
                controller.text = (currentValue - 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = double.tryParse(controller.text) ?? 0.0;
                controller.text = (currentValue + 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                onChanged: (newValue) {
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _IntNegEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _IntNegEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        Row(
          children: [
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.remove),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                controller.text = (currentValue - 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = int.tryParse(controller.text) ?? 0;
                controller.text = (currentValue + 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d+'))],
                onChanged: (newValue) {
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecNegEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _DecNegEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (entryMetadata.hint.isNotEmpty)
          Text(
            entryMetadata.hint.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        Row(
          children: [
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.remove),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = double.tryParse(controller.text) ?? 0.0;
                controller.text = (currentValue - 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                final currentValue = double.tryParse(controller.text) ?? 0.0;
                controller.text = (currentValue + 1).toString();
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
                controller: controller,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d+\.?\d*'))],
                onChanged: (newValue) {
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ToggleEntryField extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;

  const _ToggleEntryField({required this.entryMetadata, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entryMetadata.label.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Switch(
              value: value != null ? value!.toLowerCase() == 'true' : false,
              onChanged: (newValue) {
                context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue.toString());
              },
            ),
          ],
        )
      ],
    );
  }
}