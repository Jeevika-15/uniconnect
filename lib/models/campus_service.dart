class CampusService {
  final String name;
  final String description;
  final String location;
  final String hours;
  final String icon;

  const CampusService({
    required this.name,
    required this.description,
    required this.location,
    required this.hours,
    required this.icon,
  });
}

const List<CampusService> campusServices = [
  CampusService(
    name: 'Academic Support',
    description:
    'Get help with academic queries, course registration, examinations and academic guidance.',
    location: 'Academic Block',
    hours: '9:00 AM - 4:00 PM',
    icon: '📚',
  ),
  CampusService(
    name: 'Library Services',
    description:
    'Access books, digital resources, study spaces and other library facilities.',
    location: 'Central Library',
    hours: '8:00 AM - 8:00 PM',
    icon: '📖',
  ),
  CampusService(
    name: 'IT Support',
    description:
    'Get assistance with student accounts, Wi-Fi, computer labs and technical issues.',
    location: 'IT Help Desk',
    hours: '9:00 AM - 5:00 PM',
    icon: '💻',
  ),
  CampusService(
    name: 'Accommodation',
    description:
    'Get information and assistance related to hostel accommodation and residential facilities.',
    location: 'Hostel Office',
    hours: '9:00 AM - 5:00 PM',
    icon: '🏠',
  ),
  CampusService(
    name: 'Career & Placement',
    description:
    'Get support with internships, placements, resumes, interviews and career opportunities.',
    location: 'Career Development Centre',
    hours: '10:00 AM - 4:00 PM',
    icon: '💼',
  ),
  CampusService(
    name: 'Student Activities',
    description:
    'Explore clubs, events, cultural activities, sports and student engagement opportunities.',
    location: 'Student Activity Centre',
    hours: '10:00 AM - 6:00 PM',
    icon: '🎉',
  ),
];