class ResumeData {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String address;
  final String profileImagePath;
  final String summary;
  final List<Skill> skills;
  final List<Education> education;
  final List<Experience> experience;
  final List<String> hobbies;
  final String accentColor;
  final Map<String, String> socialMedia;

  ResumeData({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.address,
    required this.profileImagePath,
    required this.summary,
    required this.skills,
    required this.education,
    required this.experience,
    this.hobbies = const [],
    this.accentColor = '#FFA726',
    this.socialMedia = const {},
  });
}

class Skill {
  final String name;
  final int rating; // Rating from 1-5
  final String category; // e.g., "Technical", "Soft Skills", etc.

  Skill({
    required this.name,
    required this.rating,
    this.category = '',
  });
}

class Education {
  final String degree;
  final String institution;
  final String duration;
  final String location;

  Education({
    required this.degree,
    required this.institution,
    required this.duration,
    required this.location,
  });
}

class Experience {
  final String position;
  final String company;
  final String duration;
  final String location;
  final List<String> responsibilities;

  Experience({
    required this.position,
    required this.company,
    required this.duration,
    required this.location,
    this.responsibilities = const [],
  });
}
