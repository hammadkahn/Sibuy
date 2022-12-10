class DashboardStatsModel {
  bool? status;
  int? responseCode;
  String? message;
  DashboardData? data;

  DashboardStatsModel(
      {this.status, this.responseCode, this.message, this.data});

  DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['responseCode'] = responseCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardData {
  int? totalSales;
  int? totalActiveOffers;
  int? totalDealSale;
  int? totalCouponRadeemed;
  int? totalUnredeemedWithHolding;
  int? totalRedeemedWithHolding;
  int? totalTransactionFee;
  int? totalToWithDraw;
  int? totalInProcess;

  DashboardData(
      {this.totalSales,
      this.totalActiveOffers,
      this.totalDealSale,
      this.totalCouponRadeemed,
      this.totalUnredeemedWithHolding,
      this.totalRedeemedWithHolding,
      this.totalTransactionFee,
      this.totalToWithDraw,
      this.totalInProcess});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalSales = json['totalSales'];
    totalActiveOffers = json['totalActiveOffers'];
    totalDealSale = json['totalDealSale'];
    totalCouponRadeemed = json['totalCouponRadeemed'];
    totalUnredeemedWithHolding = json['totalUnredeemedWithHolding'];
    totalRedeemedWithHolding = json['totalRedeemedWithHolding'];
    totalTransactionFee = json['totalTransactionFee'];
    totalToWithDraw = json['totalToWithDraw'];
    totalInProcess = json['totalInProcess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalSales'] = totalSales;
    data['totalActiveOffers'] = totalActiveOffers;
    data['totalDealSale'] = totalDealSale;
    data['totalCouponRadeemed'] = totalCouponRadeemed;
    data['totalUnredeemedWithHolding'] = totalUnredeemedWithHolding;
    data['totalRedeemedWithHolding'] = totalRedeemedWithHolding;
    data['totalTransactionFee'] = totalTransactionFee;
    data['totalToWithDraw'] = totalToWithDraw;
    data['totalInProcess'] = totalInProcess;
    return data;
  }
}
