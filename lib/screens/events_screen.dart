import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class CampusEvent {
  final String title;
  final String date;
  final String time;
  final String venue;
  final String description;
  final IconData icon;

  const CampusEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.description,
    required this.icon,
  });
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  static const List<CampusEvent> events = [
    CampusEvent(
      title: 'Coding Workshop',
      date: '29 September 2026',
      time: '10:00 AM - 12:00 PM',
      venue: 'Computer Lab, Block A',
      description:
      'Learn practical programming skills and solve coding problems with other students.',
      icon: Icons.code,
    ),
    CampusEvent(
      title: 'Career Discovery Workshop',
      date: '10 October 2026',
      time: '10:00 AM - 12:00 PM',
      venue: 'Seminar Hall',
      description:
      'Meet industry professionals and learn about internships, placements and career opportunities.',
      icon: Icons.work_outline,
    ),
    CampusEvent(
      title: 'Cultural Night',
      date: '15 October 2026',
      time: '6:00 PM - 9:00 PM',
      venue: 'Main Auditorium',
      description:
      'Enjoy music, dance and cultural performances organised by university students.',
      icon: Icons.music_note,
    ),
    CampusEvent(
      title: 'Sports Day',
      date: '20 October 2026',
      time: '9:00 AM - 3:00 PM',
      venue: 'University Sports Ground',
      description:
      'Take part in exciting sports activities and compete with students across campus.',
      icon: Icons.sports_basketball,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'Campus Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF7F1D1D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7F1D1D),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campus Events',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Discover events and activities happening at Mody University.',
                            style: TextStyle(
                              color: Colors.white70,
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

              const SizedBox(height: 24),

              const Text(
                'Upcoming Events',
                style: TextStyle(
                  color: Color(0xFF292524),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...events.map(
                    (event) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF7F1D1D)
                            .withOpacity(0.10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(18),
                      onTap: () {
                        // Direct Navigator.push()
                        // using MaterialPageRoute.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EventDetailScreen(
                                  event: event,
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 62,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                const Color(0xFFE6F7F5),
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.event,
                                    color:
                                    Color(0xFF0D9488),
                                    size: 23,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.date
                                        .split(' ')[0],
                                    style: const TextStyle(
                                      color:
                                      Color(0xFF0D9488),
                                      fontSize: 11,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style:
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                      color:
                                      Color(0xFF292524),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    event.date,
                                    style:
                                    const TextStyle(
                                      color:
                                      Color(0xFF7F1D1D),
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.venue,
                                    style: TextStyle(
                                      color:
                                      Colors.grey.shade600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFF7F1D1D),
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}