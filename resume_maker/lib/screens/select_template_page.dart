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
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color, width: 1),
                ),
                child: Icon(Icons.person, color: color, size: 12),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Software Developer',
                      style: GoogleFonts.poppins(
                        fontSize: 6,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Contact Info
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.email, size: 6, color: color),
              const SizedBox(width: 2),
              Text(
                'john@example.com',
                style: GoogleFonts.poppins(fontSize: 6),
              ),
            ],
          ),

          Divider(color: color.withOpacity(0.2), height: 8),

          // Two Column Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('Experience', color),
                    const SizedBox(height: 2),
                    _buildExperienceItem(
                      'Senior Developer',
                      'Tech Corp',
                      color,
                    ),
                    const SizedBox(height: 4),
                    _buildSection('Education', color),
                    const SizedBox(height: 2),
                    _buildExperienceItem(
                      'Computer Science',
                      'Tech University',
                      color,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Right Column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('Skills', color),
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: 2,
                      runSpacing: 2,
                      children: [
                        _buildSkillChip('Flutter', color),
                        _buildSkillChip('React', color),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _buildSection('Hobbies', color),
                    const SizedBox(height: 2),
                    Text(
                      'Photography',
                      style: GoogleFonts.poppins(fontSize: 6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 6,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          height: 1,
          width: 12,
          color: color,
        ),
      ],
    );
  }

  Widget _buildExperienceItem(String title, String subtitle, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 6,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 6,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(
          fontSize: 6,
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
