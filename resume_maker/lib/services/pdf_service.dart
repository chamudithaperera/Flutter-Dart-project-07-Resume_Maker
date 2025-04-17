import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../models/resume_data.dart';

class PDFService {
  static Future<String> generateResume(ResumeData resumeData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (resumeData.profileImagePath.isNotEmpty)
                    pw.Container(
                      width: 100,
                      height: 100,
                      margin: const pw.EdgeInsets.only(right: 20),
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        image: pw.DecorationImage(
                          image: pw.MemoryImage(
                            File(resumeData.profileImagePath).readAsBytesSync(),
                          ),
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          resumeData.name,
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          resumeData.title,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex(resumeData.accentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Contact Information
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text(resumeData.email),
                  pw.Text(resumeData.phone),
                  pw.Text(resumeData.address),
                ],
              ),

              pw.SizedBox(height: 20),

              // Professional Summary
              _buildSection(
                'Professional Summary',
                [pw.Text(resumeData.summary)],
                resumeData.accentColor,
              ),

              // Experience
              _buildSection(
                'Experience',
                resumeData.experience.map((exp) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        exp.position,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('${exp.company} • ${exp.duration}'),
                      pw.Text(exp.location),
                      if (exp.responsibilities.isNotEmpty) ...[
                        pw.SizedBox(height: 4),
                        ...exp.responsibilities.map(
                          (resp) => pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 12),
                            child: pw.Text('• $resp'),
                          ),
                        ),
                      ],
                      pw.SizedBox(height: 8),
                    ],
                  );
                }).toList(),
                resumeData.accentColor,
              ),

              // Education
              _buildSection(
                'Education',
                resumeData.education.map((edu) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        edu.degree,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(edu.institution),
                      pw.Text('${edu.duration} • ${edu.location}'),
                      pw.SizedBox(height: 8),
                    ],
                  );
                }).toList(),
                resumeData.accentColor,
              ),

              // Skills
              _buildSection(
                'Skills',
                [
                  pw.Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: resumeData.skills.map((skill) {
                      return pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(4),
                          color: PdfColor.fromHex(resumeData.accentColor)
                              .shade(0.1),
                        ),
                        child: pw.Text(
                          '${skill.name} ${List.filled(skill.rating, '★').join()}',
                        ),
                      );
                    }).toList(),
                  ),
                ],
                resumeData.accentColor,
              ),

              // Hobbies
              if (resumeData.hobbies.isNotEmpty)
                _buildSection(
                  'Hobbies',
                  [
                    pw.Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: resumeData.hobbies.map((hobby) {
                        return pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(4),
                            color: PdfColor.fromHex(resumeData.accentColor)
                                .shade(0.1),
                          ),
                          child: pw.Text(hobby),
                        );
                      }).toList(),
                    ),
                  ],
                  resumeData.accentColor,
                ),
            ],
          );
        },
      ),
    );

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/resume.pdf');
      await file.writeAsBytes(await pdf.save());
      return file.path;
    } catch (e) {
      throw Exception('Error saving PDF: $e');
    }
  }

  static pw.Widget _buildSection(
    String title,
    List<pw.Widget> content,
    String accentColor,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 16),
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex(accentColor),
          ),
        ),
        pw.Container(
          width: 32,
          height: 2,
          margin: const pw.EdgeInsets.symmetric(vertical: 8),
          color: PdfColor.fromHex(accentColor),
        ),
        ...content,
        pw.SizedBox(height: 16),
      ],
    );
  }
}
