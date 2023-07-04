class Event_Calendar {
  final String id;
  final String type;
  final String date;
  final String event_name;
  final int video_id;


  Event_Calendar(
      {
        required this.id,
        required this.type,
        required this.date,
        required this.event_name,
        required this.video_id,
      }
  );

  factory Event_Calendar.fromJson(Map<String, dynamic> json) {
    return Event_Calendar(
        id: json['id'] as String,
        type: json['type'] as String,
        date: json['date'] as String,
        event_name: json['event_name'] as String,
        video_id: json['video_id'] as int,
    );
  }
}