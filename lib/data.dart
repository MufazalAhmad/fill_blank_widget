import 'package:untitled/fill_blank_question_model.dart';

List<FillBlankQuestion> questions = [
  FillBlankQuestion(
    id: 1,
    text:
        "Sometimes you are not able to calm a situation. If that is the case, you should: Get away from the {[hurt]} person and exit the situation. If necessary, find somewhere safe to stop the vehicle, turn off the engine, take the keys then get out of the vehicle. If the passenger is planning to {[aggressive]} you, they will probably get out of the {[vehicle]} too.",
    reset: false,
    options: [
      "hurt",
      "aggressive",
      "vehicle",
      'help',
      'arm',
      'passenger',
    ],
  ),
  FillBlankQuestion(
    id: 2,
    text:
        "If your {[help]} is ill, or has a disability, and asks you to help them enter or leave your vehicle, make sure you check exactly what {[arm]} they are asking you for, for example to take hold of your{[passenger]}to support them.",
    reset: false,
    options: [
      'help',
      'arm',
      'passenger',
      "hurt",
      "aggressive",
      "vehicle",
    ],
  ),
  FillBlankQuestion(
    id: 3,
    text:
        "Operators must keep details of all {[complaints]} made to them. Operators must report to the police any {[complaints]} that involve possible {[crimes]}, so that they can be investigated.",
    reset: false,
    options: [
      'complaints',
      'complaints',
      'crimes',
      "hurt",
      "aggressive",
      "vehicle",
    ],
  ),
];
