import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea_1/Score.dart';
import 'package:http/http.dart' as http;

class ScoresScreen extends StatefulWidget {
  final int score;
  final userScore = 8;
  const ScoresScreen({Key? key, required this.score}) : super(key: key);

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<Score> scores = [];
  List<Score> orderedScores = [];
  String username = "example";

  @override
  void initState() {
    super.initState();
    loadUsername();
    postScore();
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
    scores.sort((a, b) => b.score.compareTo(a.score));
  }
  else{
    print("ERROR");
  }
  }
  
  
  Future<void> postScore()async{
  String apikey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhbnV1bmNobHhwd290amFwc21yIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYzMTc1MDUsImV4cCI6MjAxMTg5MzUwNX0._m-7Nocw3uImJE7TRZXNS_4aILCH4VqD5Ez2UkJlmUE';
  Uri uri =Uri.parse('https://tanuunchlxpwotjapsmr.supabase.co/rest/v1/puntuaciones?select=*');
  final headers = {
    'apikey': apikey,
    'Authorization': 'Bearer $apikey',
    'Content-Type': 'application/json',
    'Prefer': 'return=minimal'};
  String username = await loadUsername();
  final body = {"username":username,
                    "score":widget.score};
  print("insertando user");
  final response = await http.post(uri,headers: headers,body:jsonEncode(body)); 
    if (response.statusCode==200){
      print("usuario insertado");
  }
  else{
    print("ERROR");
  }
  }
  Future<String> loadUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') ?? "";
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
            child:Padding(
              padding: const EdgeInsets.only(left:200),
              child: ListView.builder( 
                  itemCount: scores.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      title: Text(scores[index].username,style: TextStyle(color: Colors.purple,fontSize: 20.0),),
                      subtitle: Text("Puntuación:${scores[index].score}",style: TextStyle(color: Colors.purple),),
                    );
                  },
                ),
            ),
          ),
        ],
      ),
    ),
  );
}
}