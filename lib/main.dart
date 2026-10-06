import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/timetable_screen.dart';
import 'screens/services_screen.dart';
import 'screens/service_detail_screen.dart';
import 'screens/events_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/unknown_screen.dart';

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
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: burgundy.withOpacity(0.15),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: burgundy.withOpacity(0.15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: teal,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const MainPage(),
        AppRoutes.timetable: (_) => const TimetableScreen(),
        AppRoutes.services: (_) => const ServicesScreen(),
        AppRoutes.events: (_) => const EventsScreen(),
        AppRoutes.profile: (_) => const ProfilePage(),
        AppRoutes.campusRequest: (_) => const CampusRequestPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.serviceDetail) {
          return MaterialPageRoute(
            builder: (_) => const ServiceDetailScreen(),
            settings: settings,
          );
        }

        if (settings.name == AppRoutes.eventDetail) {
          final event = settings.arguments as CampusEvent;

          return MaterialPageRoute(
            builder: (_) => EventDetailScreen(event: event),
          );
        }

        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const UnknownScreen(),
        );
      },
    );
  }
}

// Backward-compatible alias for the default Flutter widget test.
typedef MyApp = UniConnectApp;

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
    CampusRequestPage(),
  ];

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
              prefixIcon: const Icon(Icons.edit_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UniConnectApp.burgundy,
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
                subtitle: Text('Tomorrow at 10:00 AM'),
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
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HOME
                  ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      color: UniConnectApp.burgundy,
                    ),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => currentIndex = 0);
                    },
                  ),

                  // ACTIVITIES
                  ListTile(
                    leading: const Icon(
                      Icons.event_outlined,
                      color: UniConnectApp.burgundy,
                    ),
                    title: const Text('Activities'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => currentIndex = 1);
                    },
                  ),

                  // PROFILE
                  ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      color: UniConnectApp.burgundy,
                    ),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => currentIndex = 2);
                    },
                  ),

                  // TIMETABLE
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_month_outlined,
                      color: UniConnectApp.burgundy,
                    ),
                    title: const Text('Timetable'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.timetable,
                      );
                    },
                  ),

                  // CAMPUS SERVICES
                  ListTile(
                    leading: const Icon(
                      Icons.miscellaneous_services_outlined,
                      color: UniConnectApp.teal,
                    ),
                    title: const Text('Campus Services'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.services,
                      );
                    },
                  ),

                  // CAMPUS EVENTS
                  ListTile(
                    leading: const Icon(
                      Icons.event_outlined,
                      color: UniConnectApp.teal,
                    ),
                    title: const Text('Campus Events'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.events,
                      );
                    },
                  ),

                  // NEW CAMPUS REQUEST
                  ListTile(
                    leading: const Icon(
                      Icons.assignment_outlined,
                      color: UniConnectApp.teal,
                    ),
                    title: const Text('Campus Request'),
                    subtitle: const Text(
                      'Submit a service request',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => currentIndex = 3);
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
                      showMessage('My Courses selected');
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
                      showMessage('Settings selected');
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                    ),
                    title: const Text('Help Centre'),
                    onTap: () {
                      Navigator.pop(context);
                      showMessage('Help Centre selected');
                    },
                  ),

                ],
              ),
            ),
          ),

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

  @override
  Widget build(BuildContext context) {
    // Bottom navigation only has 3 destinations.
    // When Campus Request is open, Home remains visually selected.
    final int navigationIndex =
    currentIndex > 2 ? 0 : currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
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

      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
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

  Widget academicStat(
      String value,
      String label,
      IconData icon,
      ) {
    return Expanded(
      child: Container(
        height: 90,
        margin:
        const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),
          border: Border.all(
            color: UniConnectApp.burgundy
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
        padding:
        const EdgeInsets.only(
          top: 18,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // WELCOME CONTAINER
            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(20),
              constraints:
              const BoxConstraints(
                minHeight: 180,
              ),
              decoration: BoxDecoration(
                gradient:
                const LinearGradient(
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
                    color: UniConnectApp
                        .burgundy
                        .withOpacity(0.25),
                    blurRadius: 15,
                    offset:
                    const Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                children: [
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
                            color:
                            Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Welcome to UniConnect',
                          style: TextStyle(
                            color:
                            Colors.white,
                            fontSize: 21,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Computer Science & Engineering',
                          style: TextStyle(
                            color:
                            Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Mody University',
                          style: TextStyle(
                            color:
                            Colors.white,
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

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Academic Snapshot',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                  FontWeight.bold,
                  color:
                  UniConnectApp.charcoal,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                const Color(0xFFF1ECE7),
                borderRadius:
                BorderRadius.circular(20),
                border: Border.all(
                  color: UniConnectApp
                      .burgundy
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

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Everything you need on campus.',
                style: TextStyle(
                  color:
                  Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              child: Wrap(
                alignment:
                WrapAlignment.center,
                children: [
                  CampusActionCard(
                    icon:
                    Icons.calendar_month_outlined,
                    title: 'Timetable',
                    subtitle:
                    'View schedule',
                    color:
                    UniConnectApp.burgundy,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.timetable,
                      );
                    },
                  ),
                  CampusActionCard(
                    icon:
                    Icons.grade_outlined,
                    title: 'Results',
                    subtitle:
                    'Check grades',
                    color:
                    UniConnectApp.teal,
                    onTap: () {
                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Results opened',
                          ),
                        ),
                      );
                    },
                  ),
                  CampusActionCard(
                    icon: Icons.library_books_outlined,
                    title: 'Campus Services',
                    subtitle: 'Access university services',
                    color: UniConnectApp.teal,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.services,
                      );
                    },
                  ),

                  CampusActionCard(
                    icon: Icons.event_outlined,
                    title: 'Campus Events',
                    subtitle: 'Explore upcoming events',
                    color: UniConnectApp.burgundy,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.events,
                      );
                    },
                  ),

                  CampusActionCard(
                    icon:
                    Icons.directions_bus_outlined,
                    title: 'Shuttle',
                    subtitle:
                    'Transport info',
                    color:
                    Colors.deepPurple,
                    onTap: () {
                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(
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

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Campus Announcement',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                ScaffoldMessenger
                    .of(context)
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
                margin:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                padding:
                const EdgeInsets.all(18),
                alignment:
                Alignment.centerLeft,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFFFF4D6),
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color:
                    Colors.orange
                        .withOpacity(0.35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.04),
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
                      decoration:
                      BoxDecoration(
                        color:
                        Colors.orange,
                        borderRadius:
                        BorderRadius
                            .circular(13),
                      ),
                      child:
                      const Icon(
                        Icons.campaign_outlined,
                        color:
                        Colors.white,
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
                            style:
                            TextStyle(
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
                      color:
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Student Life',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(20),
                border: Border.all(
                  color: UniConnectApp.teal
                      .withOpacity(0.15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.06),
                    blurRadius: 10,
                    offset:
                    const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 75,
                    alignment:
                    Alignment.center,
                    decoration:
                    BoxDecoration(
                      color:
                      const Color(0xFFE6F7F5),
                      borderRadius:
                      BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: UniConnectApp
                            .teal
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
                                style:
                                TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              'NEW',
                              style:
                              TextStyle(
                                color:
                                Colors.white,
                                backgroundColor:
                                UniConnectApp
                                    .teal,
                                fontSize: 9,
                                fontWeight:
                                FontWeight.bold,
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
                            color:
                            Colors.grey,
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

            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color:
                const Color(0xFFF1ECE7),
                borderRadius:
                BorderRadius.circular(18),
                border: Border.all(
                  color: UniConnectApp
                      .burgundy
                      .withOpacity(0.12),
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
                    child:
                    const Icon(
                      Icons.account_balance,
                      color:
                      UniConnectApp
                          .burgundy,
                      size: 28,
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
                            color:
                            Colors.grey,
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
        height: 145,
        margin:
        const EdgeInsets.all(5),
        padding:
        const EdgeInsets.all(13),
        alignment:
        Alignment.centerLeft,
        constraints:
        const BoxConstraints(
          minHeight: 110,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color:
            color.withOpacity(0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.06),
              blurRadius: 8,
              offset:
              const Offset(0, 4),
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
              alignment:
              Alignment.center,
              decoration:
              BoxDecoration(
                color:
                color.withOpacity(0.10),
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
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
                fontWeight:
                FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
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

  final List<Map<String, dynamic>>
  activities = [
    {
      'title': 'Coding Workshop',
      'date': '29 September 2026',
      'time': '10:00 AM - 12:00 PM',
      'location':
      'Computer Lab, Block A',
      'description':
      'Learn practical programming skills and solve coding problems with other students.',
      'icon': Icons.code,
      'color': UniConnectApp.burgundy,
    },
    {
      'title': 'Sports Day',
      'date': '2 October 2026',
      'time': '9:00 AM - 3:00 PM',
      'location':
      'University Sports Ground',
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

  void toggleRegistration(int index) {
    setState(() {
      if (registeredActivities
          .contains(index)) {
        registeredActivities.remove(index);
      } else {
        registeredActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          registeredActivities.contains(index)
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

  void toggleFavourite(int index) {
    setState(() {
      if (favouriteActivities
          .contains(index)) {
        favouriteActivities.remove(index);
      } else {
        favouriteActivities.add(index);
      }
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
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
        padding:
        const EdgeInsets.only(
          top: 20,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Campus Activities',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                  FontWeight.bold,
                  color:
                  UniConnectApp.charcoal,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Discover events happening at Mody University.',
                style: TextStyle(
                  color:
                  Colors.grey.shade600,
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
                  const EdgeInsets
                      .symmetric(
                    horizontal: 16,
                    vertical: 7,
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.all(
                      16,
                    ),
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
                            Container(
                              width: 55,
                              height: 55,
                              alignment:
                              Alignment
                                  .center,
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
                                  15,
                                ),
                              ),
                              child:
                              Icon(
                                activity[
                                'icon']
                                as IconData,
                                color: activity[
                                'color']
                                as Color,
                                size: 27,
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Expanded(
                              child:
                              Column(
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
                                      fontSize:
                                      16,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    activity[
                                    'date']
                                    as String,
                                    style:
                                    const TextStyle(
                                      color:
                                      UniConnectApp
                                          .burgundy,
                                      fontSize:
                                      12,
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
                                    index);
                              },
                              icon: Icon(
                                isFavourite
                                    ? Icons.star
                                    : Icons.star_border,
                                color:
                                isFavourite
                                    ? Colors
                                    .amber
                                    : Colors
                                    .grey,
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
                            Colors.grey
                                .shade700,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(
                            height: 14),

                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .access_time,
                              size: 17,
                              color:
                              UniConnectApp
                                  .teal,
                            ),
                            const SizedBox(
                                width: 7),
                            Text(
                              activity[
                              'time']
                              as String,
                              style:
                              const TextStyle(
                                fontSize:
                                12,
                                fontWeight:
                                FontWeight
                                    .w500,
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
                                  fontSize:
                                  12,
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
                          width:
                          double.infinity,
                          child:
                          ElevatedButton.icon(
                            onPressed: () {
                              toggleRegistration(
                                  index);
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
                            ElevatedButton
                                .styleFrom(
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
                                  12,
                                ),
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
      padding:
      const EdgeInsets.symmetric(
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
            decoration:
            BoxDecoration(
              color:
              UniConnectApp.cream,
              borderRadius:
              BorderRadius.circular(
                11,
              ),
              border: Border.all(
                color: UniConnectApp
                    .burgundy
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
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors
                        .grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                    height: 3),
                Text(
                  value,
                  style:
                  const TextStyle(
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
            color: UniConnectApp
                .burgundy
                .withOpacity(0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.05),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
        const EdgeInsets.only(
          bottom: 100,
        ),
        child: Column(
          children: [
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
                    const EdgeInsets.all(
                      5,
                    ),
                    decoration:
                    const BoxDecoration(
                      color: Colors.white,
                      shape:
                      BoxShape.circle,
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
                      color:
                      Colors.white70,
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

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

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

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(16),
              decoration: BoxDecoration(
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
                  color: UniConnectApp
                      .burgundy
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
                    title:
                    'Academic Year',
                    value:
                    '2024 - 2028',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Container(
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              width: double.infinity,
              child:
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger
                      .of(context)
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
                label:
                const Text(
                  'Edit Profile',
                ),
                style:
                OutlinedButton
                    .styleFrom(
                  foregroundColor:
                  UniConnectApp
                      .burgundy,
                  side:
                  const BorderSide(
                    color:
                    UniConnectApp
                        .burgundy,
                  ),
                  padding:
                  const EdgeInsets
                      .symmetric(
                    vertical: 14,
                  ),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                      12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding:
              const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color:
                const Color(0xFFE6F7F5),
                borderRadius:
                BorderRadius.circular(18),
                border: Border.all(
                  color: UniConnectApp
                      .teal
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
                      shape:
                      BoxShape.circle,
                    ),
                    child:
                    const Icon(
                      Icons.account_balance,
                      color:
                      UniConnectApp.teal,
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
                          'Mody University',
                          style:
                          TextStyle(
                            fontWeight:
                            FontWeight
                                .bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                            height: 4),
                        Text(
                          'Student Campus Portal',
                          style:
                          TextStyle(
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
}

// ============================================================
// REUSABLE CAMPUS TEXT FIELD
// ADVANCED CUSTOMIZATION #1
// ============================================================

class CampusTextField
    extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;

  const CampusTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType =
        TextInputType.text,
    this.textInputAction =
        TextInputAction.next,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: UniConnectApp.burgundy,
        ),
        counterStyle: const TextStyle(
          color: UniConnectApp.teal,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================
// CAMPUS REQUEST PAGE
// ============================================================

class CampusRequestPage
    extends StatefulWidget {
  const CampusRequestPage({super.key});

  @override
  State<CampusRequestPage> createState() =>
      _CampusRequestPageState();
}

class _CampusRequestPageState
    extends State<CampusRequestPage> {
  // ----------------------------------------------------------
  // FORM KEY
  // ----------------------------------------------------------

  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  // ----------------------------------------------------------
  // TEXT CONTROLLERS
  // ----------------------------------------------------------

  final TextEditingController
  _nameController =
  TextEditingController();

  final TextEditingController
  _idController =
  TextEditingController();

  final TextEditingController
  _emailController =
  TextEditingController();

  final TextEditingController
  _phoneController =
  TextEditingController();

  final TextEditingController
  _subjectController =
  TextEditingController();

  final TextEditingController
  _detailsController =
  TextEditingController();

  // ----------------------------------------------------------
  // FORM STATE
  // ----------------------------------------------------------

  String? selectedService;
  String? selectedUrgency;
  String? selectedContact;
  DateTime? selectedDate;
  bool declarationAccepted = false;

  // Saved values for submission summary
  String savedName = '';
  String savedStudentId = '';
  String savedEmail = '';
  String savedPhone = '';
  String savedService = '';
  String savedSubject = '';
  String savedDetails = '';
  String savedUrgency = '';
  String savedContact = '';
  DateTime? savedDate;

  // ----------------------------------------------------------
  // SERVICE OPTIONS
  // ----------------------------------------------------------

  final List<String> serviceCategories = [
    'Academic Support',
    'IT & Technical Support',
    'Accommodation',
    'Library Services',
    'Student Activities',
    'Career & Placement',
  ];

  // ----------------------------------------------------------
  // DISPOSE CONTROLLERS
  // ----------------------------------------------------------

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // DATE PICKER
  // ----------------------------------------------------------

  Future<void> pickDate(
      FormFieldState<DateTime> field,
      ) async {
    final DateTime today = DateTime.now();

    final DateTime? picked =
    await showDatePicker(
      context: context,
      initialDate: selectedDate ??
          today.add(
            const Duration(days: 1),
          ),
      firstDate: today,
      lastDate: DateTime(
        today.year + 2,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
            const ColorScheme.light(
              primary:
              UniConnectApp.burgundy,
              secondary:
              UniConnectApp.teal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      field.didChange(picked);
    }
  }

  // ----------------------------------------------------------
  // DATE FORMAT
  // ----------------------------------------------------------

  String formatDate(DateTime date) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ----------------------------------------------------------
  // VALIDATION
  // ----------------------------------------------------------

  String? validateName(String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    if (value.trim().split(' ').length <
        2) {
      return 'Please enter your first and last name';
    }

    return null;
  }

  String? validateStudentId(
      String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your student ID';
    }

    if (value.trim().length < 6) {
      return 'Student ID must be at least 6 characters';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter your campus email';
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(
      value.trim(),
    )) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return null;
    }

    final phoneRegex = RegExp(
      r'^\+?[0-9]{10,15}$',
    );

    if (!phoneRegex.hasMatch(
      value.trim(),
    )) {
      return 'Enter 10-15 digits';
    }

    return null;
  }

  String? validateSubject(
      String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please enter a request subject';
    }

    if (value.trim().length < 5) {
      return 'Subject must be at least 5 characters';
    }

    return null;
  }

  String? validateDetails(
      String? value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Please describe your request';
    }

    if (value.trim().length < 20) {
      return 'Please enter at least 20 characters';
    }

    return null;
  }

  // ----------------------------------------------------------
  // SUBMIT FORM
  // ----------------------------------------------------------

  void submitForm() {
    // First validate every field.
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please correct the highlighted fields.',
          ),
          behavior:
          SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (!declarationAccepted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please confirm the declaration before submitting.',
          ),
          behavior:
          SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // Save form values after successful validation.
    saveFormValues();

    showSubmissionSummary();
  }

  // ----------------------------------------------------------
  // FORM SAVE
  // ----------------------------------------------------------

  void saveFormValues() {
    savedName =
        _nameController.text.trim();

    savedStudentId =
        _idController.text.trim();

    savedEmail =
        _emailController.text.trim();

    savedPhone =
        _phoneController.text.trim();

    savedService =
        selectedService ?? '';

    savedSubject =
        _subjectController.text.trim();

    savedDetails =
        _detailsController.text.trim();

    savedUrgency =
        selectedUrgency ?? '';

    savedContact =
        selectedContact ?? '';

    savedDate = selectedDate;
  }

  // ----------------------------------------------------------
  // SUCCESS SUMMARY
  // ADVANCED CUSTOMIZATION #2
  // ----------------------------------------------------------

  void showSubmissionSummary() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color:
                UniConnectApp.teal,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Request Submitted!',
                ),
              ),
            ],
          ),
          content:
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.all(
                    14,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFFE6F7F5,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(
                      14,
                    ),
                    border: Border.all(
                      color: UniConnectApp
                          .teal
                          .withOpacity(
                        0.25,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Your campus service request has been recorded successfully.',
                    style: TextStyle(
                      color:
                      UniConnectApp
                          .teal,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 18),

                summaryRow(
                  'Student',
                  savedName,
                ),
                summaryRow(
                  'Student ID',
                  savedStudentId,
                ),
                summaryRow(
                  'Service',
                  savedService,
                ),
                summaryRow(
                  'Subject',
                  savedSubject,
                ),
                summaryRow(
                  'Urgency',
                  savedUrgency,
                ),
                summaryRow(
                  'Contact',
                  savedContact,
                ),
                summaryRow(
                  'Date',
                  savedDate == null
                      ? 'Not selected'
                      : formatDate(
                    savedDate!,
                  ),
                ),

                const SizedBox(
                    height: 10),

                const Text(
                  'Request Details',
                  style: TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    color:
                    UniConnectApp
                        .burgundy,
                  ),
                ),

                const SizedBox(
                    height: 5),

                Text(
                  savedDetails,
                  style:
                  const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                UniConnectApp.teal,
                foregroundColor:
                Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  this.context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Request submitted successfully ✓',
                    ),
                    behavior:
                    SnackBarBehavior
                        .floating,
                    backgroundColor:
                    UniConnectApp
                        .burgundy,
                  ),
                );
              },
              child:
              const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Widget summaryRow(
      String title,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 9,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              title,
              style:
              const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style:
              const TextStyle(
                fontSize: 13,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // RESET FORM
  // ----------------------------------------------------------

  void resetForm() {
    _formKey.currentState?.reset();

    _nameController.clear();
    _idController.clear();
    _emailController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _detailsController.clear();

    setState(() {
      selectedService = null;
      selectedUrgency = null;
      selectedContact = null;
      selectedDate = null;
      declarationAccepted = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Form has been reset.',
        ),
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------

  Widget sectionTitle(
      String title,
      String subtitle,
      IconData icon,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment:
            Alignment.center,
            decoration:
            BoxDecoration(
              color: UniConnectApp
                  .burgundy
                  .withOpacity(0.10),
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              icon,
              color:
              UniConnectApp.burgundy,
            ),
          ),
          const SizedBox(
              width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  title,
                  style:
                  const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    UniConnectApp
                        .charcoal,
                  ),
                ),
                const SizedBox(
                    height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors
                        .grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        autovalidateMode:
        AutovalidateMode
            .onUserInteraction,
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            120,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              // ==================================================
              // HEADER
              // ==================================================

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  22,
                ),
                decoration:
                BoxDecoration(
                  gradient:
                  const LinearGradient(
                    colors: [
                      UniConnectApp
                          .burgundy,
                      Color(0xFF991B1B),
                    ],
                    begin:
                    Alignment.topLeft,
                    end:
                    Alignment.bottomRight,
                  ),
                  borderRadius:
                  BorderRadius
                      .circular(
                    24,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                      UniConnectApp
                          .burgundy
                          .withOpacity(
                        0.20,
                      ),
                      blurRadius: 12,
                      offset:
                      const Offset(
                        0,
                        5,
                      ),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      padding:
                      const EdgeInsets
                          .all(4),
                      decoration:
                      const BoxDecoration(
                        color: Colors.white,
                        shape:
                        BoxShape.circle,
                      ),
                      child: ClipOval(
                        child:
                        Image.asset(
                          'assets/mody_logo.png',
                          fit:
                          BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Campus Service Request',
                            style:
                            TextStyle(
                              color:
                              Colors.white,
                              fontSize: 20,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                          SizedBox(
                              height: 6),
                          Text(
                            'Submit a request to a Mody University campus service unit.',
                            style:
                            TextStyle(
                              color:
                              Colors.white70,
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

              const SizedBox(
                  height: 25),

              // ==================================================
              // STUDENT DETAILS
              // ==================================================

              sectionTitle(
                'Student Details',
                'Tell us who is submitting the request.',
                Icons.person_outline,
              ),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  16,
                ),
                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color:
                    UniConnectApp
                        .burgundy
                        .withOpacity(
                      0.10,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.04,
                      ),
                      blurRadius: 8,
                      offset:
                      const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CampusTextField(
                      controller:
                      _nameController,
                      label:
                      'Student Name',
                      hint:
                      'Enter your full name',
                      icon:
                      Icons.person_outline,
                      validator:
                      validateName,
                    ),

                    const SizedBox(
                        height: 14),

                    CampusTextField(
                      controller:
                      _idController,
                      label:
                      'Student ID',
                      hint:
                      'Example: MU2024CSE001',
                      icon:
                      Icons.badge_outlined,
                      validator:
                      validateStudentId,
                    ),

                    const SizedBox(
                        height: 14),

                    CampusTextField(
                      controller:
                      _emailController,
                      label:
                      'Campus Email',
                      hint:
                      'Enter your university email',
                      icon:
                      Icons.email_outlined,
                      keyboardType:
                      TextInputType
                          .emailAddress,
                      validator:
                      validateEmail,
                    ),

                    const SizedBox(
                        height: 14),

                    CampusTextField(
                      controller:
                      _phoneController,
                      label:
                      'Phone Number',
                      hint:
                      'Optional: +91XXXXXXXXXX',
                      icon:
                      Icons.phone_outlined,
                      keyboardType:
                      TextInputType
                          .phone,
                      validator:
                      validatePhone,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 25),

              // ==================================================
              // REQUEST DETAILS
              // ==================================================

              sectionTitle(
                'Request Details',
                'Describe what you need help with.',
                Icons.assignment_outlined,
              ),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  16,
                ),
                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color:
                    UniConnectApp
                        .burgundy
                        .withOpacity(
                      0.10,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.04,
                      ),
                      blurRadius: 8,
                      offset:
                      const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    // SERVICE CATEGORY
                    DropdownButtonFormField<
                        String>(
                      initialValue:
                      selectedService,
                      autovalidateMode:
                      AutovalidateMode
                          .onUserInteraction,
                      decoration:
                      const InputDecoration(
                        labelText:
                        'Service Category',
                        prefixIcon:
                        Icon(
                          Icons
                              .category_outlined,
                          color:
                          UniConnectApp
                              .burgundy,
                        ),
                      ),
                      hint:
                      const Text(
                        'Select a service',
                      ),
                      items: serviceCategories
                          .map(
                            (
                            String service,
                            ) {
                          return DropdownMenuItem<
                              String>(
                            value:
                            service,
                            child:
                            Text(
                              service,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (
                          value,
                          ) {
                        setState(() {
                          selectedService =
                              value;
                        });
                      },
                      validator: (
                          value,
                          ) {
                        if (value ==
                            null) {
                          return 'Please select a service category';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                        height: 14),

                    CampusTextField(
                      controller:
                      _subjectController,
                      label:
                      'Request Subject',
                      hint:
                      'Briefly describe the issue',
                      icon:
                      Icons.subject,
                      validator:
                      validateSubject,
                    ),

                    const SizedBox(
                        height: 14),

                    // REQUEST DETAILS
                    CampusTextField(
                      controller:
                      _detailsController,
                      label:
                      'Request Details',
                      hint:
                      'Explain your request clearly...',
                      icon:
                      Icons
                          .description_outlined,
                      keyboardType:
                      TextInputType
                          .multiline,
                      textInputAction:
                      TextInputAction.done,
                      maxLines: 5,
                      maxLength: 300,
                      validator:
                      validateDetails,
                    ),

                    const SizedBox(
                        height: 8),

                    const Text(
                      'Urgency',
                      style:
                      TextStyle(
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w600,
                        color:
                        UniConnectApp
                            .charcoal,
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    // URGENCY FORM FIELD
                    FormField<String>(
                      initialValue:
                      selectedUrgency,
                      validator: (
                          value,
                          ) {
                        if (selectedUrgency ==
                            null) {
                          return 'Please select an urgency level';
                        }
                        return null;
                      },
                      builder: (
                          field,
                          ) {
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Wrap(
                              spacing: 8,
                              children: [
                                ChoiceChip(
                                  label:
                                  const Text(
                                    'Normal',
                                  ),
                                  selected:
                                  selectedUrgency ==
                                      'Normal',
                                  onSelected:
                                      (
                                      selected,
                                      ) {
                                    if (selected) {
                                      setState(
                                            () {
                                          selectedUrgency =
                                          'Normal';
                                        },
                                      );
                                      field.didChange(
                                        'Normal',
                                      );
                                    }
                                  },
                                  selectedColor:
                                  const Color(
                                    0xFFE6F7F5,
                                  ),
                                ),
                                ChoiceChip(
                                  label:
                                  const Text(
                                    'High',
                                  ),
                                  selected:
                                  selectedUrgency ==
                                      'High',
                                  onSelected:
                                      (
                                      selected,
                                      ) {
                                    if (selected) {
                                      setState(
                                            () {
                                          selectedUrgency =
                                          'High';
                                        },
                                      );
                                      field.didChange(
                                        'High',
                                      );
                                    }
                                  },
                                  selectedColor:
                                  const Color(
                                    0xFFFFF4D6,
                                  ),
                                ),
                                ChoiceChip(
                                  label:
                                  const Text(
                                    'Urgent',
                                  ),
                                  selected:
                                  selectedUrgency ==
                                      'Urgent',
                                  onSelected:
                                      (
                                      selected,
                                      ) {
                                    if (selected) {
                                      setState(
                                            () {
                                          selectedUrgency =
                                          'Urgent';
                                        },
                                      );
                                      field.didChange(
                                        'Urgent',
                                      );
                                    }
                                  },
                                  selectedColor:
                                  const Color(
                                    0xFFFFE4E4,
                                  ),
                                ),
                              ],
                            ),
                            if (field.hasError)
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                  top: 6,
                                  left: 12,
                                ),
                                child: Text(
                                  field
                                      .errorText!,
                                  style:
                                  TextStyle(
                                    color:
                                    Theme.of(
                                      context,
                                    )
                                        .colorScheme
                                        .error,
                                    fontSize:
                                    12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 25),

              // ==================================================
              // PREFERENCES
              // ==================================================

              sectionTitle(
                'Preferences',
                'Choose how and when you would like a response.',
                Icons.tune_outlined,
              ),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  16,
                ),
                decoration:
                BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color:
                    UniConnectApp
                        .teal
                        .withOpacity(
                      0.12,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.04,
                      ),
                      blurRadius: 8,
                      offset:
                      const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    const Text(
                      'Preferred Contact Method',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                        height: 5),

                    // CONTACT FORM FIELD
                    FormField<String>(
                      initialValue:
                      selectedContact,
                      validator: (
                          value,
                          ) {
                        if (selectedContact ==
                            null) {
                          return 'Please select a contact method';
                        }
                        return null;
                      },
                      builder: (
                          field,
                          ) {
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            RadioListTile<
                                String>(
                              contentPadding:
                              EdgeInsets
                                  .zero,
                              title:
                              const Text(
                                'Email',
                              ),
                              value:
                              'Email',
                              groupValue:
                              selectedContact,
                              activeColor:
                              UniConnectApp
                                  .burgundy,
                              onChanged:
                                  (
                                  value,
                                  ) {
                                setState(
                                      () {
                                    selectedContact =
                                        value;
                                  },
                                );
                                field.didChange(
                                  value,
                                );
                              },
                            ),
                            RadioListTile<
                                String>(
                              contentPadding:
                              EdgeInsets
                                  .zero,
                              title:
                              const Text(
                                'Phone',
                              ),
                              value:
                              'Phone',
                              groupValue:
                              selectedContact,
                              activeColor:
                              UniConnectApp
                                  .burgundy,
                              onChanged:
                                  (
                                  value,
                                  ) {
                                setState(
                                      () {
                                    selectedContact =
                                        value;
                                  },
                                );
                                field.didChange(
                                  value,
                                );
                              },
                            ),
                            RadioListTile<
                                String>(
                              contentPadding:
                              EdgeInsets
                                  .zero,
                              title:
                              const Text(
                                'WhatsApp',
                              ),
                              value:
                              'WhatsApp',
                              groupValue:
                              selectedContact,
                              activeColor:
                              UniConnectApp
                                  .burgundy,
                              onChanged:
                                  (
                                  value,
                                  ) {
                                setState(
                                      () {
                                    selectedContact =
                                        value;
                                  },
                                );
                                field.didChange(
                                  value,
                                );
                              },
                            ),
                            if (field.hasError)
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                  left: 12,
                                ),
                                child: Text(
                                  field
                                      .errorText!,
                                  style:
                                  TextStyle(
                                    color:
                                    Theme.of(
                                      context,
                                    )
                                        .colorScheme
                                        .error,
                                    fontSize:
                                    12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(
                        height: 10),

                    const Text(
                      'Preferred Response Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    // DATE FORM FIELD
                    FormField<DateTime>(
                      initialValue:
                      selectedDate,
                      validator: (
                          value,
                          ) {
                        if (selectedDate ==
                            null) {
                          return 'Please select a preferred date';
                        }

                        final today =
                        DateTime.now();

                        final chosen =
                        DateTime(
                          selectedDate!
                              .year,
                          selectedDate!
                              .month,
                          selectedDate!
                              .day,
                        );

                        final currentDay =
                        DateTime(
                          today.year,
                          today.month,
                          today.day,
                        );

                        if (chosen.isBefore(
                          currentDay,
                        )) {
                          return 'Date cannot be in the past';
                        }

                        return null;
                      },
                      builder: (
                          field,
                          ) {
                        return Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            InkWell(
                              onTap: () {
                                pickDate(
                                  field,
                                );
                              },
                              borderRadius:
                              BorderRadius
                                  .circular(
                                14,
                              ),
                              child:
                              InputDecorator(
                                decoration:
                                InputDecoration(
                                  labelText:
                                  'Preferred Date',
                                  prefixIcon:
                                  const Icon(
                                    Icons
                                        .calendar_today_outlined,
                                    color:
                                    UniConnectApp
                                        .burgundy,
                                  ),
                                  errorText:
                                  field
                                      .errorText,
                                ),
                                child:
                                Text(
                                  selectedDate ==
                                      null
                                      ? 'Select a date'
                                      : formatDate(
                                    selectedDate!,
                                  ),
                                  style:
                                  TextStyle(
                                    color:
                                    selectedDate ==
                                        null
                                        ? Colors
                                        .grey
                                        : UniConnectApp
                                        .charcoal,
                                    fontSize:
                                    14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 25),

              // ==================================================
              // CONFIRMATION
              // ==================================================

              sectionTitle(
                'Confirmation',
                'Confirm that the information provided is correct.',
                Icons.verified_user_outlined,
              ),

              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  12,
                ),
                decoration:
                BoxDecoration(
                  color:
                  const Color(0xFFF1ECE7),
                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),
                  border: Border.all(
                    color:
                    UniConnectApp
                        .burgundy
                        .withOpacity(
                      0.10,
                    ),
                  ),
                ),
                child:
                CheckboxListTile(
                  contentPadding:
                  EdgeInsets.zero,
                  controlAffinity:
                  ListTileControlAffinity
                      .leading,
                  activeColor:
                  UniConnectApp
                      .burgundy,
                  value:
                  declarationAccepted,
                  onChanged: (
                      value,
                      ) {
                    setState(() {
                      declarationAccepted =
                          value ?? false;
                    });
                  },
                  title: const Text(
                    'I confirm that the information provided is correct.',
                    style:
                    TextStyle(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                  subtitle:
                  const Text(
                    'I understand that this request is submitted for campus service support.',
                    style:
                    TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  height: 25),

              // ==================================================
              // ACTION BUTTONS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child:
                    ElevatedButton.icon(
                      onPressed:
                      submitForm,
                      icon:
                      const Icon(
                        Icons
                            .send_outlined,
                      ),
                      label:
                      const Text(
                        'Submit Request',
                      ),
                      style:
                      ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        UniConnectApp
                            .burgundy,
                        foregroundColor:
                        Colors.white,
                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical: 15,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10),
                  Expanded(
                    child:
                    OutlinedButton.icon(
                      onPressed:
                      resetForm,
                      icon:
                      const Icon(
                        Icons
                            .refresh_outlined,
                      ),
                      label:
                      const Text(
                        'Reset',
                      ),
                      style:
                      OutlinedButton
                          .styleFrom(
                        foregroundColor:
                        UniConnectApp
                            .burgundy,
                        side:
                        const BorderSide(
                          color:
                          UniConnectApp
                              .burgundy,
                        ),
                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical: 15,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 15),

              // FEEDBACK CARD
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.all(
                  15,
                ),
                decoration:
                BoxDecoration(
                  color:
                  const Color(0xFFE6F7F5),
                  borderRadius:
                  BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    color:
                    UniConnectApp
                        .teal
                        .withOpacity(
                      0.20,
                    ),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color:
                      UniConnectApp
                          .teal,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your request will be reviewed by the selected campus service unit.',
                        style:
                        TextStyle(
                          color:
                          UniConnectApp
                              .teal,
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}