import 'dart:convert';

class Score{
  String username = "";
  int score = 0;
  Score(username,score){
      this.username = username;
      this.score = score;
  }
  String toJson(){
    return json.encode({'username': username, 'score':score});
  }
}