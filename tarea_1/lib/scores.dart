import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tarea_1/Score.dart';
import 'package:http/http.dart' as http;

class ScoresScreen extends StatefulWidget {
  final int score;
  const ScoresScreen({Key? key, required this.score}) : super(key: key);

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<Score> scores = [];
  List<Score> orderedScores = [];

  @override
  void initState() {
    super.initState();
    getScores();
  }
  Future<void>getScores()async{
  String apikey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhbnV1bmNobHhwd290amFwc21yIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYzMTc1MDUsImV4cCI6MjAxMTg5MzUwNX0._m-7Nocw3uImJE7TRZXNS_4aILCH4VqD5Ez2UkJlmUE';
  final response = await http.get(
  Uri.parse('https://tanuunchlxpwotjapsmr.supabase.co/rest/v1/puntuaciones?select=*'),
  headers: {
    'apikey': apikey,
    'Authorization': 'Bearer $apikey'
  },
);
  if (response.statusCode==200){
    final List<dynamic> responseJson = jsonDecode(response.body);
    print(response.body);
    for (var i  in responseJson) {
      scores.add(Score(i["username"], i["score"]));
      setState(() {});
    }
    //List<Score> orderedScores = scores.sort((a, b) => a.score.compareTo(b.score));
  }
  else{
    print("ERROR");
  }
  }
  
 @override
Widget build(BuildContext context) {
  int score = widget.score;
  print(scores.length);
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tu puntuación es: $score", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 25.0), textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Text("Otras puntuaciones: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 25.0), textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(scores[index].username),
                  subtitle: Text("Puntuación:${scores[index].score}"),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}