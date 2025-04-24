class SubscriptionRequestDTO {
  int? profileId;

  SubscriptionRequestDTO({this.profileId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileId'] = profileId;
    return data;
  }
}