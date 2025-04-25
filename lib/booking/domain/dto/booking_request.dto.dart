class BookingRequestDTO {
  int? profileId;
  int? scooterId;

  BookingRequestDTO({this.profileId, this.scooterId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = profileId;
    data['scooterId'] = scooterId;
    return data;
  }
}
