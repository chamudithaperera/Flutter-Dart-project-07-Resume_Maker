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
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Back',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _currentStep == 5 ? 'Create Resume' : 'Next',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          steps: [
            // Basic Information
            Step(
              title: Text('Basic Information', style: GoogleFonts.poppins()),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Full Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: _inputDecoration('Address'),
                    maxLines: 2,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
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
                    var controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              decoration: _inputDecoration('Contact Number'),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a contact number';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_contactControllers.length > 1)
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                              onPressed: () => _removeContact(idx),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addContact,
                    icon: const Icon(Icons.add),
                    label: Text('Add Contact', style: GoogleFonts.poppins()),
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
                    var social = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: social.platformController,
                                  decoration: _inputDecoration('Platform Name'),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter platform name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_socialMedia.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: Colors.red,
                                  onPressed: () => _removeSocialMedia(idx),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: social.urlController,
                            decoration: _inputDecoration('Profile URL'),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter profile URL';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addSocialMedia,
                    icon: const Icon(Icons.add),
                    label: Text(
                      'Add Social Media',
                      style: GoogleFonts.poppins(),
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
                    var education = entry.value;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Education ${idx + 1}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (_education.length > 1)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    color: Colors.red,
                                    onPressed: () => _removeEducation(idx),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: education.timeController,
                              decoration: _inputDecoration('Time Period'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter time period';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: education.qualificationController,
                              decoration: _inputDecoration('Qualification'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter qualification';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: education.instituteController,
                              decoration: _inputDecoration('Institute'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter institute';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addEducation,
                    icon: const Icon(Icons.add),
                    label: Text('Add Education', style: GoogleFonts.poppins()),
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
                    var experience = entry.value;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Experience ${idx + 1}',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (_experience.length > 1)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    color: Colors.red,
                                    onPressed: () => _removeExperience(idx),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: experience.timeController,
                              decoration: _inputDecoration('Time Period'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter time period';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: experience.positionController,
                              decoration: _inputDecoration('Position'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter position';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: experience.companyController,
                              decoration: _inputDecoration('Company'),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter company';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addExperience,
                    icon: const Icon(Icons.add),
                    label: Text('Add Experience', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
              isActive: _currentStep >= 4,
            ),

            // Review
            Step(
              title: Text('Review', style: GoogleFonts.poppins()),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please review your information before creating the resume.',
                    style: GoogleFonts.poppins(fontSize: 16),
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
