import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/template_service.dart';
import 'resume_form_page.dart';

class TemplateCoverPage extends StatelessWidget {
  final String templateName;
  final TemplateService _templateService = TemplateService();

  TemplateCoverPage({super.key, required this.templateName});

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final template = _templateService.getTemplate(templateName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Template Preview'),
        backgroundColor: template.accentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              template.coverImage,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: template.accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    template.description,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Features',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...template.features.map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: template.accentColor, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              feature,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumeFormPage(
                            templateName: template.name,
                            accentColor: _colorToHex(template.accentColor),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: template.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Use This Template',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
}
