import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Raport extends Equatable {
  final String id;
  final String? hiveId;
  final String? apiaryId;
  final DateTime createdAt;
  final RaportType raportType;

  Raport({
    String? id,
    this.hiveId,
    this.apiaryId,
    required this.raportType,
    required DateTime createdAt,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt.copyWith(millisecond: 0, microsecond: 0);

  Raport copyWith({
    String? hiveId,
    String? apiaryId,
    DateTime? createdAt,
    RaportType? raportType,
  }) {
    return Raport(
      id: this.id,
      hiveId: hiveId ?? this.hiveId,
      raportType: raportType ?? this.raportType,
      apiaryId: apiaryId ?? this.apiaryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, hiveId, createdAt];
}

extension RaportTypeX on RaportType {
  LogType toLogType() {
    switch (this) {
      case RaportType.advanced:
        return LogType.inspection;
      case RaportType.simple:
        return LogType.inspection;
      case RaportType.custom:
        return LogType.inspection;
      case RaportType.harvest:
        return LogType.harvest;
      case RaportType.treatment:
        return LogType.treatment;
      case RaportType.note:
        return LogType.note;
      case RaportType.finances:
        return LogType.finances;
      case RaportType.feeding:
        return LogType.feeding;
    }
  }
}