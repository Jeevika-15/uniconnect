import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  static const burgundy = Color(0xFF7F1D1D);
  static const teal = Color(0xFF0D9488);
  static const cream = Color(0xFFFAF8F5);

  late final Future<void> _authFuture = _ensureSignedIn();

  Future<void> _ensureSignedIn() async {
    final auth = FirebaseAuth.instance;

    // Wait for Firebase's existing authentication session.
    await auth.authStateChanges().first;

    // Sign in only if there is no existing session.
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }

    debugPrint('AUTH UID: ${auth.currentUser?.uid}');
  }

  String statusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'Pending review';
      case 'in_progress':
        return 'In progress';
      case 'resolved':
        return 'Resolved';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Submitted';
    }
  }

  Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange.shade800;
      case 'in_progress':
        return Colors.blue.shade700;
      case 'resolved':
        return Colors.green.shade700;
      case 'rejected':
        return Colors.red.shade700;
      default:
        return teal;
    }
  }

  String formatDate(dynamic value) {
    if (value is! Timestamp) return 'Date unavailable';

    final date = value.toDate();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _authFuture,
      builder: (context, authSnapshot) {
        if (authSnapshot.hasError) {
          return _messageScreen(
            icon: Icons.cloud_off_outlined,
            title: 'Connection problem',
            message:
            'Unable to connect to Firebase. Please check your '
                'internet connection and try again.',
          );
        }

        if (authSnapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: cream,
            body: Center(
              child: CircularProgressIndicator(color: burgundy),
            ),
          );
        }

        final user = FirebaseAuth.instance.currentUser;
        debugPrint('MY REQUESTS UID: ${user?.uid}');

        if (user == null) {
          return _messageScreen(
            icon: Icons.person_off_outlined,
            title: 'Unable to connect',
            message: 'Please try opening My Requests again.',
          );
        }

        return Scaffold(
          backgroundColor: cream,
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('campusRequests')
                .where('ownerUid', isEqualTo: user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _messageScreen(
                  icon: Icons.cloud_off_outlined,
                  title: 'Could not load requests',
                  message:
                  'Please check your connection and try again.',
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: burgundy),
                );
              }

              final requests = snapshot.data?.docs.toList() ?? [];

              requests.sort((a, b) {
                final aDate = a.data()['createdAt'];
                final bDate = b.data()['createdAt'];

                final aTime = aDate is Timestamp
                    ? aDate.millisecondsSinceEpoch
                    : 0;
                final bTime = bDate is Timestamp
                    ? bDate.millisecondsSinceEpoch
                    : 0;

                return bTime.compareTo(aTime);
              });

              if (requests.isEmpty) {
                return _messageScreen(
                  icon: Icons.assignment_outlined,
                  title: 'No requests yet',
                  message:
                  'Requests submitted from this account will '
                      'appear here with their latest status.',
                );
              }

              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
                children: [
                  const Text(
                    'My Requests',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: burgundy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${requests.length} request'
                        '${requests.length == 1 ? '' : 's'} submitted',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...requests.map((doc) {
                    final data = doc.data();
                    final status =
                        data['status']?.toString() ?? 'submitted';
                    final color = statusColor(status);

                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: burgundy.withOpacity(0.10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: burgundy.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.assignment_outlined,
                                    color: burgundy,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['subject']?.toString() ??
                                            'Campus request',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        data['serviceCategory']?.toString() ??
                                            'Campus service',
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    status == 'resolved'
                                        ? Icons.check_circle_outline
                                        : status == 'rejected'
                                        ? Icons.cancel_outlined
                                        : Icons.schedule,
                                    color: color,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    statusLabel(status),
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if ((data['description']?.toString() ?? '')
                                .isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Text(
                                data['description'].toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  height: 1.45,
                                ),
                              ),
                            ],

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 15,
                                  color: Colors.black45,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  'Submitted ${formatDate(data['createdAt'])}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),
                            const Divider(),
                            const SizedBox(height: 12),

                            const Text(
                              'Request progress',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            _ProgressSteps(status: status),

                            const SizedBox(height: 12),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: cream,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                status == 'resolved'
                                    ? 'Your request has been resolved.'
                                    : status == 'rejected'
                                    ? 'Your request was declined. '
                                    'Contact the relevant campus '
                                    'office for clarification.'
                                    : status == 'in_progress'
                                    ? 'The campus team is working '
                                    'on your request.'
                                    : status == 'pending'
                                    ? 'Your request is awaiting '
                                    'review by the campus team.'
                                    : 'Your request has been '
                                    'submitted successfully.',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  height: 1.4,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            SelectableText(
                              'Reference ID: ${doc.id}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _messageScreen({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Scaffold(
      backgroundColor: cream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 60, color: burgundy),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: burgundy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressSteps extends StatelessWidget {
  const _ProgressSteps({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Submitted',
      'Pending review',
      'In progress',
      'Resolved',
    ];

    final rejected = status == 'rejected';

    final currentStep = switch (status) {
      'pending' => 1,
      'in_progress' => 2,
      'resolved' => 3,
      'rejected' => 1,
      _ => 0,
    };

    return Column(
      children: List.generate(labels.length, (index) {
        final completed = !rejected && index <= currentStep;
        final isRejectedStep = rejected && index == 1;
        final isCurrent = index == currentStep && !rejected;

        final color = isRejectedStep
            ? Colors.red
            : completed
            ? const Color(0xFF0D9488)
            : Colors.grey.shade400;

        return Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: Row(
            children: [
              Icon(
                isRejectedStep
                    ? Icons.cancel
                    : completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: color,
                size: 21,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isRejectedStep ? 'Request declined' : labels[index],
                  style: TextStyle(
                    color: completed || isRejectedStep
                        ? Colors.black87
                        : Colors.black45,
                    fontWeight: completed || isRejectedStep
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
              if (isCurrent)
                const Text(
                  'CURRENT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF0D9488),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
