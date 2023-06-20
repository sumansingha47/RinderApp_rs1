class Reminder {
  String? id;
  String? taskName;
  DateTime? scheduleDate;

  Reminder({this.id, this.taskName, this.scheduleDate});

  factory Reminder.fromJson(Map<String, dynamic> map) {
    return Reminder(
        id: map["id"].toString(),
        taskName: map["taskName"].toString(),
        scheduleDate: DateTime.parse(map["scheduleDate"].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id.toString(),
      "taskName": this.taskName.toString(),
      "scheduleDate": this.scheduleDate!.toIso8601String()
    };
  }
}
