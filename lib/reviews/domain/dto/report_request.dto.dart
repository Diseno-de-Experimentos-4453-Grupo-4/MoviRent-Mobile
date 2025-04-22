class ReportRequestDTO {
  int? profileId;
  int? scooterId;
  String? content;

  ReportRequestDTO({this.profileId, this.scooterId, this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = profileId;
    data['scooterId'] = scooterId;
    data['content'] = content;
    return data;
  }
}