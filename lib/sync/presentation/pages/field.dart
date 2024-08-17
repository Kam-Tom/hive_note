import 'package:flutter/material.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/sync/models/entrie_type.dart';

class Field extends StatelessWidget {
  final EntrieType data;
  final void Function(bool) onChanged;
  final bool value;
  
  const Field({super.key, required this.data, required this.onChanged, required this.value});  

  @override
  Widget build(BuildContext context) {
    Widget input = _bulidIntInput();
    if (data.type == 'bool') {
      input = _bulidBoolInput();
    }
    if (data.type == 'String') {
      input = _bulidTextInput();
    }

    return  Column(
      children: [
        Row(
        children: [
          
          Container(
            color: AppColors.divider,
            height: 2,
            width: 25,
          ),
          Text(data.name,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          Expanded(
            child: Container(
              color: AppColors.divider,
              height: 2,
            ),
          ),
        ],
      ),
      input,
      ]
    );
  }

  Widget _bulidIntInput() {
    return TextField(
      //onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter a number',
      ),
    );
  }
  
  Widget _bulidBoolInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Text(data.hint
      , style: const TextStyle(
        color: AppColors.text,
        fontSize: 16,
        fontWeight: FontWeight.normal
      ),
      ),
      Switch(
        onChanged: onChanged,
        value: value,),
      SizedBox(width: 50,),
      ],
    );
  }

  Widget _bulidTextInput() {
    return TextField(
      //onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter a number',
      ),
    );
  }
}