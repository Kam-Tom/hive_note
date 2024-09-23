import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/bloc/apiary_dropdown_bloc.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/presentation/apiary_dropdown_view.dart';
import 'package:repositories/repositories.dart';

class ApiaryDropdown extends StatelessWidget {
  const ApiaryDropdown({required this.onSelected, super.key});

  final void Function(Apiary? apiary) onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ApiaryDropdownBloc(
      apiaryRepository: context.read<ApiaryRepository>(),
    )..add(const Subscribe()),
    child: ApiaryDropdownView(onSelected: onSelected),
    );
  }
}