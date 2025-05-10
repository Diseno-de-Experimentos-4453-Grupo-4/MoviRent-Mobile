class BookingRequestDTO {
  int? profileId;
  int? scooterId;
  String? baucher;

  BookingRequestDTO({this.profileId, this.scooterId, this.baucher});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = profileId;
    data['scooterId'] = scooterId;
    data['baucher'] = baucher;
    return data;
  }
}
