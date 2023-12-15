import 'package:flutter/material.dart';

import 'music_player_screen.dart';

void main() => runApp(const App());

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF7D9AFF),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF7D9AFF)),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listSong = [];

  @override
  void initState() {
    initListSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: <Widget>[
          _buildWidgetAlbumCover(mediaQuery),
          _buildWidgetActionAppBar(mediaQuery),
          _buildWidgetArtistName(mediaQuery),
          _buildWidgetFloatingActionButton(mediaQuery),
          _buildWidgetListSong(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetArtistName(MediaQueryData mediaQuery) {
    return SizedBox(
      height: mediaQuery.size.height / 1.8,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: constraints.maxHeight - 100.0,
                  child: const Text(
                    "Grande",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoralPen",
                      fontSize: 72.0,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight - 140.0,
                  child: const Text(
                    "Ariana",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoralPen",
                      fontSize: 72.0,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight - 160.0,
                  child: const Text(
                    "Tranding",
                    style: TextStyle(
                      color: Color(0xFF7D9AFF),
                      fontSize: 14.0,
                      fontFamily: "Campton_Light",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWidgetListSong(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        top: mediaQuery.size.height / 1.8 + 48.0,
        right: 20.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: Column(
        children: <Widget>[
          _buildWidgetHeaderSong(),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) {
                return const Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              itemCount: listSong.length,
              itemBuilder: (BuildContext context, int index) {
                Song song = listSong[index];
                return GestureDetector(
                  onTap: () {
                    _navigatorToMusicPlayerScreen(song.title);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          song.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Campton_Light",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        song.duration,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetHeaderSong() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Popular",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            fontFamily: "Campton_Light",
          ),
        ),
        Text(
          "Show all",
          style: TextStyle(
            color: Color(0xFF7D9AFF),
            fontWeight: FontWeight.w600,
            fontFamily: "Campton_Light",
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetFloatingActionButton(MediaQueryData mediaQuery) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.size.height / 1.8 - 32.0,
          right: 32.0,
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF7D9AFF),
          onPressed: () {
            _navigatorToMusicPlayerScreen(listSong[0].title);
          },
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _navigatorToMusicPlayerScreen(String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MusicPlayerScreen(title);
    }));
  }

  Widget _buildWidgetActionAppBar(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: mediaQuery.padding.top + 16.0,
        right: 16.0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetAlbumCover(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48.0),
        ),
        image: DecorationImage(
          image:
              AssetImage("assets/ariana_grande_cover_no_tears_left_to_cry.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void initListSong() {
    listSong.add(Song(title: "No tears left to cry", duration: "5:20"));
    listSong.add(Song(title: "Imagine", duration: "3:20"));
    listSong.add(Song(title: "Into you", duration: "4:12"));
    listSong.add(Song(title: "One last time", duration: "4:40"));
    listSong.add(Song(title: "7 rings", duration: "2:58"));
    listSong.add(Song(title: "Thank u, next", duration: "3:27"));
    listSong.add(Song(
        title: "Break up with your girlfriend, i'm bored", duration: "3:10"));
  }
}

class Song {
  final String title;
  final String duration;

  Song({required this.title, required this.duration});

  @override
  String toString() {
    return 'Song{title: $title, duration: $duration}';
  }
}
