class RateResponseDTO {
  int? id;
  String? comment;
  int? starNumb;
  int? profileId;
  int? scooterId;

  RateResponseDTO(
      {
        this.id,
        this.comment,
        this.starNumb,
        this.profileId,
        this.scooterId
      }
   );

  RateResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    starNumb = json['starNumb'];
    profileId = json['profileId'];
    scooterId = json['scooterId'];
  }

}