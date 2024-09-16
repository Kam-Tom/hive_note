import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ApiaryWithHives extends Equatable {
  final Apiary apiary;
  final List<HiveWithQueen> hives;

  ApiaryWithHives({
    required this.apiary,
    required this.hives,
  });

  @override
  List<Object?> get props => [apiary, hives];
}

