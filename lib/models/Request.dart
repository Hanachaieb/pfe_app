class Request {
  String userId;
  String id;
  String workerId;
  DateTime date;
  int status;

  Request({
    required this.userId,
    required this.workerId,
    required this.date,
    required this.id,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userId: json['userId'],
      id: json['id'],
      workerId: json['workerId'],
      date: json['date'].toDate(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['workerId'] = this.workerId;
    data['date'] = this.date.toIso8601String();
    data['status'] = this.status;
    return data;
  }
}
