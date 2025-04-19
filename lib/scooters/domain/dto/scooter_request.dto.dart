class ScooterRequestDTO {
  String? brand;
  String? image;
  String? street;
  String? neighborhood;
  String? city;
  String? district;
  int? price;
  String? model;
  int? profileId;

  ScooterRequestDTO(
      {this.brand,
        this.image,
        this.street,
        this.neighborhood,
        this.city,
        this.district,
        this.price,
        this.model,
        this.profileId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = brand;
    data['image'] = image;
    data['street'] = street;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['district'] = district;
    data['price'] = price;
    data['model'] = model;
    data['profileId'] = profileId;
    return data;
  }
}