import '../features/lessons/models/lesson.dart';
import '../features/tasks/models/matching/match_pair.dart';
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
      MatchingTask(
        1,
        'Vocabulary Preview',
        'Match each word or phrase with the correct definition.',
        [
          MatchPair('distracted', 'not focused on something'),
          MatchPair('visual', 'related to the use of one’s eyes'),
          MatchPair(
              'manual', 'related to the use of one’s hands, not automatic'),
          MatchPair('cognitive', 'related to the use of one’s mind'),
          MatchPair(
              'behind the wheel', 'driving, being the driver of a vehicle'),
        ],
      ),
      MultipleChoiceTask(2, 'Vocabulary Review', ''),
      SpeakingTask(3, 'Pronunciation', ''),
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
      MatchingTask(
        1,
        'Vocabulary Preview',
        'Match each word or phrase with the correct definition.',
        [
          MatchPair('scandal', 'the public disgrace of an important figure'),
          MatchPair('notify', 'to tell, to make someone aware of something'),
          MatchPair('campaign',
              'an organized effort to promote a candidate or cause'),
          MatchPair('breach', 'a failure to observe a rule or law'),
          MatchPair('policy', 'a rule or guideline'),
          MatchPair(
              'data', 'information that can be stored and shared digitally'),
        ],
      ),
      MultipleChoiceTask(2, 'Vocabulary Review', ''),
      SpeakingTask(3, 'Pronunciation', ''),
    ],
  ),
  Lesson(
    91,
    'Animals',
    'Students learn animal vocabulary through various writing and speaking activities. They also practice question formation and learn common expressions used to talk about animals.',
    ['Beg – Low Int', 'All ages', 'K–12'],
    [
      'foundational',
      'grammar',
      'vocabulary',
      'defining & describing animals',
      'asking & answering questions',
      'to be',
      'adjectives',
      'simple present',
      'productive'
    ],
    [
      'anteater',
      'armadillo',
      'baboon',
      'bear',
      'beaver',
      'bison',
      'camel',
      'cat',
      'chimpanzee',
      'chipmunk',
      'deer',
      'dog',
      'donkey',
      'elephant',
      'more...'
    ],
    'assets/images/91_Animals.webp',
    [
      SpeakingTask(1, 'Speaking', ''),
    ],
  )
];
