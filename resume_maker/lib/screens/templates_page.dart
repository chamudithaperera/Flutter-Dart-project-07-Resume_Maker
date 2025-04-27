import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'select_template_page.dart';
import 'template_cover_page.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Templates',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search templates',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[400],
                    ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Template Categories
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildCategoryChip('All'),
              _buildCategoryChip('Professional'),
              _buildCategoryChip('Modern'),
              _buildCategoryChip('Creative'),
              _buildCategoryChip('Minimal'),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Templates Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final templates = [
                {
                  'name': 'Modern',
                  'type': 'Modern',
                  'color': const Color(0xFF2196F3),
                  'description': 'Clean and contemporary design',
                },
                {
                  'name': 'Professional',
                  'type': 'Professional',
                  'color': const Color(0xFF4CAF50),
                  'description': 'Traditional layout',
                },
                {
                  'name': 'Creative',
                  'type': 'Creative',
                  'color': const Color(0xFF9C27B0),
                  'description': 'Unique design for creatives',
                },
                {
                  'name': 'Minimal',
                  'type': 'Minimal',
                  'color': const Color(0xFF607D8B),
                  'description': 'Simple and elegant design',
                },
              ];
              final template = templates[index];
              return _buildTemplateCard(
                template['name'] as String,
                template['type'] as String,
                template['color'] as Color,
                template['description'] as String,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: FilterChip(
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedCategory = label;
            });
          },
          label: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? Colors.white : Colors.grey[800],
                ),
          ),
          backgroundColor: Colors.white,
          selectedColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildTemplateCard(
    String name,
    String type,
    Color color,
    String description,
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
                  color: color.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
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
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: color,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getTemplateIcon(name),
                                color: color,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TemplateCoverPage(templateName: name),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: color.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Use Template',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: color,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: color,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTemplateIcon(String templateName) {
    switch (templateName) {
      case 'Modern':
        return Icons.design_services_rounded;
      case 'Professional':
        return Icons.business_center_rounded;
      case 'Creative':
        return Icons.palette_rounded;
      case 'Minimal':
        return Icons.format_shapes_rounded;
      default:
        return Icons.description_rounded;
    }
  }
}
