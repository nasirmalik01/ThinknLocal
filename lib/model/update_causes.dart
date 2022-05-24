class UpdateCauses {
  int? id;
  String? title;
  String? message;
  String? author;

  UpdateCauses({this.id, this.title, this.message, this.author});

  UpdateCauses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['author'] = author;
    return data;
  }
}
