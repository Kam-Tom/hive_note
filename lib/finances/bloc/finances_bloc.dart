import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'finances_event.dart';
part 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  final RaportRepository _raportRepository;
  final EntryMetadataRepository _entryMetadataRepository;

  FinancesBloc({
    required RaportRepository raportRepository,
    required EntryMetadataRepository entryMetadataRepository,
  }) : _raportRepository = raportRepository,
       _entryMetadataRepository = entryMetadataRepository,
       super(const FinancesState()) {
    
    on<LoadData>(_onLoadData);
    on<SelectTransactionType>(_onSelectTransactionType);
    on<UpdateAmount>(_onUpdateAmount);
    on<UpdateCost>(_onUpdateCost);
    on<CreateTransaction>(_onCreateTransaction);
    on<ToggleCostType>(_onToggleCostType);
  }

  Future<void> _onLoadData(LoadData event, Emitter<FinancesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final hints = await _raportRepository.getFinanceItems();
      final allEntries = await _entryMetadataRepository.getEntryMetadatas(RaportType.finances);
      final entries = allEntries.where((entry) => entry.id=="transaction_note" || entry.id=="transaction_item").toList();
      
      emit(state.copyWith(
        entries: entries,
        hints: hints,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onSelectTransactionType(SelectTransactionType event, Emitter<FinancesState> emit) {
    emit(state.copyWith(transactionType: event.transactionType));
  }

  void _onUpdateAmount(UpdateAmount event, Emitter<FinancesState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onUpdateCost(UpdateCost event, Emitter<FinancesState> emit) {
    emit(state.copyWith(cost: event.cost));
  }

  Future<void> _onCreateTransaction(CreateTransaction event, Emitter<FinancesState> emit) async {
    try {
      final raport = Raport(
        raportType: RaportType.finances,
        createdAt: DateTime.now(),
      );

      final List<Entry> entries = [];
      entries.add(Entry(
        entryMetadataId: 'transaction_note',
        raportId: raport.id,
        value: event.entries['transaction_note'] ?? '',
      ));
      entries.add(Entry(
        entryMetadataId: 'transaction_item',
        raportId: raport.id,
        value: event.entries['transaction_item'] ?? 'item',
      ));
      final cost = !state.isPerUnit ? state.cost : state.cost * state.amount;
      entries.addAll([
        Entry(
          entryMetadataId: 'transaction_type',
          raportId: raport.id,
          value: state.transactionType,
        ),
        Entry(
          entryMetadataId: 'transaction_amount',
          raportId: raport.id,
          value: state.amount.toString(),
        ),
        Entry(
          entryMetadataId: 'transaction_cost',
          raportId: raport.id,
          value: cost.toString(),
        ),
      ]);

      await _raportRepository.insertRaport(raport, entries);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: 'Failed to create transaction',
      ));
    }
  }

  void _onToggleCostType(ToggleCostType event, Emitter<FinancesState> emit) {
    emit(state.copyWith(isPerUnit: !state.isPerUnit));
  }
}
