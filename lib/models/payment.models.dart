class PaymentModel {
  int id;
  String paymentKey;
  String paymentMadeDateTime;
  String paymentTransactionId;
  double paymentAmount;
  String paymentUpdated;
  String paymentMethod;
  bool paymentIsVerified;
  String paymentVerifiedDateTime;
  String paymentOn;
  int institute;
  int paymentBy;
  int paymentVerifiedBy;

  PaymentModel(
      {this.id,
      this.paymentKey,
      this.paymentMadeDateTime,
      this.paymentTransactionId,
      this.paymentAmount,
      this.paymentUpdated,
      this.paymentMethod,
      this.paymentIsVerified,
      this.paymentVerifiedDateTime,
      this.paymentOn,
      this.institute,
      this.paymentBy,
      this.paymentVerifiedBy});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentKey = json['payment_key'];
    paymentMadeDateTime = json['payment_made_date_time'];
    paymentTransactionId = json['payment_transaction_id'];
    paymentAmount = json['payment_amount'];
    paymentUpdated = json['payment_updated'];
    paymentMethod = json['payment_method'];
    paymentIsVerified = json['payment_is_verified'];
    paymentVerifiedDateTime = json['payment_verified_date_time'];
    paymentOn = json['payment_on'];
    institute = json['institute'];
    paymentBy = json['payment_by'];
    paymentVerifiedBy = json['payment_verified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_key'] = this.paymentKey;
    data['payment_made_date_time'] = this.paymentMadeDateTime;
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['payment_amount'] = this.paymentAmount;
    data['payment_updated'] = this.paymentUpdated;
    data['payment_method'] = this.paymentMethod;
    data['payment_is_verified'] = this.paymentIsVerified;
    data['payment_verified_date_time'] = this.paymentVerifiedDateTime;
    data['payment_on'] = this.paymentOn;
    data['institute'] = this.institute;
    data['payment_by'] = this.paymentBy;
    data['payment_verified_by'] = this.paymentVerifiedBy;
    return data;
  }
}

class PaymentCreateModel {
  String paymentTransactionId;
  double paymentAmount;
  String paymentOn;

  PaymentCreateModel(
      {this.paymentTransactionId, this.paymentAmount, this.paymentOn});

  PaymentCreateModel.fromJson(Map<String, dynamic> json) {
    paymentTransactionId = json['payment_transaction_id'];
    paymentAmount = json['payment_amount'];
    paymentOn = json['payment_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['payment_amount'] = this.paymentAmount;
    data['payment_on'] = this.paymentOn;
    return data;
  }
}
