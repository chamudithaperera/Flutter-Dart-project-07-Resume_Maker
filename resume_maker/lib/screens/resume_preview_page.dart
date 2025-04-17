import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/resume_data.dart';

class ResumePreviewPage extends StatelessWidget {
  final ResumeData resumeData;

  const ResumePreviewPage({super.key, required this.resumeData});

  Color get accentColor =>
      Color(int.parse(resumeData.accentColor.replaceAll('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Preview', style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _generatePDF(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header Section with Profile Picture
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Picture
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: accentColor, width: 3),
                            image: DecorationImage(
                              image:
                                  FileImage(File(resumeData.profileImagePath)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Name and Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resumeData.name,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                resumeData.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: accentColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Contact Information
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildContactItem(Icons.email, resumeData.email),
                        _buildContactItem(Icons.phone, resumeData.phone),
                        _buildContactItem(
                            Icons.location_on, resumeData.address),
                      ],
                    ),
                  ),

                  // Main Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSection(
                                'About',
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      resumeData.summary,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        height: 1.6,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              _buildSection(
                                'Work Experience',
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: resumeData.experience
                                      .map((exp) => _buildExperienceItem(exp))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 32),
                              _buildSection(
                                'Education',
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: resumeData.education
                                      .map((edu) => _buildEducationItem(edu))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Right Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSection(
                                'Skills',
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: resumeData.skills
                                      .map((skill) => _buildSkillItem(skill))
                                      .toList(),
                                ),
                              ),
                              if (resumeData.hobbies.isNotEmpty) ...[
                                const SizedBox(height: 32),
                                _buildSection(
                                  'Hobbies',
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: resumeData.hobbies.map((hobby) {
                                      return Chip(
                                        label: Text(
                                          hobby,
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                        backgroundColor:
                                            accentColor.withOpacity(0.1),
                                        side: BorderSide.none,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: accentColor),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accentColor,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 2,
          color: accentColor,
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildExperienceItem(Experience exp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.position,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                exp.company,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                exp.duration,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          if (exp.responsibilities.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...exp.responsibilities.map((responsibility) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: GoogleFonts.poppins(color: accentColor)),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationItem(Education edu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu.degree,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            edu.institution,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${edu.duration} • ${edu.location}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(Skill skill) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Container(
                width: 24,
                height: 4,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: index < skill.rating
                      ? accentColor
                      : accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
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
              _buildPDFSection(
                'Professional Summary',
                [pw.Text(resumeData.summary)],
              ),

              // Experience
              _buildPDFSection(
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
              ),

              // Education
              _buildPDFSection(
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
              ),

              // Skills
              _buildPDFSection(
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
              ),

              // Hobbies
              if (resumeData.hobbies.isNotEmpty)
                _buildPDFSection(
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

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'PDF saved to: ${file.path}',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving PDF: $e', style: GoogleFonts.poppins()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  pw.Widget _buildPDFSection(String title, List<pw.Widget> content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 16),
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex(resumeData.accentColor),
          ),
        ),
        pw.Container(
          width: 32,
          height: 2,
          margin: const pw.EdgeInsets.symmetric(vertical: 8),
          color: PdfColor.fromHex(resumeData.accentColor),
        ),
        ...content,
        pw.SizedBox(height: 16),
      ],
    );
  }
}
