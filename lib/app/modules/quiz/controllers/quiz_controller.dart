import 'package:get/get.dart';

class QuizController extends GetxController {
 final questions = const [
  {
    'questionText': '1. Naon basa Sundana "makan"?',
    'answers': [
      {'text': 'Nulis', 'score': -2},
      {'text': 'Maca', 'score': -2},
      {'text': 'Dahar', 'score': 20},
      {'text': 'Diajar', 'score': -2},
    ],
  },
  {
    'questionText': '2. Naon basa Sundana "minum"?',
    'answers': [
      {'text': 'Tuang', 'score': -2},
      {'text': 'Hees', 'score': -2},
      {'text': 'Maén', 'score': -2},
      {'text': 'Nginum', 'score': 20},
    ],
  },
  {
    'questionText': '3. Naon basa Sundana "tidur"?',
    'answers': [
      {'text': 'Nyarios', 'score': -2},
      {'text': 'Sare', 'score': 20},
      {'text': 'Diajar', 'score': -2},
      {'text': 'Sumping', 'score': -2},
    ],
  },
  {
    'questionText': '4. Naon basa Sundana "berbicara"?',
    'answers': [
      {'text': 'Nyarios', 'score': 20},
      {'text': 'Dahar', 'score': -2},
      {'text': 'Nginum', 'score': -2},
      {'text': 'Maén', 'score': -2},
    ],
  },
  {
    'questionText': '5. Naon basa Sundana "bermain"?',
    'answers': [
      {'text': 'Nulis', 'score': -2},
      {'text': 'Maca', 'score': -2},
      {'text': 'Maén', 'score': 20},
      {'text': 'Diajar', 'score': -2},
    ],
  },
];

  var questionIndex = 0.obs;
  var totalScore = 0.obs;
  var isLoading = false.obs;

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
}
