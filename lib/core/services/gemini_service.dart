import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../features/plant/model/plant_result_model.dart';
import '../constants/api_constants.dart';

class GeminiService {
  GeminiService._();

  static final GenerativeModel _model = GenerativeModel(
    model: ApiConstants.model,
    apiKey: ApiConstants.geminiApiKey,
  );

  static Future<PlantResultModel> identifyPlant(
      File image,
      ) async {
    final bytes = await image.readAsBytes();

    final response = await _model.generateContent([
      Content.multi([
        TextPart(_prompt),
        DataPart(
          "image/jpeg",
          bytes,
        ),
      ]),
    ]);

    final text = response.text;

    if (text == null || text.isEmpty) {
      throw Exception(
        "No response received from Gemini.",
      );
    }

    final cleaned = text
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    final dynamic decodedJson = jsonDecode(cleaned);

    if (decodedJson is! Map<String, dynamic>) {
      throw Exception(
        "Invalid plant analysis response.",
      );
    }

    return PlantResultModel.fromJson(decodedJson).copyWith(
      imagePath: image.path,
    );
  }

  static const String _prompt = '''
You are an expert botanist, plant pathologist, and plant health specialist.

Carefully analyze the uploaded plant image.

Your tasks are:

1. Identify the plant.
2. Analyze the visible health condition of the plant.
3. Detect visible signs of plant disease.
4. Identify the most likely disease if disease symptoms are visible.
5. Analyze visible symptoms.
6. Explain the possible cause.
7. Recommend practical treatment.
8. Recommend disease prevention methods.
9. Calculate a plant health score between 0 and 100.
10. Assign an appropriate health status.

Return ONLY valid JSON in exactly this format:

{
  "plant_name": "",
  "scientific_name": "",
  "confidence": 95.5,

  "watering": "",
  "sunlight": "",
  "soil": "",
  "fertilizer": "",
  "humidity": "",
  "temperature": "",

  "pet_safe": false,

  "care_guide": "",

  "common_problems": [
    "Problem name: Detailed explanation."
  ],

  "disease_detected": false,
  "disease_name": "",
  "disease_description": "",

  "symptoms": [
    "Visible symptom"
  ],

  "disease_cause": "",
  "treatment": "",
  "prevention": "",

  "health_score": 100,
  "health_status": "Healthy"
}

Rules:

PLANT IDENTIFICATION:

- confidence must be a NUMBER between 0 and 100.
- Do NOT include the % symbol.
- Confidence represents confidence in plant identification.
- If plant identification is highly certain, confidence may be above 95.
- If the image is blurry, unclear, or partially visible, reduce confidence.
- Never invent an exact plant identification when visual evidence is insufficient.

PLANT CARE:

- watering must provide practical watering guidance.
- sunlight must explain the recommended light condition.
- soil must recommend an appropriate soil type.
- fertilizer must provide useful fertilizer guidance.
- humidity must describe the preferred humidity condition.
- temperature must provide the recommended temperature range.
- care_guide must contain 5 to 8 detailed sentences.
- common_problems must contain 2 to 5 common plant problems.
- Each common problem must contain the problem name and a detailed 2 to 3 sentence explanation.

DISEASE ANALYSIS:

- Analyze ONLY visible symptoms from the uploaded image.
- Do not claim a disease is definitely present without visible evidence.
- disease_detected must be true only when visible disease symptoms are reasonably present.
- If no visible disease symptoms are detected:
  disease_detected must be false.
  disease_name must be "No visible disease detected".
  disease_description must explain that no obvious disease symptoms are visible.
- If disease symptoms are visible:
  disease_detected must be true.
  disease_name must contain the most likely disease or plant health issue.
  disease_description must contain a detailed 3 to 5 sentence explanation.
- symptoms must contain 1 to 5 symptoms visible or reasonably indicated by the image.
- disease_cause must explain the likely biological or environmental cause.
- treatment must contain practical treatment recommendations.
- prevention must contain practical prevention recommendations.
- Clearly use cautious wording when the disease cannot be confirmed from the image alone.

HEALTH SCORE:

Calculate health_score using the visible condition of the plant.

Use these guidelines:

90-100 = Healthy
75-89 = Good
50-74 = Needs Attention
25-49 = Unhealthy
0-24 = Critical

Consider:

- Leaf color
- Yellowing
- Brown spots
- Black spots
- Leaf damage
- Wilting
- Visible fungal symptoms
- Pest damage
- Overall plant appearance

health_score must be an INTEGER between 0 and 100.

health_status must exactly match the health score:

90-100 = "Healthy"
75-89 = "Good"
50-74 = "Needs Attention"
25-49 = "Unhealthy"
0-24 = "Critical"

IMPORTANT:

- Base disease analysis primarily on visible evidence.
- Do not provide false certainty.
- Do not use markdown.
- Do not wrap the JSON in code fences.
- Do not add explanations before or after the JSON.
- Return JSON only.
''';
}