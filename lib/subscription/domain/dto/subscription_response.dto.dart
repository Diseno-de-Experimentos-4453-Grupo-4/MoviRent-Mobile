class SubscriptionResponseDTO {
  int? profileId;

  SubscriptionResponseDTO({this.profileId});

  SubscriptionResponseDTO.fromJson(Map<String, dynamic> json) {
    profileId = json['profileId'];
  }

}