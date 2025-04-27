import 'package:flutter/material.dart';

class Template {
  final String name;
  final String description;
  final String coverImage;
  final List<String> features;
  final Color accentColor;

  const Template({
    required this.name,
    required this.description,
    required this.coverImage,
    required this.features,
    required this.accentColor,
  });
}

class TemplateService {
  final Map<String, Template> _templates = {
    'Modern': const Template(
      name: 'Modern',
      description:
          'A clean and contemporary design with a focus on readability and visual hierarchy.',
      coverImage: 'assets/images/templates/modern_template.png',
      features: [
        'Clean and minimalist layout',
        'Professional typography',
        'Skill rating visualization',
        'Modern color scheme',
      ],
      accentColor: Color(0xFF2196F3),
    ),
    'Professional': const Template(
      name: 'Professional',
      description:
          'A traditional resume layout optimized for ATS systems and formal applications.',
      coverImage: 'assets/images/templates/professional_template.png',
      features: [
        'ATS-friendly format',
        'Clear section separation',
        'Traditional layout',
        'Professional styling',
      ],
      accentColor: Color(0xFF4CAF50),
    ),
    'Creative': const Template(
      name: 'Creative',
      description:
          'A unique and eye-catching design for creative professionals and portfolios.',
      coverImage: 'assets/images/templates/creative_template.png',
      features: [
        'Unique layout design',
        'Visual elements integration',
        'Creative typography',
        'Dynamic content placement',
      ],
      accentColor: Color(0xFF9C27B0),
    ),
    'Minimal': const Template(
      name: 'Minimal',
      description:
          'A simple and elegant design that puts focus on your content.',
      coverImage: 'assets/images/templates/minimal_template.png',
      features: [
        'Simplified layout',
        'Essential information focus',
        'Clean typography',
        'Subtle accents',
      ],
      accentColor: Color(0xFF607D8B),
    ),
  };

  Template getTemplate(String templateName) {
    return _templates[templateName] ?? _templates['Modern']!;
  }

  List<Template> getAllTemplates() {
    return _templates.values.toList();
  }
}
