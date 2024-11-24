import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:app_database/app_database.dart';

@immutable
class ApiaryWithHives extends Equatable {
  final Apiary apiary;
  final List<Hive> hives;

  const ApiaryWithHives({
    required this.apiary,
    this.hives = const [],
  });

  ApiaryWithHives copyWith({
    Apiary? apiary,
    List<Hive>? hives,
  }) {
    return ApiaryWithHives(
      apiary: apiary ?? this.apiary,
      hives: hives ?? this.hives,
    );
  }

  @override
  List<Object?> get props => [apiary, hives];
}
