class Experience {
  final String company;
  final String role;
  final String period;
  final String description;
  final bool isCurrent;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    this.isCurrent = false,
  });
}

class Project {
  final String title;
  final String description;
  final String emoji;
  final String? url;
  final List<String> tags;
  final bool isLive;

  const Project({
    required this.title,
    required this.description,
    required this.emoji,
    this.url,
    required this.tags,
    this.isLive = false,
  });
}

class Education {
  final String institution;
  final String degree;
  final String year;
  final String score;
  final bool isHighlight;

  const Education({
    required this.institution,
    required this.degree,
    required this.year,
    required this.score,
    this.isHighlight = false,
  });
}

class SkillGroup {
  final String category;
  final String icon;
  final List<String> skills;

  const SkillGroup({
    required this.category,
    required this.icon,
    required this.skills,
  });
}

class AppData {
  static const List<Experience> experiences = [
    Experience(
      company: 'Cubeten Technology',
      role: 'Software Developer',
      period: '03 Jan 2024 – Present',
      description:
          'Building production-grade Flutter applications and web solutions. Architecting scalable software systems while continuously enhancing technical expertise across the full development lifecycle.',
      isCurrent: true,
    ),
    Experience(
      company: 'Globizs',
      role: 'Flutter Developer Intern',
      period: '13 Nov 2022 – 31 Oct 2023',
      description:
          'Developed and maintained cross-platform mobile applications using Flutter, collaborating with design and backend teams to deliver seamless user experiences.',
    ),
    Experience(
      company: 'Nielit',
      role: 'Flutter Developer Training',
      period: '01 May 2022 – 11 Jan 2022',
      description:
          'Completed intensive Flutter development training, mastering mobile app development fundamentals with Dart and the Flutter framework.',
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Image Classification (Deep Learning)',
      description:
          'Classifies images into distinct categories. Specialized in Medical X-Ray image classification using deep learning for diagnosis assistance.',
      emoji: '🧠',
      tags: ['Python', 'Deep Learning', 'Medical AI'],
    ),
    Project(
      title: 'Music Classification (Deep Learning)',
      description:
          'Classifies 10 different genres of music using deep learning. Automatically categorizes audio tracks into distinct music genre categories.',
      emoji: '🎵',
      tags: ['Python', 'Deep Learning', 'Audio ML'],
    ),
    Project(
      title: 'DMIS Department Website',
      description:
          'Official government website for the department to manage office workflows and administrative tasks efficiently.',
      emoji: '🏛️',
      url: 'https://dmis.mn.gov.in/',
      tags: ['Web', 'Government', 'Admin'],
      isLive: true,
    ),
    Project(
      title: 'Yumsharol Consultancy',
      description:
          'Professional construction website for showcasing house and building projects, services, and portfolio.',
      emoji: '🏗️',
      url: 'https://yumsharol.web.app',
      tags: ['Flutter Web', 'Construction'],
      isLive: true,
    ),
    Project(
      title: 'MeiteiMayek Transliteration',
      description:
          'Converts Manipuri words written in English letters into Meitei Mayek script — preserving indigenous culture digitally.',
      emoji: '🔤',
      url: 'https://meiteimayektransliteration.web.app',
      tags: ['Flutter Web', 'NLP', 'Culture'],
      isLive: true,
    ),
    Project(
      title: 'Yek Love Checker (Android)',
      description:
          'Helps couples verify Yek Salai lineage before marriage, preserving Meitei cultural tradition and harmony.',
      emoji: '💑',
      url: 'https://play.google.com',
      tags: ['Flutter', 'Android', 'Google Play'],
      isLive: true,
    ),
  ];

  static const List<Education> educations = [
    Education(
      institution: 'Manipur University',
      degree: 'MCA – Master in Computer Application',
      year: '2022',
      score: '82',
      isHighlight: true,
    ),
    Education(
      institution: 'DM College of Science',
      degree: 'BSc – Graduation',
      year: '2017',
      score: '56',
    ),
    Education(
      institution: 'Temple of Learning',
      degree: 'COHSEM – 12th Exam',
      year: '2014',
      score: '71.8',
    ),
    Education(
      institution: 'Standard Robarth Hr. Sec School',
      degree: 'HSLC – 10th Exam',
      year: '2012',
      score: '70',
    ),
  ];

  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      category: 'Mobile & Core',
      icon: '📱',
      skills: ['Flutter', 'Dart', 'Android', 'iOS'],
    ),
    SkillGroup(
      category: 'Languages',
      icon: '💻',
      skills: [
        'Dart',
        'Python',
        'C',
        'JavaScript',
      ],
    ),
    SkillGroup(
      category: 'Frontend & Web',
      icon: '🌐',
      skills: ['Flutter Web', 'HTML', 'CSS', 'Responsive UI'],
    ),
    SkillGroup(
      category: 'AI / Deep Learning',
      icon: '🧠',
      skills: ['Image Classification', 'Deep Learning'],
    ),
    SkillGroup(
      category: 'Tools & Software',
      icon: '🛠️',
      skills: ['Git', 'Photoshop', 'MS Office', 'Excel'],
    ),
    SkillGroup(
      category: 'Languages Spoken',
      icon: '🌍',
      skills: ['Manipuri (Native)', 'English (Proficient)'],
    ),
  ];

  static const List<String> strengths = [
    'Stay focused on work until it is completed — delivering consistent, high-quality results on every project.',
    'Solve problems quickly and efficiently using any means necessary — resourceful and adaptable under pressure.',
    'Handle programming errors effectively using resources like Google and YouTube — continuous learning mindset.',
  ];
}
