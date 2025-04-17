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

    switch (templateName) {
      case 'Modern':
        return _buildModernTemplate(color);
      case 'Professional':
        return _buildProfessionalTemplate(color);
      case 'Creative':
        return _buildCreativeTemplate(color);
      case 'Minimal':
        return _buildMinimalTemplate(color);
      default:
        return _buildModernTemplate(color);
    }
  }

  Widget _buildModernTemplate(Color color) {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                    border: Border.all(color: color, width: 1),
                  ),
                  child: Icon(Icons.person, color: color, size: 10),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Johnson',
                        style: GoogleFonts.poppins(
                          fontSize: 7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Senior UX Designer',
                        style: GoogleFonts.poppins(
                          fontSize: 5,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email, size: 5, color: color),
                const SizedBox(width: 2),
                Text(
                  'sarah@design.com',
                  style: GoogleFonts.poppins(fontSize: 5),
                ),
                const SizedBox(width: 4),
                Icon(Icons.phone, size: 5, color: color),
                const SizedBox(width: 2),
                Text(
                  '(555) 123-4567',
                  style: GoogleFonts.poppins(fontSize: 5),
                ),
              ],
            ),
            Divider(color: color.withOpacity(0.2), height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection('Experience', color),
                      const SizedBox(height: 2),
                      _buildExperienceItem(
                          'Lead UX Designer', 'Design Studio Inc.', color),
                      _buildExperienceItem(
                          'UX Designer', 'Tech Solutions', color),
                      const SizedBox(height: 2),
                      _buildSection('Education', color),
                      const SizedBox(height: 2),
                      _buildExperienceItem(
                          'Master in HCI', 'Design University', color),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
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
                          _buildSkillChip('UI/UX', color),
                          _buildSkillChip('Figma', color),
                          _buildSkillChip('Adobe XD', color),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalTemplate(Color color) {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: color, width: 1),
                  bottom: BorderSide(color: color, width: 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'MICHAEL ANDERSON',
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Financial Analyst',
                    style: GoogleFonts.poppins(
                      fontSize: 5,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 5, color: color),
                const SizedBox(width: 2),
                Text(
                  'michael@finance.com',
                  style: GoogleFonts.poppins(fontSize: 5),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 1,
                  height: 5,
                  color: color,
                ),
                Icon(Icons.phone, size: 5, color: color),
                const SizedBox(width: 2),
                Text(
                  '(555) 987-6543',
                  style: GoogleFonts.poppins(fontSize: 5),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildProfessionalSection(
                'Experience',
                [
                  _buildProfessionalItem(
                      'Senior Financial Analyst', 'Global Investments', color),
                  _buildProfessionalItem(
                      'Financial Analyst', 'Banking Corp', color),
                ],
                color),
            const SizedBox(height: 2),
            _buildProfessionalSection(
                'Skills',
                [
                  Wrap(
                    spacing: 2,
                    children: [
                      _buildProfessionalSkill('Financial Modeling', color),
                      _buildProfessionalSkill('Data Analysis', color),
                    ],
                  ),
                ],
                color),
          ],
        ),
      ),
    );
  }

  Widget _buildCreativeTemplate(Color color) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 8,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(Icons.email, size: 6, color: color),
                const SizedBox(height: 4),
                Icon(Icons.phone, size: 6, color: color),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alex Rivera',
                    style: GoogleFonts.poppins(
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Creative Director',
                    style: GoogleFonts.poppins(
                      fontSize: 5,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildCreativeSection('Skills', color),
                  Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    children: [
                      _buildCreativeSkill('Branding', color),
                      _buildCreativeSkill('Design', color),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildCreativeSection('Experience', color),
                  _buildCreativeItem(
                      'Creative Director', 'Design Agency', color),
                  _buildCreativeItem('Art Director', 'Creative Studio', color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalTemplate(Color color) {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emily Chen',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Marketing Manager',
              style: GoogleFonts.poppins(
                fontSize: 5,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            _buildMinimalSection('Experience', [
              _buildMinimalItem('Marketing Manager', 'Tech Startup'),
              _buildMinimalItem('Digital Marketing Lead', 'E-commerce'),
            ]),
            const SizedBox(height: 4),
            _buildMinimalSection('Skills', [
              Wrap(
                spacing: 2,
                runSpacing: 2,
                children: [
                  _buildMinimalSkill('Digital Marketing'),
                  _buildMinimalSkill('Social Media'),
                  _buildMinimalSkill('Analytics'),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // Helper widgets for Professional template
  Widget _buildProfessionalSection(
      String title, List<Widget> children, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildProfessionalItem(String title, String subtitle, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 6, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 6, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildProfessionalSkill(String skill, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(fontSize: 6, color: color),
      ),
    );
  }

  // Helper widgets for Creative template
  Widget _buildCreativeSection(String title, Color color) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.poppins(
        fontSize: 7,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildCreativeItem(String title, String subtitle, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 6, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 6, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildCreativeSkill(String skill, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(fontSize: 6, color: color),
      ),
    );
  }

  // Helper widgets for Minimal template
  Widget _buildMinimalSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 7,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 2),
        ...children,
      ],
    );
  }

  Widget _buildMinimalItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 6),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: 6, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildMinimalSkill(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        skill,
        style: GoogleFonts.poppins(fontSize: 6),
      ),
    );
  }

  // Common helper widgets
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
  const SelectTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Select Template',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Template',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select a template that best represents your professional style',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final templates = [
                    {
                      'name': 'Modern',
                      'type': 'Modern',
                      'new': true,
                      'color': const Color(0xFF2196F3),
                      'description':
                          'Clean and contemporary design with a focus on readability',
                      'icon': Icons.design_services,
                    },
                    {
                      'name': 'Professional',
                      'type': 'Professional',
                      'new': false,
                      'color': const Color(0xFF4CAF50),
                      'description':
                          'Traditional layout with a professional touch',
                      'icon': Icons.business_center,
                    },
                    {
                      'name': 'Creative',
                      'type': 'Creative',
                      'new': true,
                      'color': const Color(0xFF9C27B0),
                      'description': 'Unique design for creative professionals',
                      'icon': Icons.palette,
                    },
                    {
                      'name': 'Minimal',
                      'type': 'Minimal',
                      'new': false,
                      'color': const Color(0xFF607D8B),
                      'description':
                          'Simple and elegant design with minimal distractions',
                      'icon': Icons.format_shapes,
                    },
                  ];
                  final template = templates[index];
                  return _buildTemplateCard(
                    context,
                    template['name'] as String,
                    template['type'] as String,
                    template['new'] as bool,
                    template['color'] as Color,
                    template['description'] as String,
                    template['icon'] as IconData,
                  );
                },
                childCount: 4,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    String name,
    String type,
    bool isNew,
    Color color,
    String description,
    IconData icon,
  ) {
    return Hero(
      tag: 'template_$name',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TemplateCoverPage(templateName: name),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: ResumePreviewCard(
                              accentColor:
                                  '#${color.value.toRadixString(16).substring(2)}',
                              templateName: name,
                            ),
                          ),
                        ),
                        if (isNew)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'NEW',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            icon,
                            size: 20,
                            color: color,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: color,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Use Template',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
