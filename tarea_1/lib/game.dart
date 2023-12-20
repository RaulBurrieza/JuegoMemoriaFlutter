import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea_1/GameImage.dart';
import 'package:tarea_1/choose.dart';



class Game extends StatefulWidget {
   String username = "";
  @override
  _GameState createState() => _GameState();
  
}

class _GameState extends State<Game> {
  late int currentIndex = 0;
  late Timer timer;
  late List<GameImage> shuffledImages;
  late List<GameImage> imagesPool = [];
  
//METODOS UNO PARA EL FUNCIONAMIENTO DEL TIMER Y EL OTRO MEZCLA LAS IMAGENES
  void startTimerAndShuffleImages() {
    shuffledImages = shuffleImages();
    startTimer();
  }
  void startTimer() {
  const duration = Duration(seconds: 1); 
  var secs = 15;
  timer = Timer.periodic(duration, (Timer timer) {
    setState(() {
      secs -= 1;
      print(secs);
      if (secs == 0) {
        imagesPool.add(shuffledImages[currentIndex]);
        timer.cancel();
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseScreen(imagesPool: imagesPool,)));
      } else if (secs % 3 == 0) {
        imagesPool.add(shuffledImages[currentIndex]);
        currentIndex = (currentIndex + 1) % shuffledImages.length;
      }
    });
  });
}
  List<GameImage> shuffleImages(){
    List<GameImage> images = [
    GameImage(1, '7kidkeo.jpg'),
    GameImage(2, 'bbo.png'),
    GameImage(3, 'boncalso.jpg'),
    GameImage(4, 'drake.jpg'),
    GameImage(5, 'el_madrileno.jpg'),
    GameImage(6, 'gasplatino.jpg'),
    GameImage(7, 'mda.jpg'),
    GameImage(8, 'memuevocondios.jpg'),
    GameImage(9, 'rojuu.jpg'),
    GameImage(10, 'visiontunel.jpg'),
    GameImage(11, 'kanye.jpg'),
    ];
    List<GameImage>shuffledImages = List.from(images);
    shuffledImages.shuffle(Random());
    
    shuffledImages.forEach((image) {
    print("ID: ${image.id}, FileName: ${image.image}");
    });
    return shuffledImages;
  }
  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.username = prefs.getString('username') ?? "";
  }
  @override  
  void initState() {
    super.initState();
    startTimerAndShuffleImages();
    setState(() {
      
    });
    
  }
  
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purple,
            title: const Text("Juego")),
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( widget.username +  " recuerda memorizar estas imagenes ",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.purple,fontSize: 25.0),textAlign: TextAlign.center),
            SizedBox(height: 60),
            Image.asset('images/'+ shuffledImages[currentIndex].image,height: 400,width: 400),
          ],
        ),
      ),
    );
  }
}

