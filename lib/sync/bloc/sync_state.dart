import 'package:equatable/equatable.dart';

class SyncState extends Equatable { 
  const SyncState({
    this.syncEnabled = false,
  });

  final bool syncEnabled;

  SyncState copyWith({
    bool Function()? syncEnabled,
  }) {
    return SyncState(
      syncEnabled: syncEnabled != null ? syncEnabled() : this.syncEnabled,
    );
  }

  @override
  List<Object?> get props => [
        syncEnabled,
      ];
}


