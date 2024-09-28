import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QueenWithHive extends Equatable {
  final Queen queen;
  final Hive? hive;

  QueenWithHive({
    required this.queen,
    this.hive,
  });

  QueenWithHive copyWith({
    Queen? queen,
    Hive? hive,
  }) {
    return QueenWithHive(
      queen: queen ?? this.queen,
      hive: hive ?? this.hive,
    );
  }

  @override
  List<Object?> get props => [queen, hive];
}