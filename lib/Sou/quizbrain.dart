import './question.dart';

class QuizBrain {
  List<Questions> questions = [
    Questions(questiontext: "Do I regret being here", answer: !true),
    Questions(questiontext: "Do I want to sleep", answer: true),
    Questions(questiontext: "Am I hungry", answer: true),
    Questions(questiontext: "Is there Corona in NITC", answer: !true),
    Questions(questiontext: "Is Corona dangerous", answer: true),
    Questions(questiontext: "Is the earth flat", answer: !true),
    Questions(questiontext: "Do vaccines cause austism", answer: !true)
  ];
int currentquestion = 0;
bool isFinished()
{
  if(currentquestion>=questions.length-1)
  return true;
  return false;
}

void next()
{
  if(currentquestion<questions.length-1)
  {
    currentquestion++;
  }
}
  String getquestion()
  {
    return questions[currentquestion].questiontext;
  }

  bool correctanswer()
  {
    return questions[currentquestion].answer;
  }

  void resetQuestions()
  {
    currentquestion=0;
  }



}