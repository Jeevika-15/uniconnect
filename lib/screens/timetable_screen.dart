import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  // Reusable class card
  Widget classCard({
    required String day,
    required String time,
    required String module,
    required String room,
    required IconData icon,
    bool isNext = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNext
            ? const Color(0xFFE6F7F5)
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isNext
              ? const Color(0xFF0D9488)
              .withOpacity(0.30)
              : const Color(0xFF7F1D1D)
              .withOpacity(0.10),
          width: isNext ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // Time and day
          Container(
            width: 72,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              color: isNext
                  ? const Color(0xFF0D9488)
                  : const Color(0xFFF1ECE7),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isNext
                        ? Colors.white
                        : const Color(0xFF7F1D1D),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isNext
                        ? Colors.white70
                        : Colors.grey.shade700,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Class information
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isNext
                            ? const Color(0xFF0D9488)
                            .withOpacity(0.12)
                            : const Color(0xFF7F1D1D)
                            .withOpacity(0.08),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        size: 20,
                        color: isNext
                            ? const Color(0xFF0D9488)
                            : const Color(0xFF7F1D1D),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        module,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF292524),
                        ),
                      ),
                    ),

                    if (isNext)
                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFF0D9488),
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.room_outlined,
                      size: 16,
                      color: Color(0xFF0D9488),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      room,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ],
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
    return Scaffold(
      backgroundColor:
      const Color(0xFFFAF8F5),

      appBar: AppBar(
        title: const Text(
          'My Timetable',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
        const Color(0xFF7F1D1D),
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
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // =================================================
              // HEADER
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7F1D1D),
                  borderRadius:
                  BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
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
                            'Weekly Timetable',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Your upcoming classes at Mody University.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
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
                'Upcoming Classes',
                style: TextStyle(
                  color: Color(0xFF292524),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // =================================================
              // NEXT CLASS
              // =================================================

              classCard(
                day: 'MON',
                time: '10:00 AM',
                module:
                'Machine Learning',
                room: 'Computer Lab 2',
                icon: Icons.auto_awesome,
                isNext: true,
              ),

              classCard(
                day: 'TUE',
                time: '11:00 AM',
                module:
                'Data Mining & Predictive Analysis',
                room: 'Block C - Room 204',
                icon: Icons.analytics_outlined,
              ),

              classCard(
                day: 'WED',
                time: '9:00 AM',
                module:
                'Mobile Application Development',
                room: 'Mobile Lab',
                icon: Icons.phone_android_outlined,
              ),

              classCard(
                day: 'THU',
                time: '2:00 PM',
                module:
                'Cross Platform Mobile Development',
                room: 'Innovation Lab',
                icon: Icons.devices_outlined,
              ),

              classCard(
                day: 'FRI',
                time: '11:00 AM',
                module:
                'ERP Programming',
                room: 'Computer Lab 1',
                icon: Icons.business_center_outlined,
              ),

              const SizedBox(height: 10),

              // =================================================
              // TIMETABLE TIP
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7F5),
                  borderRadius:
                  BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF0D9488)
                        .withOpacity(0.20),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF0D9488),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tip: Your next class is highlighted in teal for quick identification.',
                        style: TextStyle(
                          color: Color(0xFF0D9488),
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