import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../models/resume_data.dart';

class PDFService {
  static Future<File> generateResume(ResumeData resumeData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with name
              pw.Center(
                child: pw.Text(
                  resumeData.name,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Contact Information
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(resumeData.address),
                  pw.SizedBox(width: 20),
                  pw.Text(resumeData.contactNumber),
                  pw.SizedBox(width: 20),
                  pw.Text(resumeData.email),
                ],
              ),
              pw.SizedBox(height: 30),

              // Education Section
              pw.Text(
                'Education',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              ...resumeData.education.map((edu) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        edu.institution,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('${edu.degree} - ${edu.graduationYear}'),
                      pw.SizedBox(height: 10),
                    ],
                  )),
              pw.SizedBox(height: 20),

              // Experience Section
              pw.Text(
                'Experience',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              ...resumeData.experience.map((exp) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        exp.company,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('${exp.position} (${exp.duration})'),
                      pw.Text(exp.description),
                      pw.SizedBox(height: 10),
                    ],
                  )),
            ],
          );
        },
      ),
    );

    // Get the application documents directory
    final dir = await getApplicationDocumentsDirectory();
    final String path = '${dir.path}/resume.pdf';

    // Save the PDF file
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
