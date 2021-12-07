class RoiDateModel {
  final String title;
  final num profitIn7days;
  final num profitIn15days;
  final num profitIn30days;
  final num profitIn180days;
  final num profitIn365days;

  RoiDateModel(
    this.title,
    this.profitIn7days,
    this.profitIn15days,
    this.profitIn30days,
    this.profitIn180days,
    this.profitIn365days,
  );
}

class RoiModel {
  final List<RoiDateModel> dates;
  final int daysLeft;

  RoiModel(this.dates, this.daysLeft);
}
