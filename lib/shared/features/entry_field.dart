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
  final List<String>? hints;

  const EntryField({super.key, required this.entryMetadata, this.value, this.hints});

  @override
  Widget build(BuildContext context) {
      
      return EntryFieldView(
        entryMetadata: entryMetadata,
        value: value,
        hints: hints,
      );
    
  }
}

class EntryFieldView extends StatelessWidget {
  final EntryMetadata entryMetadata;
  final String? value;
  final List<String>? hints;

  const EntryFieldView({
    super.key,
    required this.entryMetadata,
    this.value,
    this.hints,
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
        return _TextEntryField(entryMetadata: entryMetadata, value: value, hints: hints);
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
      return ['slider_bad', 'slider_normal', 'slider_good'].map((e) => e.tr()).toList();
    } else if (min == 1 && max == 5) {
      return ['slider_very_bad', 'slider_bad', 'slider_average', 'slider_good', 'slider_very_good'].map((e) => e.tr()).toList();
    } else if (min == 1 && max == 7) {
      return ['slider_very_bad', 'slider_bad', 'slider_below_average', 'slider_average', 'slider_above_average', 'slider_good', 'slider_very_good'].map((e) => e.tr()).toList();
    } else if (min == 1 && max == 11) {
      return ['slider_very_bad', 'slider_bad', 'slider_poor', 'slider_below_average', 'slider_average', 'slider_above_average', 'slider_good', 'slider_very_good', 'slider_excellent', 'slider_outstanding', 'slider_perfect'].map((e) => e.tr()).toList();
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  entryMetadata.hint.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
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
  final List<String>? hints;

  const _TextEntryField({required this.entryMetadata, this.value, this.hints});

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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        if (hints != null && hints!.isNotEmpty)
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return hints!.where((String option) {
                return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              controller.text = selection;
              context.read<EntryFieldCubit>().updateValue(entryMetadata.id, selection);
            },
            fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
              textEditingController.text = controller.text;
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
                ),
                onChanged: (newValue) {
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, newValue);
                },
              );
            },
          )
        else
          TextField(
            decoration: InputDecoration(
              hintText: entryMetadata.hint.tr(),
              hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
                if (currentValue > 0) {  // Only decrement if result would be non-negative
                  controller.text = (currentValue - 1).toString();
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
                }
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
                style: Theme.of(context).textTheme.bodyMedium,  // Add this line
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
                ),
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'^0+(?=\d)')), // Prevent leading zeros
                ],
                onChanged: (newValue) {
                  if (newValue.isEmpty) newValue = '0';
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
                if (currentValue > 0) {  // Only decrement if result would be non-negative
                  controller.text = (currentValue - 1).toString();
                  context.read<EntryFieldCubit>().updateValue(entryMetadata.id, controller.text);
                }
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
                style: Theme.of(context).textTheme.bodyMedium,  // Add this line
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
                ),
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  FilteringTextInputFormatter.deny(RegExp(r'^0+(?=\d)')), // Prevent leading zeros
                ],
                onChanged: (newValue) {
                  if (newValue.isEmpty) newValue = '0';
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
                style: Theme.of(context).textTheme.bodyMedium,  // Add this line
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              entryMetadata.hint.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
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
                style: Theme.of(context).textTheme.bodyMedium,  // Add this line
                decoration: InputDecoration(
                  hintText: entryMetadata.hint.tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,  // Add this line to make hint text smaller
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                entryMetadata.hint.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
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