class Prediction {
  final String productName;
  final String demandLevel;
  final String estimatedPriceTrend;
  final String reasoning;

  Prediction({
    required this.productName,
    required this.demandLevel,
    required this.estimatedPriceTrend,
    required this.reasoning,
  });
}
