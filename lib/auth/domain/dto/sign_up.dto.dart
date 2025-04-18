class SignUpDTO {
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
  String? password;

  SignUpDTO(
      {this.firstName,
        this.password,
        this.lastName,
        this.email,
        this.dni,
        this.age,
        this.phone,
        this.street,
        this.neighborhood,
        this.city,
        this.district});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['dni'] = dni;
    data['age'] = age;
    data['phone'] = phone;
    data['street'] = street;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['district'] = district;
    return data;
  }
}