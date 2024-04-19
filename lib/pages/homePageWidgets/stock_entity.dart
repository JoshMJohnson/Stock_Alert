class StockEntity {
  String ticker;
  String companyName;
  double tickerPrice;
  double dayChangeDollars;
  double dayChangePercentage;

  StockEntity(
      {required this.ticker,
      required this.companyName,
      required this.tickerPrice,
      required this.dayChangeDollars,
      required this.dayChangePercentage});
}