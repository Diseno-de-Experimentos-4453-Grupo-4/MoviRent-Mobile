class ProfileDTO {
  String? firstName;
  String? lastName;
  String? email;
  String? dni;
  int? age;
  String? phone;
  String? street;
  String? neighborhood;
  String? city;
  String? district;

  ProfileDTO(
      {this.firstName,
        this.lastName,
        this.email,
        this.dni,
        this.age,
        this.phone,
        this.street,
        this.neighborhood,
        this.city,
        this.district});

  ProfileDTO.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    dni = json['dni'];
    age = json['age'];
    phone = json['phone'];
    street = json['street'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    district = json['district'];
  }

}