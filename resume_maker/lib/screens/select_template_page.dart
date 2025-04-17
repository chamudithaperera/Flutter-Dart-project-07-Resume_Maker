import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resume_form_page.dart';

class ResumePreviewCard extends StatelessWidget {
  final String accentColor;
  final String templateName;

  const ResumePreviewCard({
    super.key,
    required this.accentColor,
    required this.templateName,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(accentColor.replaceAll('#', '0xFF')));

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: Icon(Icons.person, color: color, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Software Developer',
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Contact Info
            Wrap(
              spacing: 4,
              runSpacing: 2,
              children: [
                _buildContactItem(Icons.email, 'john@example.com', 8),
                _buildContactItem(Icons.phone, '+1 234 567 890', 8),
                _buildContactItem(Icons.location_on, 'New York, USA', 8),
              ],
            ),
            const SizedBox(height: 8),

            // Experience Preview
            Text(
              'EXPERIENCE',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            _buildExperienceItem(
              'Senior Developer',
              'Tech Corp',
              '2020 - Present',
              8,
            ),
            const SizedBox(height: 6),

            // Skills Preview
            Text(
              'SKILLS',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: [
                _buildSkillChip('Flutter', color, 8),
                _buildSkillChip('Dart', color, 8),
                _buildSkillChip('Firebase', color, 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: fontSize),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(
    String title,
    String company,
    String duration,
    double fontSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$company • $duration',
          style: GoogleFonts.poppins(
            fontSize: fontSize - 1,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, Color color, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(
          fontSize: fontSize - 1,
          color: color,
        ),
      ),
    );
  }
}

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
          ),
          _buildTemplateCard(
            context,
            'Professional',
            'Traditional layout with a professional look',
            '#2E7D32',
          ),
          _buildTemplateCard(
            context,
            'Creative',
            'Unique design for creative professionals',
            '#C2185B',
          ),
          _buildTemplateCard(
            context,
            'Minimal',
            'Simple and elegant design',
            '#455A64',
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
            // Preview image - 80% height
            Expanded(
              flex: 8,
              child: ResumePreviewCard(
                accentColor: accentColor,
                templateName: title,
              ),
            ),
            // Template name - 10% height
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Template category - 10% height
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
