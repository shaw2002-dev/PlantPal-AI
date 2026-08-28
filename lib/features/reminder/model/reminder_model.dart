class ReminderModel {
  final int id;

  final String plantName;

  final String imagePath;

  final int hour;

  final int minute;

  final List<int> weekDays;

  final bool enabled;

  ReminderModel({
    required this.id,
    required this.plantName,
    required this.imagePath,
    required this.hour,
    required this.minute,
    required this.weekDays,
    this.enabled = true,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "plant_name": plantName,
      "image_path": imagePath,
      "hour": hour,
      "minute": minute,
      "week_days": weekDays,
      "enabled": enabled,
    };
  }

  factory ReminderModel.fromJson(
      Map<String, dynamic> json) {
    return ReminderModel(
      id: json["id"],
      plantName: json["plant_name"],
      imagePath: json["image_path"],
      hour: json["hour"],
      minute: json["minute"],
      weekDays:
      List<int>.from(json["week_days"]),
      enabled: json["enabled"],
    );
  }

  ReminderModel copyWith({
    int? id,
    String? plantName,
    String? imagePath,
    int? hour,
    int? minute,
    List<int>? weekDays,
    bool? enabled,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      plantName: plantName ?? this.plantName,
      imagePath: imagePath ?? this.imagePath,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      weekDays: weekDays ?? this.weekDays,
      enabled: enabled ?? this.enabled,
    );
  }
}