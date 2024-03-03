class Period {
  Period(this.name, this.lengthInMinutes, {DateTime? startsAt, DateTime? endsAt}) :
        this.startsAt = startsAt ?? DateTime.now(),
        this.endsAt = endsAt ?? DateTime.now().add(Duration(minutes: lengthInMinutes));

  String name;
  int lengthInMinutes;

  DateTime startsAt;
  DateTime endsAt;
}
