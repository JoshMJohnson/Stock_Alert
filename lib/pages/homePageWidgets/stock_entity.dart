class StockEntity {
  String ticker;
  String companyName;
  String companyDescription;
  double tickerPrice;
  double dayChangeDollars;
  double dayChangePercentage;
  String exchange;
  double low52Week;
  double high52Week;
  bool activeTracking;

  StockEntity({
    required this.ticker,
    required this.companyName,
    required this.companyDescription,
    required this.tickerPrice,
    required this.dayChangeDollars,
    required this.dayChangePercentage,
    required this.exchange,
    required this.low52Week,
    required this.high52Week,
    required this.activeTracking,
  });
}
