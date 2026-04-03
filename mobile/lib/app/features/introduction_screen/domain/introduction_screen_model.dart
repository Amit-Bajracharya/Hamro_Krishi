class IntroductionContent {
  final String title;
  final String description;
  final String imagePath;
  final String? badgeText;

  IntroductionContent({
    required this.title,
    required this.description,
    required this.imagePath,
    this.badgeText,
  });
}
