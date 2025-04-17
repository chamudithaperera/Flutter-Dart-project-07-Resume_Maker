import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import '../models/resume_data.dart';
import '../services/pdf_service.dart';

class ColorTheme {
  final String name;
  final String color;
  final IconData icon;

  const ColorTheme({
    required this.name,
    required this.color,
    required this.icon,
  });
}

class ResumePreviewPage extends StatefulWidget {
  final ResumeData resumeData;

  const ResumePreviewPage({super.key, required this.resumeData});

  @override
  State<ResumePreviewPage> createState() => _ResumePreviewPageState();
}

class _ResumePreviewPageState extends State<ResumePreviewPage> {
  final List<ColorTheme> colorThemes = [
    ColorTheme(
      name: 'Professional Blue',
      color: '#2B547E',
      icon: Icons.business,
    ),
    ColorTheme(
      name: 'Forest Green',
      color: '#2E8B57',
      icon: Icons.nature,
    ),
    ColorTheme(
      name: 'Royal Purple',
      color: '#7851A9',
      icon: Icons.style,
    ),
    ColorTheme(
      name: 'Deep Maroon',
      color: '#800000',
      icon: Icons.format_color_fill,
    ),
    ColorTheme(
      name: 'Charcoal Gray',
      color: '#36454F',
      icon: Icons.contrast,
    ),
  ];

  late String currentThemeColor;

  @override
  void initState() {
    super.initState();
    currentThemeColor = widget.resumeData.accentColor;
  }

  Color get accentColor =>
      Color(int.parse(currentThemeColor.replaceAll('#', '0xFF')));

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 16),
              child: Text(
                'Select Color Theme',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colorThemes.length,
                itemBuilder: (context, index) {
                  final theme = colorThemes[index];
                  final isSelected = currentThemeColor == theme.color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentThemeColor = theme.color;
                        // Create a new ResumeData instance with the new color
                        final updatedResumeData = ResumeData(
                          name: widget.resumeData.name,
                          title: widget.resumeData.title,
                          email: widget.resumeData.email,
                          phone: widget.resumeData.phone,
                          address: widget.resumeData.address,
                          profileImagePath: widget.resumeData.profileImagePath,
                          summary: widget.resumeData.summary,
                          skills: widget.resumeData.skills,
                          education: widget.resumeData.education,
                          experience: widget.resumeData.experience,
                          hobbies: widget.resumeData.hobbies,
                          accentColor: theme.color,
                        );
                        // Replace the current page with a new one containing the updated data
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumePreviewPage(
                              resumeData: updatedResumeData,
                            ),
                          ),
                        );
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(
                                int.parse(theme.color.replaceAll('#', '0xFF')))
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(
                              int.parse(theme.color.replaceAll('#', '0xFF'))),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            theme.icon,
                            color: Color(
                                int.parse(theme.color.replaceAll('#', '0xFF'))),
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            theme.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Color(int.parse(
                                  theme.color.replaceAll('#', '0xFF'))),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate A4 size ratio (width:height = 1:√2)
    final screenWidth = MediaQuery.of(context).size.width;
    final pageWidth =
        screenWidth > 595 ? 595.0 : screenWidth - 32; // max A4 width in points
    final pageHeight = pageWidth * 1.4142; // A4 ratio

    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Preview', style: GoogleFonts.poppins()),
        actions: [
          // Color theme button
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => _showThemeSelector(context),
          ),
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // Download button
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _generatePDF(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: pageWidth,
              height: pageHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with profile picture and name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.resumeData.profileImagePath.isNotEmpty)
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: accentColor, width: 2),
                                image: DecorationImage(
                                  image: FileImage(
                                      File(widget.resumeData.profileImagePath)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.resumeData.name,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.resumeData.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: accentColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Contact Information
                      Container(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children: [
                            _buildContactItem(
                                Icons.email, widget.resumeData.email),
                            _buildContactItem(
                                Icons.phone, widget.resumeData.phone),
                            _buildContactItem(
                                Icons.location_on, widget.resumeData.address),
                          ],
                        ),
                      ),

                      // Social Media Links
                      if (widget.resumeData.socialMedia.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.start,
                            children: [
                              if (widget.resumeData.socialMedia['linkedin'] !=
                                  null)
                                _buildContactItem(
                                  FontAwesomeIcons.linkedin,
                                  widget.resumeData.socialMedia['linkedin']!,
                                  isBrandIcon: true,
                                ),
                              if (widget.resumeData.socialMedia['github'] !=
                                  null)
                                _buildContactItem(
                                  FontAwesomeIcons.github,
                                  widget.resumeData.socialMedia['github']!,
                                  isBrandIcon: true,
                                ),
                              if (widget.resumeData.socialMedia['twitter'] !=
                                  null)
                                _buildContactItem(
                                  FontAwesomeIcons.twitter,
                                  widget.resumeData.socialMedia['twitter']!,
                                  isBrandIcon: true,
                                ),
                              if (widget.resumeData.socialMedia['portfolio'] !=
                                  null)
                                _buildContactItem(
                                  FontAwesomeIcons.globe,
                                  widget.resumeData.socialMedia['portfolio']!,
                                  isBrandIcon: true,
                                ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Two-column layout for content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column (Experience and Education)
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSection(
                                  'Professional Summary',
                                  Text(
                                    widget.resumeData.summary,
                                    style: GoogleFonts.poppins(fontSize: 10),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildSection(
                                  'Experience',
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget.resumeData.experience
                                        .map((exp) => _buildExperienceItem(exp))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildSection(
                                  'Education',
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget.resumeData.education
                                        .map((edu) => _buildEducationItem(edu))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Right column (Skills and Hobbies)
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSection(
                                  'Skills',
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget.resumeData.skills
                                        .map((skill) => _buildSkillItem(skill))
                                        .toList(),
                                  ),
                                ),
                                if (widget.resumeData.hobbies.isNotEmpty) ...[
                                  const SizedBox(height: 16),
                                  _buildSection(
                                    'Hobbies',
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: widget.resumeData.hobbies
                                          .map((hobby) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: accentColor.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            hobby,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10),
                                          ),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text,
      {bool isBrandIcon = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isBrandIcon
            ? FaIcon(icon, size: 14, color: accentColor)
            : Icon(icon, size: 14, color: accentColor),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 10),
            overflow: TextOverflow.ellipsis,
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
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: accentColor,
            letterSpacing: 1,
          ),
        ),
        Container(
          width: 32,
          height: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: accentColor,
        ),
        content,
      ],
    );
  }

  Widget _buildExperienceItem(Experience exp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.position,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${exp.company} • ${exp.duration}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            exp.location,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (exp.responsibilities.isNotEmpty) ...[
            const SizedBox(height: 4),
            ...exp.responsibilities.map(
              (resp) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: GoogleFonts.poppins(color: accentColor)),
                    Expanded(
                      child: Text(
                        resp,
                        style: GoogleFonts.poppins(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationItem(Education edu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu.degree,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            edu.institution,
            style: GoogleFonts.poppins(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${edu.duration} • ${edu.location}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(Skill skill) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.name,
            style: GoogleFonts.poppins(fontSize: 10),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Container(
                width: 16,
                height: 3,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: index < skill.rating
                      ? accentColor
                      : accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    try {
      final path = await PDFService.generateResume(widget.resumeData);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved to: $path'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
