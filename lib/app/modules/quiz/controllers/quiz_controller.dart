import 'package:get/get.dart';

class QuizController extends GetxController {
  final questions = const [
    {
      'questionText': '1. Naon basa Sundana "makan"?',
      'answers': [
        {'text': 'A. Nulis', 'score': -5},
        {'text': 'B. Maca', 'score': -5},
        {'text': 'C. Dahar', 'score': 20},
        {'text': 'D. Diajar', 'score': -5},
      ],
    },
    {
      'questionText': '2. Naon basa Sundana "minum"?',
      'answers': [
        {'text': 'A. Tuang', 'score': -5},
        {'text': 'B. Hees', 'score': -5},
        {'text': 'C. Maén', 'score': -5},
        {'text': 'D. Nginum', 'score': 20},
      ],
    },
    {
      'questionText': '3. Naon basa Sundana "tidur"?',
      'answers': [
        {'text': 'A. Nyarios', 'score': -5},
        {'text': 'B. Sare', 'score': 20},
        {'text': 'C. Diajar', 'score': -5},
        {'text': 'D. Sumping', 'score': -5},
      ],
    },
    {
      'questionText': '4. Naon basa Sundana "berbicara"?',
      'answers': [
        {'text': 'A. Nyarios', 'score': 20},
        {'text': 'B. Dahar', 'score': -5},
        {'text': 'C. Nginum', 'score': -5},
        {'text': 'D. Maén', 'score': -5},
      ],
    },
    {
      'questionText': '5. Naon basa Sundana "bermain"?',
      'answers': [
        {'text': 'A. Nulis', 'score': -5},
        {'text': 'B. Maca', 'score': -5},
        {'text': 'C. Maén', 'score': 20},
        {'text': 'D. Diajar', 'score': -5},
      ],
    },
  ];

  var questionIndex = 0.obs;
  var totalScore = 0.obs;
  var isLoading = false.obs;
  var userName = ''.obs;
  var nameEntered = false.obs;

  void answerQuestion(int score) {
    totalScore.value += score;

    if (questionIndex.value < questions.length - 1) {
      questionIndex.value++;
    } else {
      questionIndex.value = questions.length;  
    }
  }

  void resetQuiz() {
    questionIndex.value = 0;
    totalScore.value = 0;
  }

  void fetchQuizData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
  }

  void setName(String name) {
    userName.value = name;
    nameEntered.value = true;
  }
}
