class ScooterResponseDTO {
  int? id;
  String? brand;
  String? image;
  String? street;
  String? neighborhood;
  String? city;
  String? district;
  int? price;
  String? model;
  int? profileId;

  ScooterResponseDTO(
      {
        this.id,
        this.brand,
        this.image,
        this.street,
        this.neighborhood,
        this.city,
        this.district,
        this.price,
        this.model,
        this.profileId
      });

  ScooterResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    image = json['image'];
    street = json['street'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    district = json['district'];
    price = json['price'];
    model = json['model'];
    profileId = json['profileId'];
  }

}