import 'package:bombscrypto_simulator/roi/business/roi_facade.dart';
import 'package:bombscrypto_simulator/roi/model/roi_model.dart';
import 'package:bombscrypto_simulator/roi/roi_contract.dart';

class RoiPresenter extends RoiPresenterContract {
  final RoiViewContract view;
  final RoiFacade _facade = RoiFacadeImpl();
  num _usdValue = 0;

  RoiPresenter(this.view);

  @override
  calculate(num investment, num dailyProfit) {
    final result = _calculateInternal(investment, dailyProfit);

    view.showCalculationResult(result);
  }

  RoiModel _calculateInternal(num investment, num dailyProfit) {
    final bcoin = RoiDateModel(
        "BCOIN",
        _calculateBCoinProfit(investment, dailyProfit, 7),
        _calculateBCoinProfit(investment, dailyProfit, 15),
        _calculateBCoinProfit(investment, dailyProfit, 30),
        _calculateBCoinProfit(investment, dailyProfit, 180),
        _calculateBCoinProfit(investment, dailyProfit, 365));

    final usd = RoiDateModel(
      "USD",
      _calculateUsdProfit(bcoin.profitIn7days),
      _calculateUsdProfit(bcoin.profitIn15days),
      _calculateUsdProfit(bcoin.profitIn30days),
      _calculateUsdProfit(bcoin.profitIn180days),
      _calculateUsdProfit(bcoin.profitIn365days),
    );

    var daysLeft = 0;
    if(investment > 0 && dailyProfit > 0) {
      daysLeft = (investment / dailyProfit).round();
    }

    return RoiModel([bcoin, usd], daysLeft);
  }

  num _calculateBCoinProfit(num investment, num dailyProfit, num day) {
    var result = (dailyProfit * day) - investment;
    if (result <= 0) {
      return 0;
    } else {
      return result;
    }
  }

  num _calculateUsdProfit(num bcoin) {
    var result = bcoin * _usdValue;
    if (result <= 0) {
      return 0;
    } else {
      return result;
    }
  }

  @override
  Future<RoiModel> load() {
    return Future.delayed(const Duration(seconds: 1), (){ return 6.41; })
    // return _facade
    //     .getBombCoinUsdPrice()
        .then((value) {
          _usdValue = value;

          return _calculateInternal(0, 0);
    });
  }
}
