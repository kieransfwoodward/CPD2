import 'package:cpd/widgets/quiz/drag_and_drop.dart';
import 'package:cpd/widgets/quiz/learn_text_input.dart';
import 'package:cpd/widgets/quiz/single_image_multiple_choice_question.dart';
import 'package:flutter/material.dart';

import '../../widgets/quiz/ImagePainterExample.dart';
import '../../widgets/quiz/draggable_list.dart';
import '../../widgets/quiz/learn_image.dart';
import '../../widgets/quiz/learn_text.dart';
import '../../widgets/quiz/learn_video.dart';
import '../../widgets/quiz/single_multiple_choice_question.dart';

// Deals with question specific functions
class QuestionFunctions {
  // Returns a widget based on the question type from Firebase
  Widget getQuestionType({
    required String type,
    required Map<String, dynamic> data,
    required String moduleId,
    required String questionNumber,
  }) {
    if (type.contains("single_image_multiple_choice")) {
      return SingleImageMultipleChoiceQuestion(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type.contains("single_multiple_choice")) {
      return SingleMultipleChoiceQuestion(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_text") {
      return learn_text(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_image") {
      return LearnImage(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type.contains("learn_video")) {
      return learn_video(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "learn_text_input") {
      return learn_text_input(
        moduleId: moduleId,
        questionNumber: questionNumber,
        data: data,
      );
    }
    if (type == "drag_drop_module_one") {
      return ExpansionTileExample(
      );
    }
    if (type == "drag_drop_module_three") {
      return drag_and_drop(
      );
    }
    if (type == "painter") {
      return ImagePainterExample(
      );
    }
    return Container();
  }
}
