import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/finances/bloc/finances_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';

class FinancesView extends StatelessWidget {
  static const List<String> transactionTypes = ['Buy', 'Sell'];

  const FinancesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancesBloc, FinancesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Transaction type buttons
                Text('select_transaction_type'.tr(), 
                  style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TransactionButton(
                      label: 'Buy',
                      isSelected: state.transactionType == 'Buy',
                      color: Colors.blue,
                      onTap: () => context.read<FinancesBloc>()
                          .add(const SelectTransactionType('Buy')),
                    ),
                    const SizedBox(width: 16),
                    _TransactionButton(
                      label: 'Sell',
                      isSelected: state.transactionType == 'Sell',
                      color: Colors.green,
                      onTap: () => context.read<FinancesBloc>()
                          .add(const SelectTransactionType('Sell')),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'cost_per_unit'.tr(),
                      style: TextStyle(
                        color: state.transactionType == 'Buy' 
                          ? Colors.blue 
                          : Colors.green,
                      ),
                    ),
                    Switch(
                      value: state.isPerUnit,
                      onChanged: (_) => context.read<FinancesBloc>()
                          .add(const ToggleCostType()),
                      activeColor: state.transactionType == 'Buy' 
                        ? Colors.blue 
                        : Colors.green,
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),

                // Amount and cost inputs
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'amount'.tr(),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: state.transactionType == 'Buy' 
                                ? Colors.blue 
                                : Colors.green,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.shopping_basket),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => context.read<FinancesBloc>()
                            .add(UpdateAmount(double.tryParse(value) ?? 0)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: state.isPerUnit ? 'cost_per_unit'.tr() : 'total_cost'.tr(),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: state.transactionType == 'Buy' 
                                ? Colors.blue 
                                : Colors.green,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => context.read<FinancesBloc>()
                            .add(UpdateCost(double.tryParse(value) ?? 0)),
                      ),
                      if (state.amount > 0 && state.cost > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.isPerUnit
                              ? 'total_cost_label'.tr(args: [(state.amount * state.cost).toStringAsFixed(2)])
                              : 'cost_per_unit_label'.tr(args: [(state.cost / state.amount).toStringAsFixed(2)]),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: state.transactionType == 'Buy' 
                                ? Colors.blue 
                                : Colors.green,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Entry fields section
                Column(
                  children: [
                    ...state.entries.map((metadata) => Column(
                      children: [
                        EntryField(entryMetadata: metadata,
                          hints: state.hints[metadata.id],
                        ),
                        const Divider(),
                      ],
                    )).toList(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TransactionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TransactionButton({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? color.withOpacity(0.1) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
