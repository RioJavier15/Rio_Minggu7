import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> gambar = [
    "avengers1.jpg",
    "avengers2.jpg",
    "avengers3.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: FractionalOffset.topRight,
            end: FractionalOffset.bottomLeft,
            colors: [
              Colors.indigo.shade900,
              Colors.deepPurple.shade900,
              Colors.purple.shade700,
            ],
          ),
        ),
        child: new PageView.builder(
          controller: new PageController(viewportFraction: 0.8),
          itemCount: gambar.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: new EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 25.0,
              ),
              child: new Material(
                borderRadius: new BorderRadius.circular(15.0),
                elevation: 10.0,
                child: new Stack(
                  fit: StackFit.expand,
                  children: [
                    new Hero(
                      tag: gambar[i],
                      child: new Material(
                        child: new InkWell(
                          onTap: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new HalamanDua(
                                gambar: gambar[i],
                              ),
                            ),
                          ),
                          child: new Image.asset(
                            "img/${gambar[i]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HalamanDua extends StatefulWidget {
  HalamanDua({required this.gambar});
  final String gambar;

  @override
  _HalamanDuaState createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  Color warna = Colors.deepPurple.shade900;
  void _pilihannya(Pilihan pilihan) {
    setState(() {
      warna = pilihan.warna;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("AVENGERS: END GAME"),
        backgroundColor: Colors.deepPurple[100],
        actions: <Widget>[
          new PopupMenuButton<Pilihan>(
            onSelected: _pilihannya,
            itemBuilder: (BuildContext context) {
              return listPilihan.map((Pilihan x) {
                return new PopupMenuItem<Pilihan>(
                  child: new Text(x.teks),
                  value: x,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: new Stack(children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft,
              colors: [
                Colors.indigo.shade900.withOpacity(0.7),
                warna,
                Colors.purple.shade700,
              ],
            ),
          ),
        ),
        new Center(
          child: new Hero(
            tag: widget.gambar,
            child: new ClipOval(
              child: new SizedBox(
                width: 300.0,
                height: 400.0,
                child: new Material(
                  child: new InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: new Image.asset(
                      "img/${widget.gambar}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Pilihan {
  const Pilihan({required this.teks, required this.warna});
  final String teks;
  final Color warna;
}

List<Pilihan> listPilihan = const <Pilihan>[
  const Pilihan(teks: "Strength", warna: Colors.red),
  const Pilihan(teks: "Agility", warna: Colors.green),
  const Pilihan(teks: "Intelligence", warna: Colors.blue),
];