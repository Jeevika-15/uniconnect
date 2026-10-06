import 'package:flutter/material.dart';
import '../models/campus_service.dart';
import '../routes/app_routes.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text(
          'Campus Services',
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
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.miscellaneous_services_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'How can we help?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Choose a campus service to view details and submit a request.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Available Services',
                style: TextStyle(
                  color: Color(0xFF292524),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Tap a service to learn more.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 15),

              // SERVICE CARDS
              ...campusServices.map(
                    (service) {
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
                          color:
                          Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(18),
                      onTap: () async {
                        // Pass the selected service
                        // to the details screen.
                        final result =
                        await Navigator.pushNamed(
                          context,
                          AppRoutes.serviceDetail,
                          arguments: service,
                        );

                        // Show returned result.
                        if (result != null &&
                            context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                result.toString(),
                              ),
                              behavior:
                              SnackBarBehavior.floating,
                              backgroundColor:
                              const Color(0xFF0D9488),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // ICON
                            Container(
                              width: 58,
                              height: 58,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFF1ECE7,
                                ),
                                borderRadius:
                                BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: Text(
                                service.icon,
                                style: const TextStyle(
                                  fontSize: 27,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // SERVICE INFORMATION
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style:
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Color(
                                        0xFF292524,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 5),
                                  Text(
                                    service.location,
                                    style:
                                    const TextStyle(
                                      color: Color(
                                        0xFF0D9488,
                                      ),
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 4),
                                  Text(
                                    service.hours,
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
                              Icons
                                  .arrow_forward_ios_rounded,
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