import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:video_player/video_player.dart';


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
        '/offlineVideo' : (context) => OfflineVideo(),
        '/onlineVideo' : (context) => OnlineVideo(),
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
                        Navigator.pushNamed(context, '/offlineVideo');
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
                        Navigator.pushNamed(context, '/onlineVideo'); 
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
  
  String url = 'https://github.com/cptn3m0grv/Flutter-MultiMedia-App/blob/master/assets/audios/song.mp3?raw=true';
  var stopped = 1;
  var playing = 0;

  playButton(url) async{
    if(playing == 0 || stopped == 1){
      int result = await player.play(url);
      if(result == 1){
        playing = 1;
        stopped = 0;
      }
      else{
        print('Check URL');
      }
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
                        stopButton();
                      },
                    ),
                    // Text("      "),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.play_arrow), 
                      onPressed: () {
                        playButton(url);
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

class OfflineVideo extends StatefulWidget{
  OfflineVideo() : super();

  @override
  _OfflineVideo createState() => _OfflineVideo();
}

class _OfflineVideo extends State<OfflineVideo>{
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset(
      "assets/videos/flyingKick.mp4",
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Player",
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 90, 185, 234),
                  width: 6,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: FlatButton(
                            color: Color.fromARGB(255, 193, 200, 228),
                            onPressed: () {
                              setState(() {
                                _controller.play();
                              });
                            },
                            child: Text(
                               "   Play    ",
                               style: TextStyle(
                                 fontFamily: 'Satisfy',
                                 fontSize: 20,
                               ),
                            ),
                          ),
                        ),
                        Card(
                          child: FlatButton(
                            color: Color.fromARGB(255, 193, 200, 228),
                            onPressed: () {
                              setState(() {
                                if(_controller.value.isPlaying){
                                  _controller.pause();
                                } 
                              });
                            },
                            child: Text(
                              "   Pause   ",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String vid = 'https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4';

class OnlineVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Online Video',
            style: TextStyle(
              fontFamily: 'Satisfy',
              fontSize: 30,
            ),
          ),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromARGB(255, 90, 185, 234),
                    width: 6,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        vid = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'URL of the song',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    Card(
                      child: FlatButton(
                        onPressed: () {
                          VideoPlayerRemote(url: vid);
                        },
                        child: Text("Run"),
                      ),
                    ),
                    VideoPlayerRemote(
                      url: vid,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerRemote extends StatefulWidget {
  final String url;
  VideoPlayerRemote({this.url});
  @override
  _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
}

class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url, //to access its parent class constructor or variable
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true); //loop through video
    _controller.initialize(); //initialize the VideoPlayer
  }

  @override
  void dispose() {
    _controller.dispose(); //dispose the VideoPlayer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.play();
          },
        ),
      ],
    );
  }
}