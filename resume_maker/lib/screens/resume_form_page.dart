import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumeFormPage extends StatefulWidget {
  final String templateName;

  const ResumeFormPage({super.key, required this.templateName});

  @override
  State<ResumeFormPage> createState() => _ResumeFormPageState();
}

class _ResumeFormPageState extends State<ResumeFormPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  List<TextEditingController> _contactControllers = [TextEditingController()];
  List<SocialMedia> _socialMedia = [SocialMedia()];
  List<Education> _education = [Education()];
  List<Experience> _experience = [Experience()];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    for (var controller in _contactControllers) {
      controller.dispose();
    }
    for (var social in _socialMedia) {
      social.dispose();
    }
    for (var edu in _education) {
      edu.dispose();
    }
    for (var exp in _experience) {
      exp.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Resume',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 5) {
              setState(() {
                _currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            // Personal Information
            Step(
              title: Text('Personal Information', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),

            // Contact Numbers
            Step(
              title: Text('Contact Numbers', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  ..._contactControllers.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: entry.value,
                              decoration: InputDecoration(
                                labelText: 'Contact Number ${idx + 1}',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_contactControllers.length > 1)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeContact(idx),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                  ElevatedButton.icon(
                    onPressed: _addContact,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Contact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 1,
            ),

            // Social Media
            Step(
              title: Text('Social Media', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  ..._socialMedia.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: entry.value.platformController,
                                  decoration: InputDecoration(
                                    labelText: 'Platform Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_socialMedia.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeSocialMedia(idx),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: entry.value.urlController,
                            decoration: InputDecoration(
                              labelText: 'URL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  ElevatedButton.icon(
                    onPressed: _addSocialMedia,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Social Media'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),

            // Education
            Step(
              title: Text('Education', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  ..._education.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: entry.value.timeController,
                                      decoration: InputDecoration(
                                        labelText: 'Time Period',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: entry.value.qualificationController,
                                      decoration: InputDecoration(
                                        labelText: 'Qualification',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: entry.value.instituteController,
                                      decoration: InputDecoration(
                                        labelText: 'Institute',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_education.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeEducation(idx),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  ElevatedButton.icon(
                    onPressed: _addEducation,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Education'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),

            // Experience
            Step(
              title: Text('Experience', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  ..._experience.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: entry.value.timeController,
                                      decoration: InputDecoration(
                                        labelText: 'Time Period',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: entry.value.positionController,
                                      decoration: InputDecoration(
                                        labelText: 'Position',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: entry.value.companyController,
                                      decoration: InputDecoration(
                                        labelText: 'Company',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_experience.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeExperience(idx),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  ElevatedButton.icon(
                    onPressed: _addExperience,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Experience'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 4,
            ),

            // Review
            Step(
              title: Text('Review', style: GoogleFonts.poppins()),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Review your information',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Generate resume
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Generate Resume',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 5,
            ),
          ],
        ),
      ),
    );
  }

  void _addContact() {
    setState(() {
      _contactControllers.add(TextEditingController());
    });
  }

  void _removeContact(int index) {
    setState(() {
      _contactControllers[index].dispose();
      _contactControllers.removeAt(index);
    });
  }

  void _addSocialMedia() {
    setState(() {
      _socialMedia.add(SocialMedia());
    });
  }

  void _removeSocialMedia(int index) {
    setState(() {
      _socialMedia[index].dispose();
      _socialMedia.removeAt(index);
    });
  }

  void _addEducation() {
    setState(() {
      _education.add(Education());
    });
  }

  void _removeEducation(int index) {
    setState(() {
      _education[index].dispose();
      _education.removeAt(index);
    });
  }

  void _addExperience() {
    setState(() {
      _experience.add(Experience());
    });
  }

  void _removeExperience(int index) {
    setState(() {
      _experience[index].dispose();
      _experience.removeAt(index);
    });
  }
}

class SocialMedia {
  final TextEditingController platformController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  void dispose() {
    platformController.dispose();
    urlController.dispose();
  }
}

class Education {
  final TextEditingController timeController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();

  void dispose() {
    timeController.dispose();
    qualificationController.dispose();
    instituteController.dispose();
  }
}

class Experience {
  final TextEditingController timeController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  void dispose() {
    timeController.dispose();
    positionController.dispose();
    companyController.dispose();
  }
} 