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

  HiveWithQueen copyWith({
    Hive? hive,
    Queen? queen,
  }) {
    return HiveWithQueen(
      hive: hive ?? this.hive,
      queen: queen ?? this.queen,
    );
  }

  @override
  List<Object?> get props => [hive, queen];
}