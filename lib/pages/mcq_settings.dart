import 'package:flutter/material.dart';

class MCQSettingsPage extends StatefulWidget {
  @override
  _MCQSettingsPageState createState() => _MCQSettingsPageState();
}

class _MCQSettingsPageState extends State<MCQSettingsPage> {
  // Settings variables
  bool _enableNotifications = true;
  bool _enableAutoSave = true;
  bool _enableDarkMode = false;
  bool _enableQuestionRandomization = true;
  int _questionsPerQuiz = 20;
  int _timePerQuestion = 60; // seconds
  String _defaultDifficulty = 'Medium';
  String _backupFrequency = 'Daily';

  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];
  final List<String> _backupOptions = ['Daily', 'Weekly', 'Monthly'];

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
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                fontFamily: "Ubuntu",
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Configure your pharmacy MCQ admin panel preferences',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
                fontFamily: "Ubuntu",
              ),
            ),
            SizedBox(height: 32),

            // General Settings
            _buildSettingsSection(
              'General Settings',
              [
                _buildSwitchTile(
                  'Enable Notifications',
                  'Receive notifications for new questions and updates',
                  _enableNotifications,
                  (value) => setState(() => _enableNotifications = value),
                  Icons.notifications,
                ),
                _buildSwitchTile(
                  'Auto Save',
                  'Automatically save questions while editing',
                  _enableAutoSave,
                  (value) => setState(() => _enableAutoSave = value),
                  Icons.save,
                ),
                _buildSwitchTile(
                  'Dark Mode',
                  'Use dark theme for the interface',
                  _enableDarkMode,
                  (value) => setState(() => _enableDarkMode = value),
                  Icons.dark_mode,
                ),
              ],
            ),
            SizedBox(height: 24),

            // Quiz Configuration
            _buildSettingsSection(
              'Quiz Configuration',
              [
                _buildSwitchTile(
                  'Question Randomization',
                  'Randomize question order in quizzes',
                  _enableQuestionRandomization,
                  (value) => setState(() => _enableQuestionRandomization = value),
                  Icons.shuffle,
                ),
                _buildSliderTile(
                  'Questions per Quiz',
                  'Default number of questions in a quiz',
                  _questionsPerQuiz.toDouble(),
                  10,
                  50,
                  (value) => setState(() => _questionsPerQuiz = value.round()),
                  Icons.quiz,
                ),
                _buildSliderTile(
                  'Time per Question (seconds)',
                  'Default time limit for each question',
                  _timePerQuestion.toDouble(),
                  30,
                  300,
                  (value) => setState(() => _timePerQuestion = value.round()),
                  Icons.timer,
                ),
                _buildDropdownTile(
                  'Default Difficulty',
                  'Default difficulty level for new questions',
                  _defaultDifficulty,
                  _difficulties,
                  (value) => setState(() => _defaultDifficulty = value!),
                  Icons.trending_up,
                ),
              ],
            ),
            SizedBox(height: 24),

            // Data Management
            _buildSettingsSection(
              'Data Management',
              [
                _buildDropdownTile(
                  'Backup Frequency',
                  'How often to backup question database',
                  _backupFrequency,
                  _backupOptions,
                  (value) => setState(() => _backupFrequency = value!),
                  Icons.backup,
                ),
                _buildActionTile(
                  'Export Questions',
                  'Export all questions to Excel file',
                  Icons.file_download,
                  () => _exportQuestions(),
                ),
                _buildActionTile(
                  'Import Questions',
                  'Import questions from Excel file',
                  Icons.file_upload,
                  () => _importQuestions(),
                ),
                _buildActionTile(
                  'Clear Cache',
                  'Clear application cache and temporary data',
                  Icons.clear_all,
                  () => _clearCache(),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Account Settings
            _buildSettingsSection(
              'Account Settings',
              [
                _buildActionTile(
                  'Change Password',
                  'Update your account password',
                  Icons.lock,
                  () => _changePassword(),
                ),
                _buildActionTile(
                  'Update Profile',
                  'Edit your profile information',
                  Icons.person,
                  () => _updateProfile(),
                ),
                _buildActionTile(
                  'Logout',
                  'Sign out of your account',
                  Icons.logout,
                  () => _logout(),
                  isDestructive: true,
                ),
              ],
            ),
            SizedBox(height: 24),

            // Save Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF14B8A6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save Settings',
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
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Container(
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
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                fontFamily: "Ubuntu",
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF14B8A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF14B8A6), size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    fontFamily: "Ubuntu",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontFamily: "Ubuntu",
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF14B8A6),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF14B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Color(0xFF14B8A6), size: 20),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        Text(
                          '${value.round()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF14B8A6),
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontFamily: "Ubuntu",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFF14B8A6),
              inactiveTrackColor: Color(0xFFE2E8F0),
              thumbColor: Color(0xFF14B8A6),
              overlayColor: Color(0xFF14B8A6).withOpacity(0.1),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> options,
    Function(String?) onChanged,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF14B8A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF14B8A6), size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    fontFamily: "Ubuntu",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontFamily: "Ubuntu",
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: Container(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: TextStyle(fontFamily: "Ubuntu"),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive 
                ? Color(0xFFEF4444).withOpacity(0.1)
                : Color(0xFF14B8A6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon, 
            color: isDestructive ? Color(0xFFEF4444) : Color(0xFF14B8A6), 
            size: 20
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDestructive ? Color(0xFFEF4444) : Color(0xFF1E293B),
            fontFamily: "Ubuntu",
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontFamily: "Ubuntu",
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Color(0xFF64748B),
        ),
        onTap: onTap,
      ),
    );
  }

  // Action methods
  void _exportQuestions() {
    // Export logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exporting questions...')),
    );
  }

  void _importQuestions() {
    // Import logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Select file to import...')),
    );
  }

  void _clearCache() {
    // Clear cache logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cache cleared successfully!')),
    );
  }

  void _changePassword() {
    // Change password logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening password change dialog...')),
    );
  }

  void _updateProfile() {
    // Update profile logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening profile update dialog...')),
    );
  }

  void _logout() {
    // Logout logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    // Save settings logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings saved successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }
}
