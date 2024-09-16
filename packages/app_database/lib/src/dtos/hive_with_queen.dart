import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class HiveWithQueen extends Equatable {
  final Hive hive;
  final Queen? queen;

  HiveWithQueen({
    required this.hive,
    this.queen,
  });

  @override
  List<Object?> get props => [hive, queen];
}