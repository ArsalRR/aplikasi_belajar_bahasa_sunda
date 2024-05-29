import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart'; 
import 'package:quickalert/quickalert.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    Future.delayed(Duration.zero, () {
      if (!controller.nameEntered.value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Masukkan Nama'),
              content: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      controller.setName(nameController.text);
                      Get.back();
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 150,
                color: const Color(0xff008DDA),
                child: AppBar(
                  title: const Text(
                    'Quiz Bahasa Sunda',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.questionIndex.value < controller.questions.length) {
                  return Quiz(
                    answerQuestion: controller.answerQuestion,
                    questionIndex: controller.questionIndex.value,
                    questions: controller.questions,
                  );
                } else {
                  return Result(
                    controller.totalScore.value,
                    controller.resetQuiz,
                    controller.userName.value,
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'].toString(),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            () => answerQuestion(answer['score'] as int),
            answer['text'].toString(),
          );
        }).toList()
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  const Question(this.questionText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectHandler,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff008DDA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            answerText,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;
  final String userName;

  const Result(this.resultScore, this.resetHandler, this.userName, {Key? key})
      : super(key: key);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 90) {
      resultText = 'Sempurna';
    } else if (resultScore >= 75) {
      resultText = 'Lumayan';
    } else if (resultScore >= 60) {
      resultText = 'Tingkatkan Belajarmu';
    } else if (resultScore >= 10) {
      resultText = 'Harus Banyak Membaca';
    } else {
      resultText = 'Nilaimu Jelek';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hai $userName!',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Nilai Anda: $resultScore\n$resultPhrase',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resetHandler,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff008DDA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Ulangi',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
