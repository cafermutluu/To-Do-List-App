class Duty {
  String? dutyName;
  bool isDone = false;
  String? imagePath;

  Duty({this.dutyName, this.isDone = false, this.imagePath});

  void dutyStatus() {
    isDone = !isDone;
  }

  Duty.fromMap(Map<String, dynamic> map) {
    dutyName = map["dutyName"];
    imagePath = map["imagePath"];
    isDone = map["isDone"];
  }

  Map<String, dynamic> toMap() =>
      {"dutyName": dutyName, "isDone": isDone, "imagePath": imagePath};
}
