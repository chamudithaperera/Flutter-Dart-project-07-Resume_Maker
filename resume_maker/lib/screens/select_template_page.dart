import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resume_form_page.dart';

class SelectTemplatePage extends StatelessWidget {
  const SelectTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Template', style: GoogleFonts.poppins()),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildTemplateCard(
            context,
            'Modern',
            'A clean and modern design with a sidebar',
            '#1E88E5',
            'assets/images/template1.png',
          ),
          _buildTemplateCard(
            context,
            'Professional',
            'Traditional layout with a professional look',
            '#2E7D32',
            'assets/images/template2.png',
          ),
          _buildTemplateCard(
            context,
            'Creative',
            'Unique design for creative professionals',
            '#C2185B',
            'assets/images/template3.png',
          ),
          _buildTemplateCard(
            context,
            'Minimal',
            'Simple and elegant design',
            '#455A64',
            'assets/images/template4.png',
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    String title,
    String description,
    String accentColor,
    String imagePath,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResumeFormPage(
                templateName: title,
                accentColor: accentColor,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(accentColor.replaceAll('#', '0xFF')))
                      .withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.description,
                    size: 64,
                    color:
                        Color(int.parse(accentColor.replaceAll('#', '0xFF'))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
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
