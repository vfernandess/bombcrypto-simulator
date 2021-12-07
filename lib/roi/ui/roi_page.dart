import 'package:bombscrypto_simulator/roi/model/roi_model.dart';
import 'package:bombscrypto_simulator/roi/roi_contract.dart';
import 'package:bombscrypto_simulator/roi/business/roi_presenter.dart';
import 'package:bombscrypto_simulator/util/image/images.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class RoiPage extends StatefulWidget {
  const RoiPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RoiState();
  }
}

class RoiState extends RoiViewContract with SingleTickerProviderStateMixin {
  late final RoiPresenterContract _presenter = RoiPresenter(this);

  RoiModel? _roi;

  final _investmentCurrencyFormatter = CurrencyTextInputFormatter(symbol: "BC");
  final _dailyProfitCurrencyFormatter =
      CurrencyTextInputFormatter(symbol: "BC");
  final spaceBetween = const SizedBox(height: 16);

  late final _investmentController =
      TextEditingController(text: _investmentCurrencyFormatter.format("0"));
  late final _dailyProfitController =
      TextEditingController(text: _dailyProfitCurrencyFormatter.format("0"));

  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  Future<RoiModel>? loadFuture;

  @override
  void initState() {
    loadFuture = _presenter.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculate your ROI"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: FutureBuilder<RoiModel>(
                    future: loadFuture,
                    builder: (context, snapshot) {
                      if (_roi != null) {
                        return _createMainContainer(context, _roi);
                      }

                      if (snapshot.hasData) {
                        _roi = snapshot.data;
                        return _createMainContainer(context, _roi);
                      }

                      return const Center(child: CircularProgressIndicator());
                    }))));
  }

  Widget _createMainContainer(BuildContext context, RoiModel? roi) {
    return Column(
      children: [
        _createSimulationForm(context, roi),
        spaceBetween,
        const Divider(thickness: 1),
        spaceBetween,
        _createResultView(context, roi)
      ],
    );
  }

  Widget _createSimulationForm(BuildContext context, RoiModel? roi) {
    return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: ProjectImage.card(), fit: BoxFit.fill),
        ),
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                TextFormField(
                  controller: _investmentController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Total investment',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_investmentCurrencyFormatter],
                ),
                spaceBetween,
                TextFormField(
                  controller: _dailyProfitController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Daily Profit',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_dailyProfitCurrencyFormatter],
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (view) {
                    _simulate(context);
                  },
                ),
                spaceBetween,
                ElevatedButton(
                  child: const Text(
                    "calculate",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _simulate(context);
                  },
                ),
              ],
            )));
  }

  Widget _createResultView(BuildContext context, RoiModel? roi) {
    return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: ProjectImage.card(), fit: BoxFit.fill),
        ),
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(children: [
              spaceBetween,
              Text(
                "${roi?.daysLeft} \n days left",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              spaceBetween,
              spaceBetween,
              _createCoinTabs(context, roi),
            ])));
  }

  Widget _createCoinTabs(BuildContext context, RoiModel? roi) {
    return SizedBox(
        width: double.infinity,
        height: 240,
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: ProjectColors.textLightColor,
              labelColor: ProjectColors.textDarkColor,
              tabs: const [Tab(text: "BCOIN"), Tab(text: "USD")],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: _createTabItems(roi),
            )),
          ],
        ));
  }

  List<Widget> _createTabItems(RoiModel? roi) {
    return roi?.dates.map<Widget>((date) {
          return _createSimulationDate(date);
        }).toList() ??
        [];
  }

  Widget _createSimulationDate(RoiDateModel? date) {
    return Column(
      children: [
        spaceBetween,
        spaceBetween,
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("In 7 days"),
          Text(date?.profitIn7days.toStringAsFixed(2) ?? "")
        ]),
        spaceBetween,
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("In 15 days"),
          Text(date?.profitIn15days.toStringAsFixed(2) ?? "")
        ]),
        spaceBetween,
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("In 30 days"),
          Text(date?.profitIn30days.toStringAsFixed(2) ?? "")
        ]),
        spaceBetween,
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("In 180 days"),
          Text(date?.profitIn180days.toStringAsFixed(2) ?? "")
        ]),
        spaceBetween,
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("In 365 days"),
          Text(date?.profitIn365days.toStringAsFixed(2) ?? "")
        ]),
      ],
    );
  }

  _simulate(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    final investment = _investmentCurrencyFormatter.getUnformattedValue();
    final dailyProfit = _dailyProfitCurrencyFormatter.getUnformattedValue();
    _presenter.calculate(investment, dailyProfit);
  }

  @override
  showCalculationResult(RoiModel roi) {
    setState(() {
      _roi = roi;
    });
  }
}
