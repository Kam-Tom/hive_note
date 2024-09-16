import 'package:app_database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ApiariesWithHives extends Equatable {
  final List<ApiaryWithHives> apiaries;
  final List<Hive> orphans;

  ApiariesWithHives({
    required this.apiaries,
    required this.orphans,
  });

  @override
  List<Object?> get props => [apiaries, orphans];
}