class PlantResultModel {
  final String plantName;
  final String scientificName;
  final double confidence;

  // Plant care
  final String watering;
  final String sunlight;
  final String soil;
  final String fertilizer;
  final String humidity;
  final String temperature;

  final bool petSafe;
  final String careGuide;
  final List<String> commonProblems;

  // Disease analysis
  final bool diseaseDetected;
  final String diseaseName;
  final String diseaseDescription;
  final List<String> symptoms;
  final String diseaseCause;
  final String treatment;
  final String prevention;

  // Plant health
  final int healthScore;
  final String healthStatus;

  final String imagePath;
  final DateTime scannedAt;
  final bool isFavorite;

  const PlantResultModel({
    required this.plantName,
    required this.scientificName,
    required this.confidence,
    required this.watering,
    required this.sunlight,
    required this.soil,
    required this.fertilizer,
    required this.humidity,
    required this.temperature,
    required this.petSafe,
    required this.careGuide,
    required this.commonProblems,

    // Disease
    this.diseaseDetected = false,
    this.diseaseName = "",
    this.diseaseDescription = "",
    this.symptoms = const [],
    this.diseaseCause = "",
    this.treatment = "",
    this.prevention = "",

    // Health
    this.healthScore = 100,
    this.healthStatus = "Healthy",

    required this.imagePath,
    required this.scannedAt,
    this.isFavorite = false,
  });

  factory PlantResultModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PlantResultModel(
      plantName: json["plant_name"] ?? "",
      scientificName: json["scientific_name"] ?? "",
      confidence: (json["confidence"] ?? 0).toDouble(),

      watering: json["watering"] ?? "",
      sunlight: json["sunlight"] ?? "",
      soil: json["soil"] ?? "",
      fertilizer: json["fertilizer"] ?? "",
      humidity: json["humidity"] ?? "",
      temperature: json["temperature"] ?? "",

      petSafe: json["pet_safe"] ?? false,

      careGuide: json["care_guide"] ?? "",

      commonProblems: List<String>.from(
        json["common_problems"] ?? [],
      ),

      // Disease analysis
      diseaseDetected: json["disease_detected"] ?? false,
      diseaseName: json["disease_name"] ?? "",
      diseaseDescription: json["disease_description"] ?? "",

      symptoms: List<String>.from(
        json["symptoms"] ?? [],
      ),

      diseaseCause: json["disease_cause"] ?? "",
      treatment: json["treatment"] ?? "",
      prevention: json["prevention"] ?? "",

      // Health analysis
      healthScore: (json["health_score"] ?? 100).toInt(),
      healthStatus: json["health_status"] ?? "Healthy",

      imagePath: json["image_path"] ?? "",

      scannedAt: json["scanned_at"] == null
          ? DateTime.now()
          : DateTime.parse(json["scanned_at"]),

      isFavorite: json["is_favorite"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plant_name": plantName,
      "scientific_name": scientificName,
      "confidence": confidence,

      "watering": watering,
      "sunlight": sunlight,
      "soil": soil,
      "fertilizer": fertilizer,
      "humidity": humidity,
      "temperature": temperature,

      "pet_safe": petSafe,

      "care_guide": careGuide,

      "common_problems": commonProblems,

      // Disease
      "disease_detected": diseaseDetected,
      "disease_name": diseaseName,
      "disease_description": diseaseDescription,
      "symptoms": symptoms,
      "disease_cause": diseaseCause,
      "treatment": treatment,
      "prevention": prevention,

      // Health
      "health_score": healthScore,
      "health_status": healthStatus,

      "image_path": imagePath,

      "scanned_at": scannedAt.toIso8601String(),

      "is_favorite": isFavorite,
    };
  }

  PlantResultModel copyWith({
    String? plantName,
    String? scientificName,
    double? confidence,
    String? watering,
    String? sunlight,
    String? soil,
    String? fertilizer,
    String? humidity,
    String? temperature,
    bool? petSafe,
    String? careGuide,
    List<String>? commonProblems,

    bool? diseaseDetected,
    String? diseaseName,
    String? diseaseDescription,
    List<String>? symptoms,
    String? diseaseCause,
    String? treatment,
    String? prevention,

    int? healthScore,
    String? healthStatus,

    String? imagePath,
    DateTime? scannedAt,
    bool? isFavorite,
  }) {
    return PlantResultModel(
      plantName: plantName ?? this.plantName,
      scientificName: scientificName ?? this.scientificName,
      confidence: confidence ?? this.confidence,

      watering: watering ?? this.watering,
      sunlight: sunlight ?? this.sunlight,
      soil: soil ?? this.soil,
      fertilizer: fertilizer ?? this.fertilizer,
      humidity: humidity ?? this.humidity,
      temperature: temperature ?? this.temperature,

      petSafe: petSafe ?? this.petSafe,

      careGuide: careGuide ?? this.careGuide,

      commonProblems: commonProblems ?? this.commonProblems,

      diseaseDetected:
      diseaseDetected ?? this.diseaseDetected,

      diseaseName: diseaseName ?? this.diseaseName,

      diseaseDescription:
      diseaseDescription ?? this.diseaseDescription,

      symptoms: symptoms ?? this.symptoms,

      diseaseCause: diseaseCause ?? this.diseaseCause,

      treatment: treatment ?? this.treatment,

      prevention: prevention ?? this.prevention,

      healthScore: healthScore ?? this.healthScore,

      healthStatus: healthStatus ?? this.healthStatus,

      imagePath: imagePath ?? this.imagePath,

      scannedAt: scannedAt ?? this.scannedAt,

      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}