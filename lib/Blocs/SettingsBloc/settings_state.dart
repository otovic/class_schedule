part of 'settings_bloc.dart';

enum loadStatus { firstLoad, loading, loaded, error }

class SettingsState {
  final loadStatus status;
  final Settings settings;

  SettingsState._(
      {this.settings = Settings.defaultValues,
      this.status = loadStatus.loading});

  SettingsState.defaultValues() : this._();

  SettingsState.setValues(Settings settings, loadStatus firstLoad)
      : this._(settings: settings, status: firstLoad);
}
