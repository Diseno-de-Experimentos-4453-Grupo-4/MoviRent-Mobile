class InvoiceRequestDTO {
  int? amount;
  int? profileId;

  InvoiceRequestDTO({this.amount, this.profileId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = amount;
    data['profileId'] = profileId;
    return data;
  }
}