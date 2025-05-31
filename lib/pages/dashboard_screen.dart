import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final int userId;
  final String userEmail;
  final bool isNewUser;

  const DashboardScreen({
    Key? key, 
    required this.userId,
    required this.userEmail,
    this.isNewUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Show welcome message for new users
    if (isNewUser) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome to Quiz App! You can now browse available quizzes.'),
            duration: Duration(seconds: 5),
          ),
        );
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,          children: [
            // Welcome message
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userEmail == 'admin@example.com' 
                        ? 'Hello Admin! You have full access to all features.'
                        : 'Hello $userEmail! Ready to test your knowledge?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (userEmail == 'admin@example.com')
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'ADMIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Available Quizzes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildQuizCard(
                    context, 
                    'Mathematics', 
                    Icons.calculate, 
                    Colors.blue,
                    'Test your math skills with basic arithmetic to algebra',
                  ),
                  _buildQuizCard(
                    context, 
                    'Science', 
                    Icons.science, 
                    Colors.green,
                    'Explore physics, chemistry, and biology concepts',
                  ),
                  _buildQuizCard(
                    context, 
                    'History', 
                    Icons.history_edu, 
                    Colors.amber,
                    'Journey through world events and important dates',
                  ),
                  _buildQuizCard(
                    context, 
                    'Literature', 
                    Icons.book, 
                    Colors.purple,
                    'Test your knowledge of famous authors and their works',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Creating new quiz is coming soon!')),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Create Quiz',
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title quiz will be available soon!')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
