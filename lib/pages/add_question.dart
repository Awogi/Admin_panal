import 'package:flutter/material.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();
  final _explanationController = TextEditingController();

  String _selectedLevel = 'Diploma';
  String _selectedSubject = 'Pharmacology';
  String _selectedDifficulty = 'Easy';
  int _correctAnswer = 0;

  final List<String> _levels = ['Diploma', 'Bachelors'];
  final List<String> _diplomaSubjects = [
    'Pharmaceutical Care',
    'Clinical Pharmacy',
    'Pharmaceutics',
    'Community Pharmacy',
    'Hospital Pharmacy'
  ];
  final List<String> _bachelorsSubjects = [
    'Pharmacology',
    'Pharmacokinetics',
    'Drug Interactions',
    'Therapeutics',
    'Clinical Pharmacy',
    'Medicinal Chemistry',
    'Pharmaceutical Analysis'
  ];
  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Question',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Create a new multiple choice question for students',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),

            // Form Container
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1E293B).withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Information Section
                    Text(
                      'Basic Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 20),

                    // Level, Subject, Difficulty Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            'Level',
                            _selectedLevel,
                            _levels,
                            (value) => setState(() {
                              _selectedLevel = value!;
                              _selectedSubject = _selectedLevel == 'Diploma' 
                                  ? _diplomaSubjects[0] 
                                  : _bachelorsSubjects[0];
                            }),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdownField(
                            'Subject',
                            _selectedSubject,
                            _selectedLevel == 'Diploma' ? _diplomaSubjects : _bachelorsSubjects,
                            (value) => setState(() => _selectedSubject = value!),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdownField(
                            'Difficulty',
                            _selectedDifficulty,
                            _difficulties,
                            (value) => setState(() => _selectedDifficulty = value!),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Question Section
                    Text(
                      'Question',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      'Enter your question here...',
                      _questionController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a question';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),

                    // Options Section
                    Text(
                      'Answer Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildOptionField('Option A', _option1Controller, 0),
                    SizedBox(height: 12),
                    _buildOptionField('Option B', _option2Controller, 1),
                    SizedBox(height: 12),
                    _buildOptionField('Option C', _option3Controller, 2),
                    SizedBox(height: 12),
                    _buildOptionField('Option D', _option4Controller, 3),
                    SizedBox(height: 32),

                    // Explanation Section
                    Text(
                      'Explanation (Optional)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildTextFormField(
                      'Provide an explanation for the correct answer...',
                      _explanationController,
                      maxLines: 3,
                    ),
                    SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Clear form
                              _clearForm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE2E8F0),
                              foregroundColor: Color(0xFF64748B),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Clear Form',
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveQuestion();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF14B8A6),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Save Question',
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            fontFamily: "Ubuntu",
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF14B8A6), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontFamily: "Ubuntu"),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xFF9CA3AF),
          fontFamily: "Ubuntu",
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF14B8A6), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: TextStyle(fontFamily: "Ubuntu"),
    );
  }

  Widget _buildOptionField(String label, TextEditingController controller, int index) {
    return Row(
      children: [
        Radio<int>(
          value: index,
          groupValue: _correctAnswer,
          onChanged: (value) => setState(() => _correctAnswer = value!),
          activeColor: Color(0xFF14B8A6),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
            fontFamily: "Ubuntu",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${label.toLowerCase()}';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter ${label.toLowerCase()}...',
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontFamily: "Ubuntu",
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF14B8A6), width: 2),
              ),
              filled: true,
              fillColor: _correctAnswer == index 
                  ? Color(0xFF14B8A6).withOpacity(0.05) 
                  : Colors.white,
            ),
            style: TextStyle(fontFamily: "Ubuntu"),
          ),
        ),
      ],
    );
  }

  void _clearForm() {
    _questionController.clear();
    _option1Controller.clear();
    _option2Controller.clear();
    _option3Controller.clear();
    _option4Controller.clear();
    _explanationController.clear();
    setState(() {
      _selectedLevel = 'Diploma';
      _selectedSubject = _diplomaSubjects[0];
      _selectedDifficulty = 'Easy';
      _correctAnswer = 0;
    });
  }

  void _saveQuestion() {
    // Save question logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Question saved successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
    _clearForm();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _explanationController.dispose();
    super.dispose();
  }
}
