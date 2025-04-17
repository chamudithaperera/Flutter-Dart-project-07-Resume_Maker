import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/template_service.dart';
import 'template_cover_page.dart';

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
  const SelectTemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Template',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: 4,
        itemBuilder: (context, index) {
          final templates = [
            {
              'title': 'Modern',
              'description':
                  'Clean and contemporary design with a focus on readability',
              'color': Colors.blue,
            },
            {
              'title': 'Professional',
              'description': 'Traditional layout with a professional touch',
              'color': Colors.green,
            },
            {
              'title': 'Creative',
              'description': 'Unique design for creative professionals',
              'color': Colors.purple,
            },
            {
              'title': 'Minimal',
              'description':
                  'Simple and elegant design with minimal distractions',
              'color': Colors.orange,
            },
          ];

          final template = templates[index];
          return _buildTemplateCard(
            context,
            template['title'] as String,
            template['description'] as String,
            template['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    String title,
    String description,
    Color accentColor,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemplateCoverPage(
                templateName: title,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 9 / 12,
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: ResumePreviewCard(
                    accentColor:
                        '#${accentColor.value.toRadixString(16).substring(2)}',
                    templateName: title,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
