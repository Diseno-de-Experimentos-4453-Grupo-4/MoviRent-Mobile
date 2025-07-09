class ScooterResponseDTO {
  int? id;
  String? brand;
  String? image;
  String? address;
  double? price;
  String? model;
  int? profileId;
  bool? isAvailable;
  String? bankAccount;
  int? ownerScore;

  ScooterResponseDTO(
      {
        this.id,
        this.brand,
        this.image,
        this.address,
        this.price,
        this.model,
        this.profileId,
        this.isAvailable,
        this.bankAccount,
        this.ownerScore
      });

  ScooterResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    image = json['image'];
    address = json['address'];
    price = json['price'];
    model = json['model'];
    profileId = json['profileId'];
    isAvailable = json['isAvailable'];
    bankAccount = json['bankAccount'];
    ownerScore = json['ownerScore'];
  }

}