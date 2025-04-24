class InvoiceResponseDTO {
  int? amount;
  int? profileId;

  InvoiceResponseDTO({this.amount, this.profileId});

  InvoiceResponseDTO.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    profileId = json['profileId'];
  }

}