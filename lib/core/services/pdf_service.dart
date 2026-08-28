import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../features/plant/model/plant_result_model.dart';

class PdfService {
  PdfService._();

  static const PdfColor _primary = PdfColor.fromInt(0xFF2E7D32);
  static const PdfColor _primaryLight = PdfColor.fromInt(0xFFE8F5E9);
  static const PdfColor _background = PdfColor.fromInt(0xFFF7FAF7);
  static const PdfColor _textPrimary = PdfColor.fromInt(0xFF1F2937);
  static const PdfColor _textSecondary = PdfColor.fromInt(0xFF6B7280);
  static const PdfColor _border = PdfColor.fromInt(0xFFDDE8DE);
  static const PdfColor _dangerLight = PdfColor.fromInt(0xFFFFEBEE);
  static const PdfColor _danger = PdfColor.fromInt(0xFFC62828);

  static Future<File> generatePlantReport(
      PlantResultModel plant,
      ) async {
    final pdf = pw.Document(
      title: '${plant.plantName} - Plant Health Report',
      author: 'PlantPal AI',
      subject: 'AI Plant Care Report',
      creator: 'PlantPal AI',
    );

    final image = await _loadPlantImage(
      plant.imagePath,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(
          horizontal: 38,
          vertical: 35,
        ),
        theme: pw.ThemeData.withFont(),
        header: (context) {
          if (context.pageNumber == 1) {
            return pw.SizedBox();
          }

          return _pageHeader(plant);
        },
        footer: (context) {
          return _pageFooter(
            context.pageNumber,
            context.pagesCount,
          );
        },
        build: (context) {
          return [
            _buildHeroHeader(
              plant,
              image,
            ),

            pw.SizedBox(height: 24),

            _buildQuickSummary(plant),

            _sectionTitle(
              'Plant Information',
              'AI identified plant details',
            ),

            _buildInformationCard(plant),

            _sectionTitle(
              'Plant Care Guide',
              'Recommended growing conditions',
            ),

            _buildCareGrid(plant),

            _sectionTitle(
              'AI Care Recommendation',
              'Personalized care guidance',
            ),

            _buildCareRecommendation(
              plant.careGuide,
            ),

            _sectionTitle(
              'Common Problems',
              'Issues you should watch for',
            ),

            _buildProblems(
              plant.commonProblems,
            ),

            pw.SizedBox(height: 20),

            _buildDisclaimer(),
          ];
        },
      ),
    );

    final directory =
    await getApplicationDocumentsDirectory();

    final safePlantName = _sanitizeFileName(
      plant.plantName,
    );

    final file = File(
      '${directory.path}/${safePlantName}_PlantPal_Report.pdf',
    );

    await file.writeAsBytes(
      await pdf.save(),
      flush: true,
    );

    return file;
  }

  // ---------------------------------------------------------------------------
  // HERO HEADER
  // ---------------------------------------------------------------------------

  static pw.Widget _buildHeroHeader(
      PlantResultModel plant,
      pw.MemoryImage? image,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(22),
      decoration: pw.BoxDecoration(
        color: _primary,
        borderRadius: pw.BorderRadius.circular(18),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          _buildPlantImage(image),

          pw.SizedBox(width: 22),

          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment:
              pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'PLANTPAL AI',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    letterSpacing: 2,
                  ),
                ),

                pw.SizedBox(height: 12),

                pw.Text(
                  plant.plantName,
                  style: pw.TextStyle(
                    fontSize: 27,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                  ),
                ),

                pw.SizedBox(height: 5),

                pw.Text(
                  plant.scientificName,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.white,
                  ),
                ),

                pw.SizedBox(height: 18),

                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    borderRadius:
                    pw.BorderRadius.circular(20),
                  ),
                  child: pw.Text(
                    'AI Plant Health Report',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: _primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPlantImage(
      pw.MemoryImage? image,
      ) {
    return pw.Container(
      width: 145,
      height: 145,
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(16),
      ),
      padding: const pw.EdgeInsets.all(5),
      child: pw.ClipRRect(
        horizontalRadius: 12,
        verticalRadius: 12,
        child: image != null
            ? pw.Image(
          image,
          fit: pw.BoxFit.cover,
        )
            : pw.Container(
          color: _primaryLight,
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Plant Image\nUnavailable',
            textAlign: pw.TextAlign.center,
            style: const pw.TextStyle(
              color: _textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // QUICK SUMMARY
  // ---------------------------------------------------------------------------

  static pw.Widget _buildQuickSummary(
      PlantResultModel plant,
      ) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _summaryCard(
            title: 'AI CONFIDENCE',
            value:
            '${plant.confidence.toStringAsFixed(1)}%',
          ),
        ),

        pw.SizedBox(width: 12),

        pw.Expanded(
          child: _summaryCard(
            title: 'PET SAFETY',
            value: plant.petSafe
                ? 'Pet Safe'
                : 'Use Caution',
          ),
        ),

        pw.SizedBox(width: 12),

        pw.Expanded(
          child: _summaryCard(
            title: 'SCAN DATE',
            value: _formatDate(
              plant.scannedAt,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _summaryCard({
    required String title,
    required String value,
  }) {
    return pw.Container(
      height: 85,
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: _primaryLight,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(
          color: _border,
        ),
      ),
      child: pw.Column(
        mainAxisAlignment:
        pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            title,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: _textSecondary,
              letterSpacing: 1,
            ),
          ),

          pw.SizedBox(height: 9),

          pw.Text(
            value,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
              color: _primary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION TITLE
  // ---------------------------------------------------------------------------

  static pw.Widget _sectionTitle(
      String title,
      String subtitle,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        top: 28,
        bottom: 12,
      ),
      child: pw.Column(
        crossAxisAlignment:
        pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 19,
              fontWeight: pw.FontWeight.bold,
              color: _textPrimary,
            ),
          ),

          pw.SizedBox(height: 4),

          pw.Text(
            subtitle,
            style: const pw.TextStyle(
              fontSize: 10,
              color: _textSecondary,
            ),
          ),

          pw.SizedBox(height: 8),

          pw.Container(
            width: 45,
            height: 3,
            decoration: pw.BoxDecoration(
              color: _primary,
              borderRadius: pw.BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PLANT INFORMATION
  // ---------------------------------------------------------------------------

  static pw.Widget _buildInformationCard(
      PlantResultModel plant,
      ) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(18),
      decoration: pw.BoxDecoration(
        color: _background,
        borderRadius: pw.BorderRadius.circular(14),
        border: pw.Border.all(
          color: _border,
        ),
      ),
      child: pw.Column(
        children: [
          _informationRow(
            'Common Name',
            plant.plantName,
          ),

          _divider(),

          _informationRow(
            'Scientific Name',
            plant.scientificName,
          ),

          _divider(),

          _informationRow(
            'AI Confidence',
            '${plant.confidence.toStringAsFixed(1)}%',
          ),

          _divider(),

          _informationRow(
            'Pet Safety',
            plant.petSafe
                ? 'Considered Pet Safe'
                : 'Use Caution Around Pets',
          ),

          _divider(),

          _informationRow(
            'Analyzed On',
            _formatDate(plant.scannedAt),
          ),
        ],
      ),
    );
  }

  static pw.Widget _informationRow(
      String title,
      String value,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: pw.Row(
        crossAxisAlignment:
        pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 130,
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: _textSecondary,
              ),
            ),
          ),

          pw.Expanded(
            child: pw.Text(
              value.isEmpty ? 'Not available' : value,
              style: const pw.TextStyle(
                fontSize: 11,
                color: _textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _divider() {
    return pw.Divider(
      color: _border,
      thickness: .5,
    );
  }

  // ---------------------------------------------------------------------------
  // CARE GRID
  // ---------------------------------------------------------------------------

  static pw.Widget _buildCareGrid(
      PlantResultModel plant,
      ) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment:
          pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: _careCard(
                'WATERING',
                plant.watering,
              ),
            ),

            pw.SizedBox(width: 12),

            pw.Expanded(
              child: _careCard(
                'SUNLIGHT',
                plant.sunlight,
              ),
            ),
          ],
        ),

        pw.SizedBox(height: 12),

        pw.Row(
          crossAxisAlignment:
          pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: _careCard(
                'SOIL',
                plant.soil,
              ),
            ),

            pw.SizedBox(width: 12),

            pw.Expanded(
              child: _careCard(
                'FERTILIZER',
                plant.fertilizer,
              ),
            ),
          ],
        ),

        pw.SizedBox(height: 12),

        pw.Row(
          crossAxisAlignment:
          pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: _careCard(
                'HUMIDITY',
                plant.humidity,
              ),
            ),

            pw.SizedBox(width: 12),

            pw.Expanded(
              child: _careCard(
                'TEMPERATURE',
                plant.temperature,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _careCard(
      String title,
      String value,
      ) {
    return pw.Container(
      constraints: const pw.BoxConstraints(
        minHeight: 95,
      ),
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(
          color: _border,
        ),
      ),
      child: pw.Column(
        crossAxisAlignment:
        pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: _primary,
              letterSpacing: .8,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(
            value.isEmpty ? 'Not available' : value,
            style: const pw.TextStyle(
              fontSize: 11,
              color: _textPrimary,
              lineSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // AI RECOMMENDATION
  // ---------------------------------------------------------------------------

  static pw.Widget _buildCareRecommendation(
      String careGuide,
      ) {
    final text = careGuide.trim();

    if (text.isEmpty) {
      return pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(18),
        decoration: pw.BoxDecoration(
          color: _primaryLight,
          borderRadius: pw.BorderRadius.circular(12),
          border: pw.Border.all(
            color: _border,
          ),
        ),
        child: pw.Text(
          'No AI care recommendation available.',
          style: const pw.TextStyle(
            fontSize: 11,
            color: _textSecondary,
          ),
        ),
      );
    }

    final paragraphs = _createCareParagraphs(text);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: const pw.BoxDecoration(
            color: _primaryLight,
            border: pw.Border(
              left: pw.BorderSide(
                color: _primary,
                width: 4,
              ),
            ),
          ),
          child: pw.Text(
            'AI GENERATED CARE GUIDANCE',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: _primary,
              letterSpacing: 1,
            ),
          ),
        ),

        pw.SizedBox(height: 12),

        ...paragraphs.map(
              (paragraph) => pw.Padding(
            padding: const pw.EdgeInsets.only(
              bottom: 10,
            ),
            child: pw.Text(
              paragraph,
              textAlign: pw.TextAlign.justify,
              style: const pw.TextStyle(
                fontSize: 11,
                color: _textPrimary,
                lineSpacing: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static List<String> _createCareParagraphs(
      String text,
      ) {
    final existingParagraphs = text
        .split(RegExp(r'\n+'))
        .map((paragraph) => paragraph.trim())
        .where((paragraph) => paragraph.isNotEmpty)
        .toList();

    if (existingParagraphs.length > 1) {
      return existingParagraphs;
    }

    final sentences = text
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((sentence) => sentence.trim())
        .where((sentence) => sentence.isNotEmpty)
        .toList();

    final List<String> paragraphs = [];

    final buffer = StringBuffer();

    for (final sentence in sentences) {
      if (buffer.length + sentence.length > 450) {
        paragraphs.add(
          buffer.toString().trim(),
        );

        buffer.clear();
      }

      buffer.write(sentence);
      buffer.write(' ');
    }

    if (buffer.isNotEmpty) {
      paragraphs.add(
        buffer.toString().trim(),
      );
    }

    return paragraphs;
  }

  // ---------------------------------------------------------------------------
  // COMMON PROBLEMS
  // ---------------------------------------------------------------------------

  static pw.Widget _buildProblems(
      List<String> problems,
      ) {
    if (problems.isEmpty) {
      return pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(18),
        decoration: pw.BoxDecoration(
          color: _primaryLight,
          borderRadius: pw.BorderRadius.circular(12),
        ),
        child: pw.Text(
          'No common problems were identified.',
          style: const pw.TextStyle(
            color: _primary,
          ),
        ),
      );
    }

    return pw.Column(
      children: problems
          .map(
            (problem) => pw.Container(
          width: double.infinity,
          margin: const pw.EdgeInsets.only(
            bottom: 10,
          ),
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            color: _dangerLight,
            borderRadius:
            pw.BorderRadius.circular(10),
            border: pw.Border.all(
              color: PdfColors.red100,
            ),
          ),
          child: pw.Row(
            crossAxisAlignment:
            pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 24,
                height: 24,
                decoration: const pw.BoxDecoration(
                  color: _danger,
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  '!',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(width: 12),

              pw.Expanded(
                child: pw.Text(
                  problem,
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: _textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // DISCLAIMER
  // ---------------------------------------------------------------------------

  static pw.Widget _buildDisclaimer() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Text(
        'AI Disclaimer: Plant identification and care recommendations are '
            'AI-generated and should be used as general guidance. Plant care '
            'requirements may vary depending on climate, environment, and plant health.',
        textAlign: pw.TextAlign.center,
        style: const pw.TextStyle(
          fontSize: 8,
          color: _textSecondary,
          lineSpacing: 3,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER / FOOTER
  // ---------------------------------------------------------------------------

  static pw.Widget _pageHeader(
      PlantResultModel plant,
      ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(
        bottom: 20,
      ),
      padding: const pw.EdgeInsets.only(
        bottom: 10,
      ),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: _border,
          ),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment:
        pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'PLANTPAL AI',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: _primary,
              letterSpacing: 1.5,
            ),
          ),
          pw.Text(
            plant.plantName,
            style: const pw.TextStyle(
              fontSize: 9,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pageFooter(
      int currentPage,
      int totalPages,
      ) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(
        top: 18,
      ),
      padding: const pw.EdgeInsets.only(
        top: 10,
      ),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(
            color: _border,
          ),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment:
        pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated by PlantPal AI | Powered by Gemini AI',
            style: const pw.TextStyle(
              fontSize: 8,
              color: _textSecondary,
            ),
          ),
          pw.Text(
            'Page $currentPage of $totalPages',
            style: const pw.TextStyle(
              fontSize: 8,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  static Future<pw.MemoryImage?> _loadPlantImage(
      String imagePath,
      ) async {
    try {
      if (imagePath.isEmpty) {
        return null;
      }

      final file = File(imagePath);

      if (!await file.exists()) {
        return null;
      }

      final Uint8List bytes =
      await file.readAsBytes();

      if (bytes.isEmpty) {
        return null;
      }

      return pw.MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  static String _formatDate(
      DateTime date,
      ) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String _sanitizeFileName(
      String name,
      ) {
    final sanitized = name
        .replaceAll(
      RegExp(r'[<>:"/\\|?*]'),
      '_',
    )
        .trim();

    if (sanitized.isEmpty) {
      return 'Plant';
    }

    return sanitized;
  }
}