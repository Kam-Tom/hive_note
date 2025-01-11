import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_note/finances/bloc/finances_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repositories/repositories.dart';

class MockRaportRepository extends Mock implements RaportRepository {}
class MockEntryMetadataRepository extends Mock implements EntryMetadataRepository {}

void main() {
  late MockRaportRepository raportRepository;
  late MockEntryMetadataRepository entryMetadataRepository;
  late FinancesBloc financesBloc;

  setUpAll(() {
    registerFallbackValue(Raport(
      id: 'test',
      raportType: RaportType.finances,
      createdAt: DateTime.now()
    ));
  });

  setUp(() {
    raportRepository = MockRaportRepository();
    entryMetadataRepository = MockEntryMetadataRepository();
    
    financesBloc = FinancesBloc(
      raportRepository: raportRepository,
      entryMetadataRepository: entryMetadataRepository,
    );
  });

  tearDown(() {
    financesBloc.close();
  });

  group('FinancesBloc', () {
    final testEntryMetadata = EntryMetadata(
      id: 'transaction_note',
      raportType: RaportType.finances,
      label: 'Transaction Note',
      hint: 'Note for the transaction',
      valueType: EntryType.text,
      order: 0,
    );

    blocTest<FinancesBloc, FinancesState>(
      'should emit [loading, success] when LoadData event is added',
      build: () {
        when(() => raportRepository.getFinanceItems())
            .thenAnswer((_) async => {});
        when(() => entryMetadataRepository.getEntryMetadatas(RaportType.finances))
            .thenAnswer((_) async => [testEntryMetadata]);
        return financesBloc;
      },
      act: (bloc) => bloc.add(const LoadData()),
      expect: () => [
        isA<FinancesState>().having((s) => s.status, 'status', Status.loading),
        isA<FinancesState>()
            .having((s) => s.status, 'status', Status.success)
            .having((s) => s.entries.length, 'entries length', 1),
      ],
    );

    blocTest<FinancesBloc, FinancesState>(
      'should update transaction type when SelectTransactionType event is added',
      build: () => financesBloc,
      act: (bloc) => bloc.add(const SelectTransactionType('Sell')),
      expect: () => [
        isA<FinancesState>().having((s) => s.transactionType, 'transaction type', 'Sell'),
      ],
    );

    blocTest<FinancesBloc, FinancesState>(
      'should update amount when UpdateAmount event is added',
      build: () => financesBloc,
      act: (bloc) => bloc.add(const UpdateAmount(100)),
      expect: () => [
        isA<FinancesState>().having((s) => s.amount, 'amount', 100),
      ],
    );

    blocTest<FinancesBloc, FinancesState>(
      'should update cost when UpdateCost event is added',
      build: () => financesBloc,
      act: (bloc) => bloc.add(const UpdateCost(50)),
      expect: () => [
        isA<FinancesState>().having((s) => s.cost, 'cost', 50),
      ],
    );

    blocTest<FinancesBloc, FinancesState>(
      'should toggle cost type when ToggleCostType event is added',
      build: () => financesBloc,
      seed: () => const FinancesState(isPerUnit: false),
      act: (bloc) => bloc.add(const ToggleCostType()),
      expect: () => [
        isA<FinancesState>().having((s) => s.isPerUnit, 'is per unit', true),
      ],
    );

    blocTest<FinancesBloc, FinancesState>(
      'should create a transaction when CreateTransaction event is added',
      build: () {
        when(() => raportRepository.insertRaport(any(), any()))
            .thenAnswer((_) async {});
        return financesBloc;
      },
      seed: () => const FinancesState(
        transactionType: 'Buy',
        amount: 10,
        cost: 5,
        isPerUnit: false,
      ),
      act: (bloc) => bloc.add(const CreateTransaction(entries: {'transaction_note': 'Test Note'})),
      verify: (_) {
        verify(() => raportRepository.insertRaport(any(), any())).called(1);
      },
    );
  });
}
