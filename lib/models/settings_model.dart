class Settings {
  final String langID;
  final int numOfWeeks;
  final String theme;
  final int selectedWeek;

  const Settings(this.langID, this.numOfWeeks, this.theme, this.selectedWeek);

  static const defaultValues = Settings("en", 1, 'light', 1);
}
