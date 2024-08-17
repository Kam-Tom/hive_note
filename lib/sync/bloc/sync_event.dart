abstract class SyncEvent {}

class ToggleVoiceControl extends SyncEvent {
  final bool isEnabled;

  ToggleVoiceControl(this.isEnabled);
}

class SearchDevices extends SyncEvent {

}