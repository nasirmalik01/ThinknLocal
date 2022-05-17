class Notification {
  int? id;
  String? title;
  String? message;
  bool? read;

  Notification({this.id, this.title, this.message, this.read});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['read'] = read;
    return data;
  }
}