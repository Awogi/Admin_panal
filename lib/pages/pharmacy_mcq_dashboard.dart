import 'package:flutter/material.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({super.key});

  @override
  State<PharmacyDashboard> createState() => _PharmacyDashboardState();
}

class _PharmacyDashboardState extends State<PharmacyDashboard> {
  String selectedPage = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 1024;

        return Scaffold(
          backgroundColor: Color(0xFFF8FAFC),
          body: Row(
            children: [
              if (isWideScreen)
                Container(
                  width: 280,
                  child: PharmacyMCQSidebar(
                    selectedPage: selectedPage,
                    onPageSelected: (page) => setState(() => selectedPage = page),
                  ),
                ),
              Expanded(
                child: Column(
                  children: [
                    if (isWideScreen) PharmacyMCQTopBar(),
                    Expanded(child: _buildMainContent()),
                  ],
                ),
              ),
            ],
          ),
          drawer: isWideScreen ? null : PharmacyMCQSidebar(
            selectedPage: selectedPage,
            onPageSelected: (page) => setState(() => selectedPage = page),
          ),
        );
      },
    );
  }

  Widget _buildMainContent() {
    switch (selectedPage) {
      case 'Dashboard':
        return PharmacyMCQDashboardContent();
      case 'Diploma':
        return DiplomaQuestionsPage();
      case 'Bachelors':
        return BachelorsQuestionsPage();
      case 'Add Question':
        return AddQuestionPage();
      case 'Question Bank':
        return QuestionBankPage();
      case 'Quiz Management':
        return QuizManagementPage();
      case 'Reports':
        return MCQReportsPage();
      case 'Settings':
        return MCQSettingsPage();
      default:
        return PharmacyMCQDashboardContent();
    }
  }
}

// Sidebar Component for MCQ Management
class PharmacyMCQSidebar extends StatelessWidget {
  final String selectedPage;
  final Function(String) onPageSelected;

  const PharmacyMCQSidebar({
    super.key,
    required this.selectedPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Logo Header
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF14B8A6), Color(0xFF0891B2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_pharmacy,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pharmacy Admin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          fontFamily: "Ubuntu",
                        ),
                      ),
                      Text(
                        'Question Manager',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontFamily: "Ubuntu",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(Icons.dashboard, "Dashboard", "Dashboard"),
                SizedBox(height: 8),
                
                _buildSectionHeader("QUESTION MANAGEMENT"),
                _buildMenuItem(Icons.school, "Diploma Questions", "Diploma"),
                _buildMenuItem(Icons.person, "Bachelors Questions", "Bachelors"),
                _buildMenuItem(Icons.add_circle, "Add Question", "Add Question"),
                _buildMenuItem(Icons.quiz, "Question Bank", "Question Bank"),
                SizedBox(height: 8),
                
                _buildSectionHeader("QUIZ MANAGEMENT"),
                _buildMenuItem(Icons.assignment, "Quiz Management", "Quiz Management"),
                _buildMenuItem(Icons.assessment, "Reports & Analytics", "Reports"),
                SizedBox(height: 8),
                
                _buildSectionHeader("SYSTEM"),
                _buildMenuItem(Icons.settings, "Settings", "Settings"),
                
                SizedBox(height: 32),
                _buildMenuItem(Icons.logout, "Logout", "Logout", isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF64748B),
          letterSpacing: 0.5,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String page, {bool isLogout = false}) {
    bool isSelected = selectedPage == page;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF14B8A6).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Icon(
          icon,
          color: isSelected ? Color(0xFF14B8A6) : (isLogout ? Color(0xFFEF4444) : Color(0xFF64748B)),
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Color(0xFF14B8A6) : (isLogout ? Color(0xFFEF4444) : Color(0xFF1E293B)),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
            fontFamily: "Ubuntu",
          ),
        ),
        onTap: () => onPageSelected(page),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// Top Bar Component
class PharmacyMCQTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search questions, topics, categories...',
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Color(0xFF64748B)),
          ),
          SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFF14B8A6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

// Dashboard Content for MCQ Management
class PharmacyMCQDashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Welcome to your pharmacy practice questions management system',
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
          
          // Stats Grid for MCQ System
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1200 ? 4 : 
                                 constraints.maxWidth > 800 ? 3 : 
                                 constraints.maxWidth > 600 ? 2 : 1;
              
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard(
                    'Total Questions',
                    '1,247',
                    '+23 from last month',
                    Icons.quiz,
                    Color(0xFF14B8A6),
                    Color(0xFFECFDF5),
                  ),
                  _buildStatCard(
                    'Diploma Questions',
                    '623',
                    '50.0% of total',
                    Icons.school,
                    Color(0xFF8B5CF6),
                    Color(0xFFFDF4FF),
                  ),
                  _buildStatCard(
                    'Bachelors Questions',
                    '624',
                    '50.0% of total',
                    Icons.person,
                    Color(0xFFF59E0B),
                    Color(0xFFFEF3C7),
                  ),
                  _buildStatCard(
                    'This Month',
                    '23',
                    'Questions added',
                    Icons.trending_up,
                    Color(0xFF10B981),
                    Color(0xFFECFDF5),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 32),
          
          // Recent Activity Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildRecentQuestions(),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: _buildQuickActions(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF94A3B8), size: 20),
            ],
          ),
          Spacer(),
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
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF10B981),
              fontFamily: "Ubuntu",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentQuestions() {
    return Container(
      padding: EdgeInsets.all(24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently Added Questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                  fontFamily: "Ubuntu",
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              List<Map<String, dynamic>> questions = [
                {
                  'question': 'Which of the following is the primary mechanism of action for ACE inhibitors?',
                  'category': 'Bachelors',
                  'subject': 'Pharmacology',
                  'difficulty': 'Medium',
                  'date': '2024-01-15'
                },
                {
                  'question': 'What is the recommended storage temperature for insulin?',
                  'category': 'Diploma',
                  'subject': 'Pharmaceutical Care',
                  'difficulty': 'Easy',
                  'date': '2024-01-14'
                },
                {
                  'question': 'Calculate the bioavailability of a drug with the following parameters...',
                  'category': 'Bachelors',
                  'subject': 'Pharmacokinetics',
                  'difficulty': 'Hard',
                  'date': '2024-01-13'
                },
                {
                  'question': 'What are the contraindications for beta-blockers?',
                  'category': 'Diploma',
                  'subject': 'Clinical Pharmacy',
                  'difficulty': 'Medium',
                  'date': '2024-01-12'
                },
                {
                  'question': 'Identify the drug interaction between warfarin and aspirin',
                  'category': 'Bachelors',
                  'subject': 'Drug Interactions',
                  'difficulty': 'Hard',
                  'date': '2024-01-11'
                }
              ];
              
              return _buildQuestionItem(
                questions[index]['question'],
                questions[index]['category'],
                questions[index]['subject'],
                questions[index]['difficulty'],
                questions[index]['date'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionItem(String question, String category, String subject, String difficulty, String date) {
    Color categoryColor = category == 'Bachelors' ? Color(0xFFF59E0B) : Color(0xFF14B8A6);
    Color difficultyColor = difficulty == 'Easy' ? Color(0xFF10B981) : 
                           difficulty == 'Medium' ? Color(0xFFF59E0B) : Color(0xFFEF4444);
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                subject,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
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
                  difficulty,
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
                date,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontFamily: "Ubuntu",
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            question,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontFamily: "Ubuntu",
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(24),
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
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Frequently used actions to manage your question database',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 16),
          _buildActionButton('Add Question', Icons.add, Color(0xFF14B8A6)),
          SizedBox(height: 12),
          _buildActionButton('Upload PDF', Icons.upload_file, Color(0xFF8B5CF6)),
          SizedBox(height: 12),
          _buildActionButton('Create Quiz', Icons.assignment, Color(0xFFF59E0B)),
          SizedBox(height: 12),
          _buildActionButton('View Reports', Icons.assessment, Color(0xFF10B981)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "Ubuntu",
            ),
          ),
        ],
      ),
    );
  }
}

// Question Management Pages
class DiplomaQuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Diploma Questions Management', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class BachelorsQuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Bachelors Questions Management', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class AddQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Add New Question', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class QuestionBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Question Bank', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class QuizManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Quiz Management', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class MCQReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Reports & Analytics', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}

class MCQSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings', style: TextStyle(fontSize: 24, fontFamily: "Ubuntu")));
  }
}
