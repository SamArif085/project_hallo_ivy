
class QuestionModel {
  String id;
  String question;
  String answer;
  String imageUrl;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answer,
    this.imageUrl = '',
  });

  void setAnswer(String getAnswer) {
    answer = getAnswer;
  }

  void setImageUrl(String getImageUrl) {
    imageUrl = getImageUrl;
  }

  String getQuestion() {
    return question;
  }

  String getAnswer() {
    return answer;
  }

  String getImageUrl() {
    return imageUrl;
  }
}
