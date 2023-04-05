class Settings {
  final String langID;
  final int classLenght;
  final int numOfWeeks;

  const Settings(this.langID, this.classLenght, this.numOfWeeks);

  static const defaultValues = Settings("en", 45, 1);
}
