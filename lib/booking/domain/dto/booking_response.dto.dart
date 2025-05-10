class BookingResponseDTO {
  int? id;
  String? startDate;
  String? endDate;
  int? profileId;
  int? scooterId;
  String? baucher;
  int? statusId;

  BookingResponseDTO(
      {this.id, this.startDate, this.endDate, this.profileId, this.scooterId, this.baucher, this.statusId});

  BookingResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    profileId = json['profileId'];
    scooterId = json['scooterId'];
    baucher = json['baucher'];
    statusId = json['statusId'];
  }

}

