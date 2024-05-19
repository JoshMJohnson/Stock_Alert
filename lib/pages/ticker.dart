import 'package:flutter/material.dart';
import 'package:stock_alert/pages/homePageWidgets/stock_entity.dart';

class TickerPage extends StatelessWidget {
  final Function(String deletingTicker) removeTicker;
  final StockEntity stock;
  const TickerPage(this.removeTicker, this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: header(context), body: tickerBody(context));
  }

  /* header of the Ticker page */
  AppBar header(BuildContext context) {
    return AppBar(
        title: Text(
          stock.ticker,
          style: TextStyle(
            color: Theme.of(context).textTheme.headlineMedium!.color,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          SizedBox(
            width: 60,
            child: GestureDetector(
              onTap: () => removeTicker(stock.ticker),
              child: Icon(
                Icons.delete,
                size: 35,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ]);
  }

  /* body of the ticker page */
  Container tickerBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).colorScheme.background
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: (Theme.of(context).cardTheme.color)!,
                ),
              ),
            ),
            child: Text(
              stock.companyName,
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              stock.companyDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          SizedBox(
            height: 75,
            child:
                Image.asset('assets/market_logos/NASDAQ.png'), // ! temp value
          ),
          Center(
            child: Text(
              '52 Week Range',
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Center(
              child: Text(
                '\$${stock.low52Week.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                disabledActiveTrackColor:
                    Theme.of(context).sliderTheme.disabledActiveTrackColor,
                disabledInactiveTrackColor:
                    Theme.of(context).sliderTheme.disabledInactiveTrackColor,
                disabledThumbColor:
                    Theme.of(context).sliderTheme.disabledThumbColor,
                trackHeight: 10,
                thumbShape: const RoundSliderThumbShape(
                  disabledThumbRadius: 10,
                ),
              ),
              child: Slider(
                value: stock.tickerPrice,
                onChanged: null,
                min: stock.low52Week,
                max: stock.high52Week,
              ),
            ),
            Center(
              child: Text(
                '\$${stock.high52Week.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Row(children: [
              Flexible(
                flex: 1,
                child: Column(children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Theme.of(context).cardTheme.color)!,
                            width: 4,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Day Change',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    '${stock.dayChangePercentage}%',
                                    style: TextStyle(
                                      color: stock.dayChangePercentage >= 0
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    '\$${stock.dayChangeDollars.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: stock.dayChangePercentage >= 0
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Theme.of(context).cardTheme.color)!,
                            width: 4,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    'PPS',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    '\$${stock.tickerPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: stock.dayChangePercentage >= 0
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: stock.dayChangePercentage >= 0
                        ? Image.asset('assets/bull_ticker_page.png',
                            fit: BoxFit.fill)
                        : Image.asset(
                            'assets/bear_ticker_page.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
