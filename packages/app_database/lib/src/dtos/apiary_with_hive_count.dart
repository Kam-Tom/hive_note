import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ApiaryWithHiveCount extends Equatable {
  final Apiary apiary;
  final int hiveCount;

  const ApiaryWithHiveCount({
    required this.apiary,
    required this.hiveCount,
  });

  @override
  List<Object?> get props => [apiary, hiveCount];

  ApiaryWithHiveCount copyWith({
      Apiary? apiary,
      int? hiveCount,
    }) {
      return ApiaryWithHiveCount(
        apiary: apiary ?? this.apiary,
        hiveCount: hiveCount ?? this.hiveCount,
      );
    }
}