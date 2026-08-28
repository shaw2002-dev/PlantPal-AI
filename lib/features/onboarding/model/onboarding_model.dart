class OnboardingModel {
  final String image;

  const OnboardingModel({
    required this.image,
  });

  OnboardingModel copyWith({
    String? image,
  }) {
    return OnboardingModel(
      image: image ?? this.image,
    );
  }

  factory OnboardingModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OnboardingModel(
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }

  @override
  String toString() {
    return 'OnboardingModel(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OnboardingModel &&
        other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}