import 'package:admin_panal/widget/constant_color.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String selectedPage = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 800;

        return Scaffold(
          appBar: isWideScreen ? null : AppBar(
            title: Text(
              "Pharmacy Admin",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Ubuntu",
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          drawer: isWideScreen ? null : AppDrawer(
            selectedPage: selectedPage,
            onPageSelected: (page) => setState(() => selectedPage = page),
          ),
          backgroundColor: Color(0xFFF8F9FA),
          body: Row(
            children: [
              if (isWideScreen)
                SizedBox(
                  width: 280,
                  child: AppDrawer(
                    selectedPage: selectedPage,
                    onPageSelected: (page) => setState(() => selectedPage = page),
                  ),
                ),
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent() {
    switch (selectedPage) {
      case 'Dashboard':
        return _buildDashboard();
      case 'Diploma':
        return _buildQuestionsPage('Diploma Questions');
      case 'Bachelors':
        return _buildQuestionsPage('Bachelors Questions');
      case 'Upload PDF':
        return _buildUploadPage();
      case 'Settings':
        return _buildSettingsPage();
      case 'Add Question':
        return _buildAddQuestionPage();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
                      color: Colors.black87,
                      fontFamily: "Ubuntu",
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Welcome to your pharmacy practice questions management system',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: "Ubuntu",
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          
          // Statistics Cards
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Total Questions', '1247', '+23 from last month', Icons.quiz, Color(0xFF6366F1))),
                      SizedBox(width: 20),
                      Expanded(child: _buildStatCard('Diploma Questions', '623', '50.0% of total', Icons.school, Color(0xFF10B981))),
                      SizedBox(width: 20),
                      Expanded(child: _buildStatCard('Bachelors Questions', '624', '50.0% of total', Icons.person, Color(0xFFF59E0B))),
                      SizedBox(width: 20),
                      Expanded(child: _buildStatCard('This Month', '23', 'Questions added', Icons.trending_up, Color(0xFFEF4444))),
                    ],
                  ),
                  SizedBox(height: 32),
                  
                  // Quick Actions Section
                  _buildQuickActions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Icon(Icons.visibility, color: Colors.grey[400], size: 20),
            ],
          ),
          SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontFamily: "Ubuntu",
            ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Frequently used actions to manage your question database',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: "Ubuntu",
            ),
          ),
          SizedBox(height: 24),
          
          // Grid of Action Cards
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Add Question',
                  Icons.add,
                  themeblue,
                  () => setState(() => selectedPage = 'Add Question'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  'Upload PDF',
                  Icons.upload_file,
                  Colors.grey[100]!,
                  () => setState(() => selectedPage = 'Upload PDF'),
                  isSecondary: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  'Manage Questions',
                  Icons.edit,
                  Colors.grey[100]!,
                  () => setState(() => selectedPage = 'Diploma'),
                  isSecondary: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  'Bulk Operations',
                  Icons.assessment,
                  Colors.grey[100]!,
                  () => setState(() => selectedPage = 'Settings'),
                  isSecondary: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color backgroundColor, VoidCallback onTap, {bool isSecondary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: isSecondary ? Border.all(color: Colors.grey[300]!) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSecondary ? Colors.white : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSecondary ? Colors.grey[600] : Colors.white,
                size: 20,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isSecondary ? Colors.grey[800] : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                fontFamily: "Ubuntu",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsPage(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  Widget _buildUploadPage() {
    return Center(
      child: Text(
        'Upload PDF Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  Widget _buildAddQuestionPage() {
    return Center(
      child: Text(
        'Add Question Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  Widget _buildSettingsPage() {
    return Center(
      child: Text(
        'Settings Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }
}


// ✅ Reusable Drawer Widget
class AppDrawer extends StatelessWidget {
  final String selectedPage;
  final Function(String) onPageSelected;

  const AppDrawer({
    super.key,
    required this.selectedPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeblue,
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
                          color: Colors.black87,
                          fontFamily: "Ubuntu",
                        ),
                      ),
                      Text(
                        'Question Manager',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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
                
                // Manage Questions Section
                _buildSectionHeader("MANAGE QUESTIONS"),
                _buildExpandableMenuItem(
                  Icons.quiz, 
                  "Manage Questions",
                  [
                    _buildSubMenuItem("Diploma", "Diploma"),
                    _buildSubMenuItem("Bachelors", "Bachelors"),
                  ],
                ),
                SizedBox(height: 8),
                
                _buildMenuItem(Icons.upload_file, "Upload PDF", "Upload PDF"),
                SizedBox(height: 8),
                _buildMenuItem(Icons.settings, "Settings", "Settings"),
                
                SizedBox(height: 32),
                
                // Logout at bottom
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
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
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
        color: isSelected ? themeblue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          icon,
          color: isSelected ? themeblue : (isLogout ? Colors.red[400] : Colors.grey[600]),
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? themeblue : (isLogout ? Colors.red[400] : Colors.grey[800]),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
            fontFamily: "Ubuntu",
          ),
        ),
        onTap: () => onPageSelected(page),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildExpandableMenuItem(IconData icon, String title, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(
        icon,
        color: Colors.grey[600],
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: "Ubuntu",
        ),
      ),
      children: children,
      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      childrenPadding: EdgeInsets.only(left: 16),
    );
  }

  Widget _buildSubMenuItem(String title, String page) {
    bool isSelected = selectedPage == page;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? themeblue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isSelected ? themeblue : Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? themeblue : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
            fontFamily: "Ubuntu",
          ),
        ),
        onTap: () => onPageSelected(page),
      ),
    );
  }
}
