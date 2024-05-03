import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:calories_mate/screens/k_ten_scale/models/questions.dart';
import 'package:calories_mate/screens/k_ten_scale/screens/score/score_screen.dart';

class QuestionController extends GetxController {
  late int scoretotal = 0;
  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sampleData
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOffiveScoreAns = 0;
  int _numOffourScoreAns = 0;
  int _numOfthreeScoreAns = 0;
  int _numOftwoScoreAns = 0;
  int _numOfoneScoreAns = 0;
  int get numOffiveScoreAns => _numOffiveScoreAns;
  int get numOffourScoreAns => _numOffourScoreAns;
  int get numOfthreeScoreAns => _numOfthreeScoreAns;
  int get numOftwoScoreAns => _numOftwoScoreAns;
  int get numOfoneScoreAns => _numOfoneScoreAns;
  final int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_selectedAns == 0) _numOffiveScoreAns++;
    if (_selectedAns == 1) _numOffourScoreAns++;
    if (_selectedAns == 2) _numOfthreeScoreAns++;
    if (_selectedAns == 3) _numOftwoScoreAns++;
    if (_selectedAns == 4) _numOfoneScoreAns++;

    update();

    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
    scoretotal = numOffiveScoreAns * 5 +
        numOffourScoreAns * 4 +
        numOfthreeScoreAns * 3 +
        numOftwoScoreAns * 2 +
        numOfoneScoreAns * 1;
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.ease);
    } else {
      Get.to(() => const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
