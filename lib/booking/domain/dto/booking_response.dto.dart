class BookingResponseDTO {
  int? id;
  String? startDate;
  String? endDate;
  int? profileId;
  int? scooterId;

  BookingResponseDTO(
      {this.id, this.startDate, this.endDate, this.profileId, this.scooterId});

  BookingResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    profileId = json['profileId'];
    scooterId = json['scooterId'];
  }

}

