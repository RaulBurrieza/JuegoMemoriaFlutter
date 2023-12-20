import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarea_1/GameImage.dart';
import 'package:tarea_1/scores.dart';

class ChooseScreen extends StatefulWidget {
  int attempt = 0;
  int score = 0;
  final List<GameImage> imagesPool;
  ChooseScreen({super.key, required this.imagesPool});
  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}


class _ChooseScreenState extends State<ChooseScreen> {
  
  List<GameImage> shuffleImages(){
    List<GameImage>shuffledPool = List.from(widget.imagesPool);
    shuffledPool.shuffle(Random());
    return shuffledPool;
  }
  void checkAttempts() {
  if (widget.attempt == 5) {
    try {
      print("Antes de cambiar a ScoresScreen");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScoresScreen(score: widget.score)),
      );
      print("Después de cambiar a ScoresScreen");
    } catch (e) {
      print("Error al cambiar a ScoresScreen: $e");
    }
  }
}
  
  @override
  Widget build(BuildContext context) {
    List<GameImage>shuffledPool = shuffleImages();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Perfil")),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2, 
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: widget.imagesPool.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print('Imagen clicada: $index');
                if(shuffledPool[index].id == widget.imagesPool[widget.attempt].id){
                  print("Acierto" + widget.attempt.toString());
                  widget.attempt += 1;
                  widget.score += 100;
                  checkAttempts();
                }
                else{
                  print("Fallo"+ widget.attempt.toString());
                  widget.attempt += 1;
                  checkAttempts();
                }
              },
              child: Card(
                child: Image.asset(
                  'images/'+ shuffledPool[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ));
  }
  
}

