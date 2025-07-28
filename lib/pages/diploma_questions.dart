import 'package:flutter/material.dart';

class DiplomaQuestionsPage extends StatefulWidget {
  @override
  _DiplomaQuestionsPageState createState() => _DiplomaQuestionsPageState();
}

class _DiplomaQuestionsPageState extends State<DiplomaQuestionsPage> {
  Map<String, bool> subjectExpansion = {
    'Pharmacology': true,
    'Pharmaceutical Care': false,
    'Clinical Pharmacy': false,
    'Community Pharmacy': false,
  };

  Map<String, List<Map<String, dynamic>>> questionsBySubject = {
    'Pharmacology': [
      {
        'id': 1,
        'question': 'Which of the following is a common side effect of ACE inhibitors?',
        'options': ['Dry cough', 'Diarrhea', 'Headache', 'Nausea'],
        'correctAnswer': 0,
        'subject': 'Pharmacology',
        'difficulty': 'Medium',
        'createdDate': '2024-01-13'
      }
    ],
    'Pharmaceutical Care': [
      {
        'id': 2,
        'question': 'What is the recommended storage temperature for insulin?',
        'options': ['2-8°C', '15-25°C', '25-30°C', 'Room temperature'],
        'correctAnswer': 0,
        'subject': 'Pharmaceutical Care',
        'difficulty': 'Easy',
        'createdDate': '2024-01-14'
      }
    ],
    'Clinical Pharmacy': [
      {
        'id': 3,
        'question': 'What are the contraindications for beta-blockers?',
        'options': ['Asthma', 'Hypertension', 'Tachycardia', 'Angina'],
        'correctAnswer': 0,
        'subject': 'Clinical Pharmacy',
        'difficulty': 'Medium',
        'createdDate': '2024-01-12'
      }
    ],
    'Community Pharmacy': [
      {
        'id': 4,
        'question': 'Which dosage form has the fastest onset of action?',
        'options': ['Tablets', 'Capsules', 'Injections', 'Topical'],
        'correctAnswer': 2,
        'subject': 'Community Pharmacy',
        'difficulty': 'Easy',
        'createdDate': '2024-01-10'
      }
    ],
  };

  List<Map<String, dynamic>> get allQuestions {
    List<Map<String, dynamic>> all = [];
    questionsBySubject.values.forEach((questions) => all.addAll(questions));
    return all;
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diploma Questions Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage questions for Diploma level students',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add new question logic
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14B8A6),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Questions',
                    '${allQuestions.length}',
                    Icons.quiz,
                    Color(0xFF14B8A6),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Easy Questions',
                    '${allQuestions.where((q) => q['difficulty'] == 'Easy').length}',
                    Icons.sentiment_satisfied,
                    Color(0xFF10B981),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Medium Questions',
                    '${allQuestions.where((q) => q['difficulty'] == 'Medium').length}',
                    Icons.sentiment_neutral,
                    Color(0xFFF59E0B),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Hard Questions',
                    '${allQuestions.where((q) => q['difficulty'] == 'Hard').length}',
                    Icons.sentiment_very_dissatisfied,
                    Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Questions List by Subject
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Manage practice questions for Diploma level students',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        Text(
                          'Total Questions: ${allQuestions.length}  Selected: 0',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search and Filter Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFFE2E8F0)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search diploma questions...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 14,
                                  fontFamily: "Ubuntu",
                                ),
                                prefixIcon: Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButton<String>(
                            value: 'All Subjects',
                            underline: Container(),
                            items: ['All Subjects', ...questionsBySubject.keys].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontFamily: "Ubuntu")),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Filter logic
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButton<String>(
                            value: 'Bulk Actions',
                            underline: Container(),
                            items: ['Bulk Actions', 'Delete All', 'Add to Pharmacology'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontFamily: "Ubuntu")),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Bulk actions logic
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.delete, size: 18),
                          label: Text('Delete All'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEF4444),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: Size(0, 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Subject Groups
                  ...questionsBySubject.entries.map((entry) => _buildSubjectGroup(entry.key, entry.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectGroup(String subject, List<Map<String, dynamic>> questions) {
    bool isExpanded = subjectExpansion[subject] ?? false;
    
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Subject Header
          InkWell(
            onTap: () {
              setState(() {
                subjectExpansion[subject] = !isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: 8),
                  Text(
                    subject,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '${questions.length} questions',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Select All (${questions.length})',
                      style: TextStyle(
                        color: Color(0xFF14B8A6),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete, size: 16),
                    label: Text('Delete All'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size(0, 32),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 16),
                    label: Text('Add to $subject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF14B8A6),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size(0, 32),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Questions List
          if (isExpanded)
            ...questions.map((question) => _buildQuestionRow(question)),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(Map<String, dynamic> question) {
    Color difficultyColor = question['difficulty'] == 'Easy' ? Color(0xFF10B981) :
                           question['difficulty'] == 'Medium' ? Color(0xFFF59E0B) : Color(0xFFEF4444);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (bool? value) {
              // Handle selection
            },
            activeColor: Color(0xFF14B8A6),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ID: ${question['id']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '• Diploma Level',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        question['difficulty'],
                        style: TextStyle(
                          color: difficultyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Ubuntu",
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Added ${question['createdDate']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  question['question'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                    fontFamily: "Ubuntu",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.visibility, color: Color(0xFF64748B), size: 20),
                tooltip: 'View Question',
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Color(0xFF64748B), size: 20),
                tooltip: 'Edit Question',
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Color(0xFFEF4444), size: 20),
                tooltip: 'Delete Question',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontFamily: "Ubuntu",
            ),
          ),
        ],
      ),
    );
  }
}
