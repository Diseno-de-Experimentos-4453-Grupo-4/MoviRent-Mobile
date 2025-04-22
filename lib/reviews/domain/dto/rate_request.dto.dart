class RateRequestDTO {
  String? comment;
  int? starNumb;
  int? profileId;
  int? scooterId;

  RateRequestDTO({this.comment, this.starNumb, this.profileId, this.scooterId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = comment;
    data['starNumb'] = starNumb;
    data['profileId'] = profileId;
    data['scooterId'] = scooterId;
    return data;
  }
}