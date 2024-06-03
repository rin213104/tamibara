class ToDo {
  String id;
  String title;
  DateTime date;
  int duration;
  String memo;
  bool isChecked;

  ToDo({
    required this.id,
    required this.title,
    required this.date,
    required this.duration,
    required this.memo,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'duration': duration,
      'memo': memo,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  static ToDo fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      duration: map['duration'],
      memo: map['memo'],
      isChecked: map['isChecked'] == 1,
    );
  }
}
