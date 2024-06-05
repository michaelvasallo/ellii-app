import '../features/lessons/models/lesson.dart';
import '../features/tasks/models/matching_task.dart';
import '../features/tasks/models/multiple_choice_task.dart';
import '../features/tasks/models/speaking_task.dart';

final List<Lesson> lessons = [
  Lesson(
    72,
    'Distracted Driving',
    'Students read about the different types of distractions drivers have, including texting, playing music, and even eating while driving. They practice related vocabulary and discuss hands-free devices.',
    ['Int – High Int', 'Teens & Adults', 'Grades 9–12'],
    [
      'topic-based',
      '4-skills',
      'driving',
      'texting',
      'expressing opinions',
      'critical thinking',
      'even (as adverb and adjective)',
      'interpretive',
      'productive',
      'interactive'
    ],
    [
      'distracted',
      'visual',
      'manual',
      'cognitive',
      'behind the wheel',
      'driver error',
      'GPS',
      'fiddle',
      'think twice',
      'split second'
    ],
    'assets/images/72_Distracted-Driving.webp',
    [
      MatchingTask('Task 1'),
      SpeakingTask('Task 2'),
    ],
  ),
  Lesson(
    73,
    'Online Privacy',
    "Students read about Facebook's historic privacy breach that put CEO Mark Zuckerberg in the hot seat in 2018. The lesson includes vocabulary review exercises, comprehension questions, discussion questions, debate questions, a writing task, and additional, optional activities. Useful expressions for debates are included.",
    ['High Int – Adv', 'Teens & Adults', 'Grades 9–12'],
    [
      'topic-based',
      '4-skills',
      'technology',
      'social media',
      'ethics',
      'agreeing & disagreeing',
      'interpretive',
      'productive',
      'interactive'
    ],
    [
      'data',
      'policy',
      'breach',
      'campaign',
      'notify',
      'scandal',
      'whistle-blower',
      'backlash',
      'testify',
      'regulate',
      'default',
      'opt out'
    ],
    'assets/images/73_Online-Privacy.webp',
    [
      MultipleChoiceTask('Task 1'),
    ],
  ),
];
