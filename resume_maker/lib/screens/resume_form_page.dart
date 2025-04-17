import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/resume_data.dart';
import 'resume_preview_page.dart';

class ResumeFormPage extends StatefulWidget {
  final String templateName;
  final String accentColor;

  const ResumeFormPage({
    super.key,
    required this.templateName,
    required this.accentColor,
  });

  @override
  State<ResumeFormPage> createState() => _ResumeFormPageState();
}

class _ResumeFormPageState extends State<ResumeFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _profileImagePath;
  final List<TextEditingController> _skillControllers = [];
  final List<int> _skillRatings = [];
  final List<TextEditingController> _educationControllers = [];
  final List<TextEditingController> _experienceControllers = [];
  final List<String> _hobbies = [];

  // Social media controllers
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _twitterController = TextEditingController();
  final _portfolioController = TextEditingController();

  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _summaryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _summaryController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _twitterController.dispose();
    _portfolioController.dispose();
    for (var controller in _skillControllers) {
      controller.dispose();
    }
    for (var controller in _educationControllers) {
      controller.dispose();
    }
    for (var controller in _experienceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  void _addSkill() {
    setState(() {
      _skillControllers.add(TextEditingController());
      _skillRatings.add(3); // Default rating
    });
  }

  void _addEducation() {
    setState(() {
      _educationControllers.addAll([
        TextEditingController(), // degree
        TextEditingController(), // institution
        TextEditingController(), // duration
        TextEditingController(), // location
      ]);
    });
  }

  void _addExperience() {
    setState(() {
      _experienceControllers.addAll([
        TextEditingController(), // position
        TextEditingController(), // company
        TextEditingController(), // duration
        TextEditingController(), // location
        TextEditingController(), // responsibilities
      ]);
    });
  }

  void _addHobby(String hobby) {
    setState(() {
      _hobbies.add(hobby);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final resumeData = ResumeData(
        name: _nameController.text,
        title: _titleController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        profileImagePath: _profileImagePath ?? '',
        summary: _summaryController.text,
        skills: List.generate(
          _skillControllers.length,
          (i) => Skill(
            name: _skillControllers[i].text,
            rating: _skillRatings[i],
          ),
        ),
        education: List.generate(
          _educationControllers.length ~/ 4,
          (i) => Education(
            degree: _educationControllers[i * 4].text,
            institution: _educationControllers[i * 4 + 1].text,
            duration: _educationControllers[i * 4 + 2].text,
            location: _educationControllers[i * 4 + 3].text,
          ),
        ),
        experience: List.generate(
          _experienceControllers.length ~/ 5,
          (i) => Experience(
            position: _experienceControllers[i * 5].text,
            company: _experienceControllers[i * 5 + 1].text,
            duration: _experienceControllers[i * 5 + 2].text,
            location: _experienceControllers[i * 5 + 3].text,
            responsibilities: _experienceControllers[i * 5 + 4]
                .text
                .split('\n')
                .where((line) => line.isNotEmpty)
                .toList(),
          ),
        ),
        hobbies: _hobbies,
        socialMedia: {
          if (_linkedinController.text.isNotEmpty)
            'linkedin': _linkedinController.text,
          if (_githubController.text.isNotEmpty)
            'github': _githubController.text,
          if (_twitterController.text.isNotEmpty)
            'twitter': _twitterController.text,
          if (_portfolioController.text.isNotEmpty)
            'portfolio': _portfolioController.text,
        },
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumePreviewPage(resumeData: resumeData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Resume', style: GoogleFonts.poppins()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Picture Section
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        image: _profileImagePath != null
                            ? DecorationImage(
                                image: FileImage(File(_profileImagePath!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _profileImagePath == null
                          ? const Icon(Icons.add_a_photo, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add Profile Picture',
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Personal Information
            _buildSection(
              'Personal Information',
              Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your name'
                        : null,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration:
                        const InputDecoration(labelText: 'Professional Title'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your title'
                        : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your email'
                        : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your phone'
                        : null,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter your address'
                        : null,
                  ),
                ],
              ),
            ),

            // Social Media Section
            _buildSection(
              'Social Media',
              Column(
                children: [
                  TextFormField(
                    controller: _linkedinController,
                    decoration: const InputDecoration(
                      labelText: 'LinkedIn Profile',
                      prefixIcon: Icon(Icons.link),
                      hintText: 'https://linkedin.com/in/username',
                    ),
                  ),
                  TextFormField(
                    controller: _githubController,
                    decoration: const InputDecoration(
                      labelText: 'GitHub Profile',
                      prefixIcon: Icon(Icons.code),
                      hintText: 'https://github.com/username',
                    ),
                  ),
                  TextFormField(
                    controller: _twitterController,
                    decoration: const InputDecoration(
                      labelText: 'Twitter Profile',
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: 'https://twitter.com/username',
                    ),
                  ),
                  TextFormField(
                    controller: _portfolioController,
                    decoration: const InputDecoration(
                      labelText: 'Portfolio Website',
                      prefixIcon: Icon(Icons.web),
                      hintText: 'https://yourportfolio.com',
                    ),
                  ),
                ],
              ),
            ),

            // Professional Summary
            _buildSection(
              'Professional Summary',
              TextFormField(
                controller: _summaryController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write a brief summary about yourself...',
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a summary' : null,
              ),
            ),

            // Skills Section
            _buildSection(
              'Skills',
              Column(
                children: [
                  ...List.generate(
                    _skillControllers.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _skillControllers[index],
                              decoration:
                                  const InputDecoration(labelText: 'Skill'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter a skill'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Slider(
                            value: _skillRatings[index].toDouble(),
                            min: 1,
                            max: 5,
                            divisions: 4,
                            label: _skillRatings[index].toString(),
                            onChanged: (value) {
                              setState(() {
                                _skillRatings[index] = value.round();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addSkill,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Skill'),
                  ),
                ],
              ),
            ),

            // Education Section
            _buildSection(
              'Education',
              Column(
                children: [
                  ...List.generate(
                    _educationControllers.length ~/ 4,
                    (index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _educationControllers[index * 4],
                              decoration:
                                  const InputDecoration(labelText: 'Degree'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter degree'
                                  : null,
                            ),
                            TextFormField(
                              controller: _educationControllers[index * 4 + 1],
                              decoration: const InputDecoration(
                                  labelText: 'Institution'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter institution'
                                  : null,
                            ),
                            TextFormField(
                              controller: _educationControllers[index * 4 + 2],
                              decoration:
                                  const InputDecoration(labelText: 'Duration'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter duration'
                                  : null,
                            ),
                            TextFormField(
                              controller: _educationControllers[index * 4 + 3],
                              decoration:
                                  const InputDecoration(labelText: 'Location'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter location'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addEducation,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Education'),
                  ),
                ],
              ),
            ),

            // Experience Section
            _buildSection(
              'Experience',
              Column(
                children: [
                  ...List.generate(
                    _experienceControllers.length ~/ 5,
                    (index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _experienceControllers[index * 5],
                              decoration:
                                  const InputDecoration(labelText: 'Position'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter position'
                                  : null,
                            ),
                            TextFormField(
                              controller: _experienceControllers[index * 5 + 1],
                              decoration:
                                  const InputDecoration(labelText: 'Company'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter company'
                                  : null,
                            ),
                            TextFormField(
                              controller: _experienceControllers[index * 5 + 2],
                              decoration:
                                  const InputDecoration(labelText: 'Duration'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter duration'
                                  : null,
                            ),
                            TextFormField(
                              controller: _experienceControllers[index * 5 + 3],
                              decoration:
                                  const InputDecoration(labelText: 'Location'),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter location'
                                  : null,
                            ),
                            TextFormField(
                              controller: _experienceControllers[index * 5 + 4],
                              decoration: const InputDecoration(
                                labelText: 'Responsibilities',
                                hintText:
                                    'Enter each responsibility on a new line',
                              ),
                              maxLines: 4,
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter responsibilities'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addExperience,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Experience'),
                  ),
                ],
              ),
            ),

            // Hobbies Section
            _buildSection(
              'Hobbies',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ..._hobbies.map(
                        (hobby) => Chip(
                          label: Text(hobby),
                          onDeleted: () {
                            setState(() {
                              _hobbies.remove(hobby);
                            });
                          },
                        ),
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.add),
                        label: const Text('Add Hobby'),
                        onPressed: () async {
                          final controller = TextEditingController();
                          final result = await showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Add Hobby'),
                              content: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: 'Enter hobby'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, controller.text),
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                          );
                          if (result != null && result.isNotEmpty) {
                            _addHobby(result);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Preview Resume',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content,
        const SizedBox(height: 16),
      ],
    );
  }
}
