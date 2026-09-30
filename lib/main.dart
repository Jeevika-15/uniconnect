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
          elevation: 0,
        ),

        bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: burgundy,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
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
  // Reminder Dialog
  // ----------------------------------------------------------

  void showReminderDialog() {
    final TextEditingController controller =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.add_alert_outlined,
                color: UniConnectApp.burgundy,
              ),
              SizedBox(width: 10),
              Text('Add Reminder'),
            ],
          ),

          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your reminder',
              prefixIcon: const Icon(
                Icons.edit_outlined,
              ),
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
                backgroundColor:
                UniConnectApp.burgundy,
                foregroundColor: Colors.white,
              ),

              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.pop(context);

                  showMessage(
                    'Reminder added: ${controller.text.trim()}',
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
                  'New campus announcement available.',
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.orange,
                ),
                title: Text('Registration'),
                subtitle: Text(
                  'Course registration closes soon.',
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
  // Drawer
  // ----------------------------------------------------------

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // ====================================================
          // DRAWER HEADER
          // ====================================================

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

              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(0.15),
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
                    color:
                    Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Mody University',
                  style: TextStyle(
                    color:
                    Colors.white.withOpacity(0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // DRAWER ITEMS
          // ====================================================

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

          ListTile(
            leading: const Icon(
              Icons.menu_book_outlined,
            ),
            title: const Text('My Courses'),

            onTap: () {
              Navigator.pop(context);
              showMessage(
                'My Courses selected',
              );
            },
          ),

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
  // MAIN BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Mody Logo
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

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // ========================================================
      // FLOATING ACTION BUTTON
      // ========================================================

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: showReminderDialog,

        backgroundColor: UniConnectApp.teal,
        foregroundColor: Colors.white,

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

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================

      bottomNavigationBar:
      BottomNavigationBar(
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

  // ==========================================================
  // ACADEMIC STAT CONTAINER
  // ==========================================================

  Widget academicStat(
      String value,
      String label,
      IconData icon,
      ) {
    return Expanded(
      child: Container(
        height: 90,

        margin: const EdgeInsets.symmetric(
          horizontal: 4,
        ),

        padding: const EdgeInsets.all(10),

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(15),

          border: Border.all(
            color:
            UniConnectApp.burgundy
                .withOpacity(0.12),
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              color: UniConnectApp.burgundy,
              size: 20,
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                color: UniConnectApp.burgundy,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 10,
              ),
            ),
          ],
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
          bottom: 100,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            // ==================================================
            // HEADER CONTAINER
            // ==================================================

            Container(
              width: double.infinity,

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(20),

              constraints: const BoxConstraints(
                minHeight: 180,
              ),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    UniConnectApp.burgundy,
                    Color(0xFF991B1B),
                  ],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius:
                BorderRadius.circular(25),

                boxShadow: [
                  BoxShadow(
                    color:
                    UniConnectApp.burgundy
                        .withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),

              child: Row(
                children: [
                  // Logo Container
                  Container(
                    width: 75,
                    height: 75,
                    padding:
                    const EdgeInsets.all(4),

                    decoration:
                    const BoxDecoration(
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

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [
                        Text(
                          'Good morning, Jeevika 👋',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Welcome to UniConnect',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Computer Science & Engineering',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Mody University',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // ACADEMIC SNAPSHOT
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Academic Snapshot',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: UniConnectApp.charcoal,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: const Color(0xFFF1ECE7),

                borderRadius:
                BorderRadius.circular(20),

                border: Border.all(
                  color:
                  UniConnectApp.burgundy
                      .withOpacity(0.08),
                ),
              ),

              child: Row(
                children: [
                  academicStat(
                    '5',
                    'Semester',
                    Icons.school_outlined,
                  ),

                  academicStat(
                    '8.7',
                    'CGPA',
                    Icons.grade_outlined,
                  ),

                  academicStat(
                    '5',
                    'Subjects',
                    Icons.menu_book_outlined,
                  ),

                  academicStat(
                    '3',
                    'Events',
                    Icons.event_outlined,
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

            const SizedBox(height: 5),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Text(
                'Everything you need on campus.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Wrap = responsive layout
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 11,
              ),

              child: Wrap(
                alignment: WrapAlignment.center,

                children: [
                  CampusActionCard(
                    icon: Icons
                        .calendar_month_outlined,
                    title: 'Timetable',
                    subtitle: 'View schedule',
                    color:
                    UniConnectApp.burgundy,

                    onTap: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Timetable opened',
                          ),
                        ),
                      );
                    },
                  ),

                  CampusActionCard(
                    icon:
                    Icons.grade_outlined,
                    title: 'Results',
                    subtitle: 'Check grades',
                    color:
                    UniConnectApp.teal,

                    onTap: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Results opened',
                          ),
                        ),
                      );
                    },
                  ),

                  CampusActionCard(
                    icon:
                    Icons.menu_book_outlined,
                    title: 'Library',
                    subtitle: 'Books & resources',
                    color: Colors.orange,

                    onTap: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Library opened',
                          ),
                        ),
                      );
                    },
                  ),

                  CampusActionCard(
                    icon:
                    Icons.directions_bus_outlined,
                    title: 'Shuttle',
                    subtitle: 'Transport info',
                    color: Colors.deepPurple,

                    onTap: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Shuttle information opened',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // CAMPUS ANNOUNCEMENT
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Campus Announcement',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Course registration details opened',
                    ),
                  ),
                );
              },

              child: Container(
                width: double.infinity,

                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                padding: const EdgeInsets.all(18),

                alignment: Alignment.centerLeft,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D6),

                  borderRadius:
                  BorderRadius.circular(18),

                  border: Border.all(
                    color:
                    Colors.orange.withOpacity(0.35),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.04),
                      blurRadius: 7,
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,

                      alignment:
                      Alignment.center,

                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius:
                        BorderRadius.circular(
                            13),
                      ),

                      child: const Icon(
                        Icons
                            .campaign_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 13),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          Text(
                            'Course Registration',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Registration closes on 5 October 2026.',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Tap to view details',
                            style: TextStyle(
                              color:
                              UniConnectApp
                                  .burgundy,
                              fontWeight:
                              FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons
                          .arrow_forward_ios,
                      size: 15,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // STUDENT LIFE
            // ==================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Student Life',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                border: Border.all(
                  color:
                  UniConnectApp.teal
                      .withOpacity(0.15),
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                children: [
                  // Event date tile
                  Container(
                    width: 65,
                    height: 75,

                    alignment:
                    Alignment.center,

                    decoration: BoxDecoration(
                      color:
                      const Color(0xFFE6F7F5),

                      borderRadius:
                      BorderRadius.circular(
                          15),

                      border: Border.all(
                        color:
                        UniConnectApp.teal
                            .withOpacity(0.2),
                      ),
                    ),

                    child: const Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [
                        Text(
                          '10',
                          style: TextStyle(
                            color:
                            UniConnectApp
                                .teal,
                            fontSize: 22,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        Text(
                          'OCT',
                          style: TextStyle(
                            color:
                            UniConnectApp
                                .teal,
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Career Discovery Workshop',
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            // Status badge
                            Text(
                              'NEW',
                              style: TextStyle(
                                color:
                                Colors.white,
                                backgroundColor:
                                UniConnectApp
                                    .teal,
                                fontSize: 9,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6),

                        Text(
                          '10:00 AM • Seminar Hall',
                          style: TextStyle(
                            color:
                            UniConnectApp
                                .burgundy,
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Meet industry professionals and learn about internships and placements.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // MENTION / UNIVERSITY CONTAINER
            // ==================================================

            Container(
              width: double.infinity,

              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color:
                const Color(0xFFF1ECE7),

                borderRadius:
                BorderRadius.circular(18),

                border: Border.all(
                  color:
                  UniConnectApp.burgundy
                      .withOpacity(0.12),
                ),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                    color:
                    UniConnectApp.burgundy,
                    size: 30,
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Text(
                          'Mody University',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Student Campus Portal',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.verified,
                    color:
                    UniConnectApp.teal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE CAMPUS ACTION CARD
// ============================================================

class CampusActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const CampusActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 160,
        height: 120,

        margin: const EdgeInsets.all(5),

        padding: const EdgeInsets.all(15),

        alignment: Alignment.centerLeft,

        constraints: const BoxConstraints(
          minHeight: 110,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: color.withOpacity(0.25),
            width: 1.2,
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Container(
              width: 42,
              height: 42,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius:
                BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: color,
                size: 23,
              ),
            ),

            const Spacer(),

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

  // IMPORTANT:
  // These belong to ActivitiesPage.
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
      'icon':
      Icons.sports_basketball,
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
      'color': Colors.orange,
    },

    {
      'title': 'Career Workshop',
      'date': '8 October 2026',
      'time': '2:00 PM - 4:00 PM',
      'location': 'Seminar Hall',
      'description':
      'Get useful guidance about internships, placements, resumes and interviews.',
      'icon': Icons.work_outline,
      'color': Colors.deepPurple,
    },
  ];

  // ----------------------------------------------------------
  // Registration
  // ----------------------------------------------------------

  void toggleRegistration(int index) {
    setState(() {
      if (registeredActivities
          .contains(index)) {
        registeredActivities.remove(index);
      } else {
        registeredActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          registeredActivities
              .contains(index)
              ? 'Registered for ${activities[index]['title']}'
              : 'Registration cancelled',
        ),

        behavior:
        SnackBarBehavior.floating,

        backgroundColor:
        UniConnectApp.burgundy,
      ),
    );
  }

  // ----------------------------------------------------------
  // Favourite
  // ----------------------------------------------------------

  void toggleFavourite(int index) {
    setState(() {
      if (favouriteActivities
          .contains(index)) {
        favouriteActivities.remove(index);
      } else {
        favouriteActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          favouriteActivities
              .contains(index)
              ? 'Added to favourites ⭐'
              : 'Removed from favourites',
        ),

        behavior:
        SnackBarBehavior.floating,
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
                  color:
                  UniConnectApp.charcoal,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                'Discover events happening at Mody University.',
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
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),

                  child: Padding(
                    padding:
                    const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [
                            // Activity icon
                            Container(
                              width: 55,
                              height: 55,

                              alignment:
                              Alignment.center,

                              decoration:
                              BoxDecoration(
                                color:
                                (activity[
                                'color']
                                as Color)
                                    .withOpacity(
                                    0.10),

                                borderRadius:
                                BorderRadius
                                    .circular(
                                    15),
                              ),

                              child: Icon(
                                activity['icon']
                                as IconData,
                                color:
                                activity[
                                'color']
                                as Color,
                                size: 27,
                              ),
                            ),

                            const SizedBox(
                              width: 13,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [
                                  Text(
                                    activity[
                                    'title']
                                    as String,

                                    style:
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 5),

                                  Text(
                                    activity[
                                    'date']
                                    as String,

                                    style:
                                    const TextStyle(
                                      color:
                                      UniConnectApp
                                          .burgundy,
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight
                                          .w600,
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
                                    : Icons
                                    .star_border,

                                color: isFavourite
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 14),

                        Text(
                          activity[
                          'description']
                          as String,

                          style: TextStyle(
                            color:
                            Colors.grey.shade700,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(
                            height: 14),

                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 17,
                              color:
                              UniConnectApp
                                  .teal,
                            ),

                            const SizedBox(
                                width: 7),

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

                        const SizedBox(
                            height: 7),

                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .location_on_outlined,
                              size: 17,
                              color:
                              UniConnectApp
                                  .teal,
                            ),

                            const SizedBox(
                                width: 7),

                            Expanded(
                              child: Text(
                                activity[
                                'location']
                                as String,

                                style:
                                const TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight
                                      .w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 15),

                        SizedBox(
                          width: double.infinity,

                          child:
                          ElevatedButton.icon(
                            onPressed: () {
                              toggleRegistration(
                                index,
                              );
                            },

                            icon: Icon(
                              isRegistered
                                  ? Icons
                                  .check_circle
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
                                BorderRadius
                                    .circular(
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

  // ----------------------------------------------------------
  // Reusable profile information row
  // ----------------------------------------------------------

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
            width: 42,
            height: 42,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              color:
              UniConnectApp.cream,

              borderRadius:
              BorderRadius.circular(11),

              border: Border.all(
                color:
                UniConnectApp.burgundy
                    .withOpacity(0.1),
              ),
            ),

            child: Icon(
              icon,
              color:
              UniConnectApp.burgundy,
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
                    color:
                    Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.w600,
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

              padding:
              const EdgeInsets.fromLTRB(
                20,
                30,
                20,
                35,
              ),

              decoration:
              const BoxDecoration(
                color:
                UniConnectApp.burgundy,

                borderRadius:
                BorderRadius.only(
                  bottomLeft:
                  Radius.circular(30),
                  bottomRight:
                  Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    padding:
                    const EdgeInsets.all(5),

                    decoration:
                    const BoxDecoration(
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

                  const SizedBox(
                      height: 15),

                  const Text(
                    'Jeevika Singathia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  const Text(
                    'Computer Science & Engineering',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(
                      height: 3),

                  const Text(
                    'Mody University',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 20),

            // ==================================================
            // PROFILE STATS
            // ==================================================

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [
                  profileStat(
                    'CGPA',
                    '8.7',
                  ),

                  profileStat(
                    'Semester',
                    '5',
                  ),

                  profileStat(
                    'Events',
                    '3',
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 20),

            // ==================================================
            // INFORMATION TITLE
            // ==================================================

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Align(
                alignment:
                Alignment.centerLeft,

                child: Text(
                  'Student Information',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
                height: 10),

            // ==================================================
            // INFORMATION CONTAINER
            // ==================================================

            Container(
              width: double.infinity,

              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding:
              const EdgeInsets.all(16),

              decoration:
              BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 10,
                    offset:
                    const Offset(0, 4),
                  ),
                ],

                border: Border.all(
                  color:
                  UniConnectApp.burgundy
                      .withOpacity(0.08),
                ),
              ),

              child: Column(
                children: [
                  buildInfoRow(
                    icon:
                    Icons.badge_outlined,
                    title: 'Student ID',
                    value:
                    'MU2024CSE001',
                  ),

                  const Divider(),

                  buildInfoRow(
                    icon:
                    Icons.school_outlined,
                    title: 'University',
                    value:
                    'Mody University',
                  ),

                  const Divider(),

                  buildInfoRow(
                    icon:
                    Icons.computer_outlined,
                    title: 'Programme',
                    value:
                    'B.Tech Computer Science & Engineering',
                  ),

                  const Divider(),

                  buildInfoRow(
                    icon:
                    Icons.email_outlined,
                    title: 'Email',
                    value:
                    'student@university.edu',
                  ),

                  const Divider(),

                  buildInfoRow(
                    icon:
                    Icons.calendar_today_outlined,
                    title: 'Academic Year',
                    value:
                    '2024 - 2028',
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 12),

            // ==================================================
            // EDIT PROFILE
            // ==================================================

            Container(
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
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
                    color:
                    UniConnectApp.burgundy,
                  ),

                  padding:
                  const EdgeInsets
                      .symmetric(
                    vertical: 14,
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

            const SizedBox(
                height: 18),

            // ==================================================
            // UNIVERSITY CONTAINER
            // ==================================================

            Container(
              width: double.infinity,

              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              padding:
              const EdgeInsets.all(18),

              decoration:
              BoxDecoration(
                color:
                const Color(0xFFE6F7F5),

                borderRadius:
                BorderRadius.circular(18),

                border: Border.all(
                  color:
                  UniConnectApp.teal
                      .withOpacity(0.2),
                ),
              ),

              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,

                    alignment:
                    Alignment.center,

                    decoration:
                    const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.account_balance,
                      color:
                      UniConnectApp.teal,
                    ),
                  ),

                  const SizedBox(
                      width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

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
                            color:
                            Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.verified,
                    color:
                    UniConnectApp.teal,
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

  Widget profileStat(
      String title,
      String value,
      ) {
    return Expanded(
      child: Container(
        height: 80,

        margin:
        const EdgeInsets.symmetric(
          horizontal: 5,
        ),

        padding:
        const EdgeInsets.all(12),

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(16),

          border: Border.all(
            color:
            UniConnectApp.burgundy
                .withOpacity(0.08),
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Text(
              value,
              style: const TextStyle(
                color:
                UniConnectApp.burgundy,
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: TextStyle(
                color:
                Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}