import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';


AudioPlayer player = new AudioPlayer();
main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/' : (context) => HomePage(),
        '/offlineSong' : (context) => OfflineSong(),
        '/onlineSong' : (context) => OnlineSong(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 128, 233),
        title: Text(
          "TuneIn",
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 90, 185, 234),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            color: Color.fromARGB(255, 193, 200, 228),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/offlineSong');
                      },
                      child: Text(
                        "           Offline Song            ",
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: FlatButton(
                      onPressed: () {
                        print("Second button");
                      },
                      child: Text(
                        "           Offline Video           ",
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Text("\n"),
                  Card(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/onlineSong');
                      },
                      child: Text(
                        "            Online Song            ",
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: FlatButton(
                      onPressed: () {
                        print("Fourth button");
                      },
                      child: Text(
                        "           Online Video           ",
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OfflineSong extends StatelessWidget{

  AudioCache audio = new AudioCache(fixedPlayer: player);

  var stopped = 1;
  var playing = 0;

  playButton(){
    if(playing == 0 || stopped == 1){
      audio.play("audios/song.mp3");
      playing = 1;
      stopped = 0;
    }
  }

  pauseButton(){
    if(playing == 1){
      player.pause();
      playing = 0;
    }
  }

  stopButton(){
    if(playing == 1 && stopped == 0){
      player.stop();
      playing = 0;
      stopped = 1;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 128, 233),
        title: Text(
          "Audio",
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Image.asset(
                'assets/images/offline_song_image.jpg',
                fit: BoxFit.cover,
                height: 300,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 180,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Color.fromARGB(255, 193, 200, 228),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.stop), 
                      onPressed: () {
                        stopButton();
                      },
                    ),
                    // Text("      "),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.play_arrow), 
                      onPressed: () {
                        playButton();
                      },
                    ),
                    // Text("     "),
                    IconButton(
                      icon: Icon(Icons.pause), 
                      onPressed: () {
                        pauseButton();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnlineSong extends StatelessWidget{
  
  String url;
  var stopped = 1;
  var playing = 0;

  playButton() async{
    if(playing == 0 || stopped == 1){
      player.play(url);
      playing = 1;
      stopped = 0;
    }
  }

  pauseButton(){
    if(playing == 1){
      player.pause();
      playing = 0;
    }
  }

  stopButton(){
    if(playing == 1 && stopped == 0){
      player.stop();
      playing = 0;
      stopped = 1;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Online Mode",
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontSize: 30,
          ),
        )
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                url = value;
              },
              decoration: InputDecoration(
                hintText: 'URL of the song',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Image.asset(
              'assets/images/offline_song_image.jpg',
               fit: BoxFit.cover,
               height: 300,
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 180,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Color.fromARGB(255, 193, 200, 228),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.stop), 
                      onPressed: () {
                        // stopButton();
                      },
                    ),
                    // Text("      "),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.play_arrow), 
                      onPressed: () {
                        // playButton();
                      },
                    ),
                    // Text("     "),
                    IconButton(
                      icon: Icon(Icons.pause), 
                      onPressed: () {
                        // pauseButton();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}