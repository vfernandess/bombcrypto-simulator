import 'package:bombscrypto_simulator/roi/ui/roi_page.dart';
import 'package:flutter/material.dart';

import 'model/roi_model.dart';

abstract class RoiViewContract extends State<RoiPage> {

  showCalculationResult(RoiModel roi);
}

abstract class RoiPresenterContract {

  Future<RoiModel> load();

  calculate(num investment, num dailyProfit);
}
