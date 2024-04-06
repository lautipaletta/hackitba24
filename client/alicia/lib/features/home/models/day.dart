enum Day {
  MONDAY("Lun"),
  TUESDAY("Mar"),
  WEDNESDAY("Mie"),
  THURSDAY("Jue"),
  FRIDAY("Vie"),
  SATURDAY("Sab"),
  SUNDAY("Dom");
  final String label;
  const Day(this.label);
}

final Map<Day, bool> daysFilledMockedMap = {
  Day.MONDAY: true,
  Day.TUESDAY: false,
  Day.WEDNESDAY: false,
  Day.THURSDAY: true,
  Day.FRIDAY: false,
  Day.SATURDAY: false,
  Day.SUNDAY: false
};