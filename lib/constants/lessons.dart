import '../features/lessons/models/lesson.dart';
import '../features/tasks/models/matching_task.dart';
import '../features/tasks/models/multiple_choice_task.dart';
import '../features/tasks/models/speaking_task.dart';

final List<Lesson> lessons = [
  Lesson(
    72,
    'Distracted Driving',
    'Overview of Lesson 1',
    'assets/images/72_Distracted-Driving.webp',
    [
      MatchingTask('Task 1'),
      SpeakingTask('Task 2'),
    ],
  ),
  Lesson(
    73,
    'Online Privacy',
    'Overview of Lesson 2',
    'assets/images/73_Online-Privacy.webp',
    [
      MultipleChoiceTask('Task 1'),
    ],
  ),
];
