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
    Widget input = _buildIntInput();
    if (data.type == 'bool') {
      input = _buildBoolInput();
    }
    if (data.type == 'String') {
      input = _buildTextInput();
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

  Widget _buildIntInput() {
    return TextField(
      //onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter a number',
      ),
    );
  }
  
  Widget _buildBoolInput() {
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
      const SizedBox(width: 50),
      ],
    );
  }

  Widget _buildTextInput() {
    return TextField(
      //onChanged: onChanged,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Enter text',
      ),
    );
  }
}