import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/finances/bloc/finances_bloc.dart';
import 'package:hive_note/finances/presentation/finances_view.dart';

class MockEntryFieldCubit extends Mock implements EntryFieldCubit {}
class MockFinancesBloc extends Mock implements FinancesBloc {}

void main() {
  late EntryFieldCubit entryFieldCubit;
  late FinancesBloc financesBloc;

  setUp(() {
    entryFieldCubit = MockEntryFieldCubit();
    financesBloc = MockFinancesBloc();
    when(() => entryFieldCubit.stream).thenAnswer((_) => Stream.value({}));
    when(() => entryFieldCubit.getValues()).thenReturn({});
    when(() => financesBloc.stream).thenAnswer((_) => Stream.value(FinancesState()));
    when(() => financesBloc.state).thenReturn(FinancesState());
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FinancesBloc>.value(value: financesBloc),
        BlocProvider<EntryFieldCubit>.value(value: entryFieldCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: FinancesView(),
        ),
      ),
    );
  }

  testWidgets('should render the FinancesView widget', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(FinancesView), findsOneWidget);
  });

  testWidgets('should display transaction type buttons', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Buy'), findsOneWidget);
    expect(find.text('Sell'), findsOneWidget);
  });

  testWidgets('should update the state when selecting transaction type', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text('Buy'));
    await tester.pumpAndSettle();
    verify(() => financesBloc.add(const SelectTransactionType('Buy'))).called(1);
  });

  testWidgets('should display amount and cost input fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('should update the state when entering amount', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byType(TextField).first, '100');
    verify(() => financesBloc.add(UpdateAmount(100))).called(1);
  });

  testWidgets('should update the state when entering cost', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(find.byType(TextField).last, '50');
    verify(() => financesBloc.add(UpdateCost(50))).called(1);
  });

}
