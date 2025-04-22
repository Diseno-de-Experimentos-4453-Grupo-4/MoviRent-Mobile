class ReportResponseDTO {
  int? id;
  int? profileId;
  int? scooterId;
  String? content;

  ReportResponseDTO(
      {
        this.id,
        this.profileId,
        this.scooterId,
        this.content
      }
  );

  ReportResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profileId'];
    scooterId = json['scooterId'];
    content = json['content'];
  }

}