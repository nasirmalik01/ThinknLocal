class UploadDirectContributions {
  String? id;
  String? uploadUrl;

  UploadDirectContributions({this.id, this.uploadUrl});

  UploadDirectContributions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadUrl = json['upload_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['upload_url'] = uploadUrl;
    return data;
  }
}