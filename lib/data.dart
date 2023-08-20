import 'package:untitled/fill_blank_question.dart';

List<FillBlankQuestion> questions = [
  FillBlankQuestion(
    text:
        "Sometimes you are not able to calm a situation. If that is the case, you should: Get away from the {[hurt]} person and exit the situation. If necessary, find somewhere safe to stop the vehicle, turn off the engine, take the keys then get out of the vehicle. If the passenger is planning to {[aggressive]} you, they will probably get out of the {[vehicle]} too.",
    options: ["hurt", "aggressive", "vehicle"],
  ),
  FillBlankQuestion(
    text:
        "If your {[help]} is ill, or has a disability, and asks you to help them enter or leave your vehicle, make sure you check exactly what {[arm]} they are asking you for, for example to take hold of your{[passenger]}to support them.",
    options: ['Help', 'Arm', 'Passenger'],
  ),
  FillBlankQuestion(
    text:
        "Operators must keep details of all {[complaints]} made to them. Operators must report to the police any {[complaints]} that involve possible {[crimes]}, so that they can be investigated.",
    options: ['complaints', 'complaints', 'crimes'],
  ),
];
