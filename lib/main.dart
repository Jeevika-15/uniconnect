import 'package:flutter/material.dart';

void main() {
  runApp(const UniConnectApp());
}

// ============================================================
// APP
// ============================================================

class UniConnectApp extends StatelessWidget {
  const UniConnectApp({super.key});

  static const Color burgundy = Color(0xFF7F1D1D);
  static const Color cream = Color(0xFFFAF8F5);
  static const Color teal = Color(0xFF0D9488);
  static const Color charcoal = Color(0xFF292524);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniConnect - Mody University',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,

        colorScheme: ColorScheme.fromSeed(
          seedColor: burgundy,
          primary: burgundy,
          secondary: teal,
          surface: cream,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: burgundy,
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFFFE5E5),
          elevation: 5,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: burgundy,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: teal,
          foregroundColor: Colors.white,
        ),
      ),

      home: const MainPage(),
    );
  }
}

// ============================================================
// MAIN PAGE
// ============================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final Set<int> registeredActivities = {};
  final Set<int> favouriteActivities = {};

  final List<String> reminders = [];

  final List<Widget> pages = const [
    HomePage(),
    ActivitiesPage(),
    ProfilePage(),
  ];

  // ----------------------------------------------------------
  // SnackBar
  // ----------------------------------------------------------

  void showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: UniConnectApp.burgundy,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ----------------------------------------------------------
  // Reminder dialog
  // ----------------------------------------------------------

  void showReminderDialog() {
    final TextEditingController controller =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Reminder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your reminder',
              prefixIcon: const Icon(Icons.edit_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UniConnectApp.burgundy,
                foregroundColor: Colors.white,
              ),

              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    reminders.add(
                      controller.text.trim(),
                    );
                  });

                  Navigator.pop(context);

                  showMessage(
                    'Reminder added successfully!',
                  );
                }
              },

              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // Drawer
  // ----------------------------------------------------------

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              20,
              55,
              20,
              25,
            ),

            decoration: const BoxDecoration(
              color: UniConnectApp.burgundy,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Container(
                  width: 78,
                  height: 78,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),

                  child: ClipOval(
                    child: Image.asset(
                      'assets/mody_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Jeevika Singathia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Computer Science & Engineering',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Mody University',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: UniConnectApp.burgundy,
            ),
            title: const Text('Home'),

            onTap: () {
              Navigator.pop(context);

              setState(() {
                currentIndex = 0;
              });
            },
          ),

          // Activities
          ListTile(
            leading: const Icon(
              Icons.event_outlined,
              color: UniConnectApp.burgundy,
            ),
            title: const Text('Activities'),

            onTap: () {
              Navigator.pop(context);

              setState(() {
                currentIndex = 1;
              });
            },
          ),

          // Profile
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: UniConnectApp.burgundy,
            ),
            title: const Text('Profile'),

            onTap: () {
              Navigator.pop(context);

              setState(() {
                currentIndex = 2;
              });
            },
          ),

          const Divider(),

          // My Courses
          ListTile(
            leading: const Icon(
              Icons.menu_book_outlined,
            ),
            title: const Text('My Courses'),

            onTap: () {
              Navigator.pop(context);

              showMessage(
                'My Courses section selected',
              );
            },
          ),

          // Campus Map
          ListTile(
            leading: const Icon(
              Icons.location_on_outlined,
            ),
            title: const Text('Campus Map'),

            onTap: () {
              Navigator.pop(context);

              showMessage(
                'Campus Map coming soon!',
              );
            },
          ),

          // Settings
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
            ),
            title: const Text('Settings'),

            onTap: () {
              Navigator.pop(context);

              showMessage(
                'Settings selected',
              );
            },
          ),

          // Help Centre
          ListTile(
            leading: const Icon(
              Icons.help_outline,
            ),
            title: const Text('Help Centre'),

            onTap: () {
              Navigator.pop(context);

              showMessage(
                'Help Centre selected',
              );
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'UniConnect • Mody University',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Notifications
  // ----------------------------------------------------------

  void showNotifications() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                color: UniConnectApp.burgundy,
              ),
              SizedBox(width: 10),
              Text('Notifications'),
            ],
          ),

          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.event,
                  color: UniConnectApp.teal,
                ),
                title: Text('Coding Workshop'),
                subtitle: Text(
                  'Tomorrow at 10:00 AM',
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.campaign,
                  color: UniConnectApp.burgundy,
                ),
                title: Text('Campus Update'),
                subtitle: Text(
                  'New announcements are available.',
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // Build
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Small logo in AppBar
            Container(
              width: 38,
              height: 38,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: ClipOval(
                child: Image.asset(
                  'assets/mody_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              'UniConnect',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),

            onPressed: showNotifications,
          ),
        ],
      ),

      drawer: buildDrawer(),

      // IndexedStack keeps the page states alive.
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // --------------------------------------------------------
      // FAB
      // --------------------------------------------------------

      floatingActionButton: FloatingActionButton.extended(
        onPressed: showReminderDialog,

        icon: const Icon(
          Icons.add_alert_outlined,
        ),

        label: const Text(
          'Reminder',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // --------------------------------------------------------
      // Bottom Navigation Bar
      // --------------------------------------------------------

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_outlined,
            ),
            activeIcon: Icon(
              Icons.event,
            ),
            label: 'Activities',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            activeIcon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // ----------------------------------------------------------
  // Quick Access Card
  // ----------------------------------------------------------

  Widget quickAccessCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: UniConnectApp.cream,
                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  color: UniConnectApp.burgundy,
                  size: 23,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 90,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // ==================================================
            // GREETING
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    'Good evening, Jeevika 👋',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Welcome to UniConnect',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: UniConnectApp.charcoal,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Your Mody University campus companion.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STUDENT DASHBOARD CARD
            // ==================================================

            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    UniConnectApp.burgundy,
                    Color(0xFF991B1B),
                  ],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: UniConnectApp.burgundy
                        .withOpacity(0.25),

                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      // Logo
                      Container(
                        width: 65,
                        height: 65,
                        padding: const EdgeInsets.all(3),

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        child: ClipOval(
                          child: Image.asset(
                            'assets/mody_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Jeevika Singathia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 3),

                            Text(
                              'Computer Science & Engineering',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: 2),

                            Text(
                              'Mody University',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 1,
                    color: Colors.white24,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [
                      _stat(
                        'Semester',
                        '5',
                      ),

                      _stat(
                        'CGPA',
                        '8.7',
                      ),

                      _stat(
                        'Subjects',
                        '5',
                      ),

                      _stat(
                        'Events',
                        '3',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // QUICK ACCESS
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [
                  quickAccessCard(
                    context: context,
                    icon: Icons.menu_book_outlined,
                    title: 'Library',
                    subtitle: 'Books & resources',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Library opened',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 10),

                  quickAccessCard(
                    context: context,
                    icon: Icons.calendar_month_outlined,
                    title: 'Schedule',
                    subtitle: 'View timetable',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Schedule opened',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 10),

                  quickAccessCard(
                    context: context,
                    icon: Icons.location_on_outlined,
                    title: 'Campus',
                    subtitle: 'Find locations',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Campus map opened',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // UPCOMING EVENT
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Upcoming',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,

                      decoration: BoxDecoration(
                        color: UniConnectApp.cream,
                        borderRadius:
                        BorderRadius.circular(15),
                      ),

                      child: const Icon(
                        Icons.psychology_outlined,
                        color: UniConnectApp.teal,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Machine Learning Workshop',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Tomorrow • 10:00 AM',
                            style: TextStyle(
                              color:
                              UniConnectApp.burgundy,
                              fontSize: 12,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Computer Lab • Block A',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // CAMPUS UPDATES
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Campus Updates',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding:
                      const EdgeInsets.all(9),

                      decoration: BoxDecoration(
                        color: UniConnectApp.cream,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.campaign_outlined,
                        color:
                        UniConnectApp.burgundy,
                      ),
                    ),

                    title: const Text(
                      'New campus announcement',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: const Text(
                      'Check the latest university updates.',
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),

                  const Divider(
                    height: 1,
                  ),

                  ListTile(
                    leading: Container(
                      padding:
                      const EdgeInsets.all(9),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7F5),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.school_outlined,
                        color: UniConnectApp.teal,
                      ),
                    ),

                    title: const Text(
                      'Academic resources',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: const Text(
                      'Access your courses and learning materials.',
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // Dashboard Stat
  // ----------------------------------------------------------

  static Widget _stat(
      String title,
      String value,
      ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// ACTIVITIES PAGE
// ============================================================

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() =>
      _ActivitiesPageState();
}

class _ActivitiesPageState
    extends State<ActivitiesPage> {

  final Set<int> registeredActivities = {};
  final Set<int> favouriteActivities = {};

  final List<Map<String, dynamic>> activities = [
    {
      'title': 'Coding Workshop',
      'date': '29 September 2026',
      'time': '10:00 AM - 12:00 PM',
      'location': 'Computer Lab, Block A',
      'description':
      'Learn practical programming skills and solve coding problems with other students.',
      'icon': Icons.code,
      'color': UniConnectApp.burgundy,
    },

    {
      'title': 'Sports Day',
      'date': '2 October 2026',
      'time': '9:00 AM - 3:00 PM',
      'location': 'University Sports Ground',
      'description':
      'Take part in exciting sports activities and compete with students across campus.',
      'icon': Icons.sports_basketball,
      'color': UniConnectApp.teal,
    },

    {
      'title': 'Cultural Night',
      'date': '5 October 2026',
      'time': '6:00 PM - 9:00 PM',
      'location': 'Main Auditorium',
      'description':
      'Enjoy music, dance and cultural performances organised by university students.',
      'icon': Icons.music_note,
      'color': Color(0xFF92400E),
    },

    {
      'title': 'Career Workshop',
      'date': '8 October 2026',
      'time': '2:00 PM - 4:00 PM',
      'location': 'Seminar Hall',
      'description':
      'Get useful guidance about internships, placements, resumes and interview preparation.',
      'icon': Icons.work_outline,
      'color': Color(0xFF57534E),
    },
  ];

  void toggleRegistration(int index) {
    setState(() {
      if (registeredActivities.contains(index)) {
        registeredActivities.remove(index);
      } else {
        registeredActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          registeredActivities.contains(index)
              ? 'Registered for ${activities[index]['title']}'
              : 'Registration cancelled',
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: UniConnectApp.burgundy,
      ),
    );
  }

  void toggleFavourite(int index) {
    setState(() {
      if (favouriteActivities.contains(index)) {
        favouriteActivities.remove(index);
      } else {
        favouriteActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          favouriteActivities.contains(index)
              ? 'Added to favourites ⭐'
              : 'Removed from favourites',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 100,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Campus Activities',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: UniConnectApp.charcoal,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Discover events and activities happening at Mody University.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 18),

            ...List.generate(
              activities.length,
                  (index) {
                final activity =
                activities[index];

                final bool isRegistered =
                registeredActivities
                    .contains(index);

                final bool isFavourite =
                favouriteActivities
                    .contains(index);

                return Card(
                  child: Padding(
                    padding:
                    const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            // Activity icon
                            Container(
                              width: 55,
                              height: 55,

                              decoration:
                              BoxDecoration(
                                color:
                                (activity['color']
                                as Color)
                                    .withOpacity(
                                    0.10),
                                borderRadius:
                                BorderRadius.circular(
                                    15),
                              ),

                              child: Icon(
                                activity['icon']
                                as IconData,
                                color:
                                activity['color']
                                as Color,
                                size: 27,
                              ),
                            ),

                            const SizedBox(width: 13),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [
                                  Text(
                                    activity['title']
                                    as String,

                                    style:
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    activity['date']
                                    as String,

                                    style:
                                    const TextStyle(
                                      color:
                                      UniConnectApp
                                          .burgundy,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                toggleFavourite(
                                  index,
                                );
                              },

                              icon: Icon(
                                isFavourite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: isFavourite
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Text(
                          activity['description']
                          as String,

                          style: TextStyle(
                            color:
                            Colors.grey.shade700,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Time
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 17,
                              color:
                              UniConnectApp.teal,
                            ),

                            const SizedBox(width: 7),

                            Text(
                              activity['time']
                              as String,

                              style:
                              const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        // Location
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 17,
                              color:
                              UniConnectApp.teal,
                            ),

                            const SizedBox(width: 7),

                            Expanded(
                              child: Text(
                                activity['location']
                                as String,

                                style:
                                const TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton.icon(
                            onPressed: () {
                              toggleRegistration(
                                index,
                              );
                            },

                            icon: Icon(
                              isRegistered
                                  ? Icons.check_circle
                                  : Icons
                                  .calendar_month,
                            ),

                            label: Text(
                              isRegistered
                                  ? 'Registered ✓'
                                  : 'Register for Activity',
                            ),

                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              isRegistered
                                  ? UniConnectApp
                                  .teal
                                  : UniConnectApp
                                  .burgundy,

                              foregroundColor:
                              Colors.white,

                              padding:
                              const EdgeInsets
                                  .symmetric(
                                vertical: 13,
                              ),

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(9),

            decoration: BoxDecoration(
              color: UniConnectApp.cream,
              borderRadius:
              BorderRadius.circular(11),
            ),

            child: Icon(
              icon,
              color: UniConnectApp.burgundy,
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 100,
        ),

        child: Column(
          children: [
            // ==================================================
            // PROFILE HEADER
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20,
                30,
                20,
                35,
              ),

              decoration: const BoxDecoration(
                color: UniConnectApp.burgundy,

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 105,
                    height: 105,
                    padding: const EdgeInsets.all(5),

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: ClipOval(
                      child: Image.asset(
                        'assets/mody_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Jeevika Singathia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Computer Science & Engineering',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 3),

                  const Text(
                    'Mody University',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STATS
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [
                  _profileStat(
                    'CGPA',
                    '8.7',
                  ),

                  _profileStat(
                    'Semester',
                    '5',
                  ),

                  _profileStat(
                    'Events',
                    '3',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STUDENT INFORMATION
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Student Information',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    buildInfoRow(
                      icon: Icons.badge_outlined,
                      title: 'Student ID',
                      value: 'MU2024CSE001',
                    ),

                    const Divider(),

                    buildInfoRow(
                      icon: Icons.school_outlined,
                      title: 'University',
                      value: 'Mody University',
                    ),

                    const Divider(),

                    buildInfoRow(
                      icon: Icons.computer_outlined,
                      title: 'Programme',
                      value:
                      'B.Tech Computer Science & Engineering',
                    ),

                    const Divider(),

                    buildInfoRow(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value:
                      'student@university.edu',
                    ),

                    const Divider(),

                    buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      title: 'Academic Year',
                      value: '2024 - 2028',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // EDIT PROFILE BUTTON
            // ==================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: SizedBox(
                width: double.infinity,

                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Edit Profile selected',
                        ),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.edit_outlined,
                  ),

                  label: const Text(
                    'Edit Profile',
                  ),

                  style:
                  OutlinedButton.styleFrom(
                    foregroundColor:
                    UniConnectApp.burgundy,

                    side: const BorderSide(
                      color: UniConnectApp.burgundy,
                    ),

                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 14,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // UNIVERSITY CARD
            // ==================================================

            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F5),
                borderRadius:
                BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                    color: UniConnectApp.teal,
                    size: 32,
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Mody University',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Student Campus Portal',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.verified,
                    color: UniConnectApp.teal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // Profile stat
  // ----------------------------------------------------------

  static Widget _profileStat(
      String title,
      String value,
      ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),

        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: UniConnectApp.burgundy,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}