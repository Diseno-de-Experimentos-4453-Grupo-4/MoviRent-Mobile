class ProfileDTO {
  String? firstName;
  String? lastName;
  String? email;
  String? dni;
  int? age;
  int? id;
  String? phone;
  String? street;
  String? neighborhood;
  String? city;
  String? district;

  ProfileDTO(
      {
        this.id,
        this.firstName,
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
    id = json['id'];
    firstName = json['fullName'].toString().split(" ")[0];
    lastName = json['fullName'].toString().split(" ")[1];
    email = json['email'];
    dni = json['dni'];
    age = json['age'];
    phone = json['phone'];
    street = json['fullAddress'].toString().split(", ")[0];
    neighborhood = json['fullAddress'].toString().split(", ")[1];
    city = json['fullAddress'].toString().split(", ")[2];
    district = json['fullAddress'].toString().split(", ")[3];
  }

}