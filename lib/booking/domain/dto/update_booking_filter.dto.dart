class UpdateBookingFilterDto {
  int? id;
  int? statusId;

  UpdateBookingFilterDto({this.id, this.statusId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['statusId'] = statusId;
    return data;
  }
}