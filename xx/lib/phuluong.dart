
import 'package:a_star_algorithm/a_star_algorithm.dart';
import 'package:flutter/material.dart';
import 'phubinh.dart';


class PhuLuong extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

enum TypeInput {
  START_POINT,
  END_POINT,
  BARRIERS,
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TypeInput _typeInput = TypeInput.START_POINT;

  bool _showDoneList = false;
  Offset start = Offset.zero;
  Offset end = Offset.zero;
  List<Tile> tiles = [];
  List<Offset> barriers = [];
  int rows = 40;
  int columns = 38;
//hihi
  List<Offset> _barriers = [
    Offset(0.0, 1.0),
    Offset(3.0, 0.0),
    Offset(1.0, 2.0),
    Offset(2.0, 3.0),
    Offset(3.0, 4.0),
    Offset(4.0, 1.0),
    Offset(4.0, 2.0),
    Offset(5.0, 3.0),
    Offset(6.0, 3.0),
    Offset(7.0, 2.0),
    Offset(8.0, 1.0),
    Offset(9.0, 1.0),
    Offset(10.0, 0.0),
    Offset(12.0, 0.0),
    Offset(12.0, 1.0),
    Offset(11.0, 2.0),
    Offset(10.0, 3.0),
    Offset(9.0, 3.0),
    Offset(8.0, 4.0),
    Offset(4.0, 6.0),
    Offset(3.0, 6.0),
    Offset(2.0, 7.0),
    Offset(1.0, 8.0),
    Offset(2.0, 4.0),
    Offset(1.0, 5.0),
    Offset(0.0, 6.0),
    Offset(0.0, 10.0),
    Offset(1.0, 9.0),
    Offset(5.0, 6.0),
    Offset(6.0, 6.0),
    Offset(7.0, 6.0),
    Offset(8.0, 6.0),
    Offset(9.0, 6.0),
    Offset(10.0, 6.0),
    Offset(11.0, 7.0),
    Offset(11.0, 8.0),
    Offset(12.0, 9.0),
    Offset(12.0, 10.0),
    Offset(12.0, 11.0),
    Offset(10.0, 4.0),
    Offset(11.0, 4.0),
    Offset(12.0, 5.0),
    Offset(13.0, 6.0),
    Offset(13.0, 7.0),
    Offset(14.0, 8.0),
    Offset(16.0, 9.0),
    Offset(16.0, 10.0),
    Offset(14.0, 12.0),
    Offset(15.0, 12.0),
    Offset(16.0, 13.0),
    Offset(17.0, 14.0),
    Offset(18.0, 15.0),
    Offset(19.0, 16.0),
    Offset(20.0, 16.0),
    Offset(17.0, 9.0),
    Offset(18.0, 9.0),
    Offset(18.0, 10.0),
    Offset(19.0, 11.0),
    Offset(19.0, 12.0),
    Offset(19.0, 13.0),
    Offset(18.0, 11.0),
    Offset(20.0, 14.0),
    Offset(21.0, 14.0),
    Offset(22.0, 15.0),
    Offset(25.0, 16.0),
    Offset(25.0, 17.0),
    Offset(25.0, 18.0),
    Offset(25.0, 19.0),
    Offset(26.0, 20.0),
    Offset(26.0, 21.0),
    Offset(22.0, 17.0),
    Offset(23.0, 18.0),
    Offset(23.0, 19.0),
    Offset(23.0, 20.0),
    Offset(23.0, 21.0),
    Offset(23.0, 22.0),
    Offset(23.0, 23.0),
    Offset(23.0, 24.0),
    Offset(22.0, 25.0),
    Offset(22.0, 26.0),
    Offset(22.0, 27.0),
    Offset(22.0, 28.0),
    Offset(21.0, 29.0),
    Offset(21.0, 30.0),
    Offset(22.0, 31.0),
    Offset(22.0, 32.0),
    Offset(23.0, 33.0),
    Offset(24.0, 35.0),
    Offset(23.0, 34.0),
    Offset(24.0, 26.0),
    Offset(24.0, 27.0),
    Offset(24.0, 28.0),
    Offset(24.0, 29.0),
    Offset(24.0, 30.0),
    Offset(24.0, 31.0),
    Offset(25.0, 32.0),
    Offset(25.0, 33.0),
    Offset(26.0, 34.0),
    Offset(27.0, 34.0),
    Offset(28.0, 34.0),
    Offset(29.0, 34.0),
    Offset(27.0, 37.0),
    Offset(28.0, 36.0),
    Offset(30.0, 36.0),
    Offset(29.0, 36.0),
    Offset(21.0, 18.0),
    Offset(20.0, 18.0),
    Offset(19.0, 18.0),
    Offset(18.0, 18.0),
    Offset(18.0, 16.0),
    Offset(17.0, 16.0),
    Offset(16.0, 17.0),
    Offset(15.0, 17.0),
    Offset(14.0, 16.0),
    Offset(13.0, 17.0),
    Offset(13.0, 18.0),
    Offset(15.0, 19.0),
    Offset(14.0, 19.0),
    Offset(16.0, 19.0),
    Offset(17.0, 19.0),
    Offset(13.0, 13.0),
    Offset(12.0, 13.0),
    Offset(11.0, 13.0),
    Offset(10.0, 12.0),
    Offset(9.0, 12.0),
    Offset(8.0, 12.0),
    Offset(11.0, 10.0),
    Offset(9.0, 10.0),
    Offset(8.0, 10.0),
    Offset(7.0, 10.0),
    Offset(6.0, 10.0),
    Offset(5.0, 10.0),
    Offset(4.0, 11.0),
    Offset(3.0, 12.0),
    Offset(2.0, 12.0),
    Offset(1.0, 12.0),
    Offset(0.0, 13.0),
    Offset(7.0, 13.0),
    Offset(6.0, 13.0),
    Offset(5.0, 14.0),
    Offset(4.0, 14.0),
    Offset(3.0, 14.0),
    Offset(2.0, 15.0),
    Offset(1.0, 15.0),
    Offset(0.0, 16.0),
    Offset(5.0, 11.0),
    Offset(1.0, 13.0),
    Offset(24.0, 15.0),
    Offset(23.0, 15.0),
    Offset(26.0, 23.0),
    Offset(26.0, 24.0),
    Offset(27.0, 21.0),
    Offset(28.0, 20.0),
    Offset(28.0, 19.0),
    Offset(29.0, 18.0),
    Offset(29.0, 17.0),
    Offset(30.0, 16.0),
    Offset(30.0, 15.0),
    Offset(31.0, 14.0),
    Offset(32.0, 13.0),
    Offset(32.0, 12.0),
    Offset(33.0, 11.0),
    Offset(33.0, 10.0),
    Offset(34.0, 9.0),
    Offset(34.0, 8.0),
    Offset(35.0, 8.0),
    Offset(36.0, 6.0),
    Offset(35.0, 7.0),
    Offset(36.0, 5.0),
    Offset(37.0, 4.0),
    Offset(37.0, 9.0),
    Offset(36.0, 10.0),
    Offset(36.0, 11.0),
    Offset(35.0, 12.0),
    Offset(34.0, 13.0),
    Offset(34.0, 14.0),
    Offset(33.0, 15.0),
    Offset(33.0, 16.0),
    Offset(32.0, 17.0),
    Offset(32.0, 18.0),
    Offset(31.0, 19.0),
    Offset(30.0, 20.0),
    Offset(30.0, 21.0),
    Offset(29.0, 22.0),
    Offset(29.0, 23.0),
    Offset(28.0, 24.0),
    Offset(28.0, 25.0),
    Offset(28.0, 26.0),
    Offset(25.0, 27.0),
    Offset(26.0, 28.0),
    Offset(26.0, 29.0),
    Offset(26.0, 30.0),
    Offset(27.0, 31.0),
    Offset(27.0, 32.0),
    Offset(28.0, 33.0),
    Offset(29.0, 28.0),
    Offset(30.0, 29.0),
    Offset(30.0, 30.0),
    Offset(30.0, 31.0),
    Offset(31.0, 32.0),
    Offset(32.0, 32.0),
    Offset(33.0, 33.0),
    Offset(34.0, 33.0),
    Offset(35.0, 33.0),
    Offset(36.0, 34.0),
    Offset(37.0, 35.0),
    Offset(37.0, 36.0),
    Offset(36.0, 39.0),
    Offset(36.0, 38.0),
    Offset(35.0, 37.0),
    Offset(35.0, 36.0),
    Offset(34.0, 35.0),
    Offset(33.0, 35.0),
    Offset(31.0, 37.0),
    Offset(32.0, 38.0),
    Offset(33.0, 39.0),
    Offset(34.0, 36.0),
    Offset(31.0, 36.0),
    Offset(0.0, 20.0),
    Offset(1.0, 20.0),
    Offset(2.0, 20.0),
    Offset(3.0, 20.0),
    Offset(4.0, 19.0),
    Offset(5.0, 18.0),
    Offset(6.0, 18.0),
    Offset(7.0, 17.0),
    Offset(8.0, 17.0),
    Offset(9.0, 18.0),
    Offset(8.0, 19.0),
    Offset(6.0, 20.0),
    Offset(6.0, 21.0),
    Offset(3.0, 22.0),
    Offset(2.0, 22.0),
    Offset(1.0, 22.0),
    Offset(0.0, 22.0),
    Offset(6.0, 22.0),
    Offset(6.0, 23.0),
    Offset(4.0, 23.0),
    Offset(4.0, 24.0),
    Offset(5.0, 25.0),
    Offset(6.0, 26.0),
    Offset(7.0, 24.0),
    Offset(8.0, 25.0),
    Offset(8.0, 26.0),
    Offset(9.0, 27.0),
    Offset(9.0, 28.0),
    Offset(6.0, 27.0),
    Offset(7.0, 28.0),
    Offset(7.0, 29.0),
    Offset(8.0, 30.0),
    Offset(10.0, 29.0),
    Offset(11.0, 30.0),
    Offset(12.0, 30.0),
    Offset(13.0, 31.0),
    Offset(14.0, 31.0),
    Offset(15.0, 31.0),
    Offset(16.0, 31.0),
    Offset(17.0, 32.0),
    Offset(18.0, 32.0),
    Offset(19.0, 33.0),
    Offset(20.0, 34.0),
    Offset(21.0, 34.0),
    Offset(22.0, 35.0),
    Offset(23.0, 36.0),
    Offset(26.0, 37.0),
    Offset(26.0, 38.0),
    Offset(27.0, 39.0),
    Offset(24.0, 39.0),
    Offset(23.0, 39.0),
    Offset(22.0, 38.0),
    Offset(20.0, 36.0),
    Offset(21.0, 39.0),
    Offset(19.0, 36.0),
    Offset(19.0, 37.0),
    Offset(18.0, 38.0),
    Offset(17.0, 38.0),
    Offset(17.0, 37.0),
    Offset(17.0, 36.0),
    Offset(17.0, 35.0),
    Offset(17.0, 34.0),
    Offset(15.0, 33.0),
    Offset(16.0, 34.0),
    Offset(15.0, 34.0),
    Offset(15.0, 35.0),
    Offset(15.0, 36.0),
    Offset(15.0, 37.0),
    Offset(14.0, 37.0),
    Offset(13.0, 37.0),
    Offset(13.0, 36.0),
    Offset(13.0, 34.0),
    Offset(13.0, 33.0),
    Offset(12.0, 35.0),
    Offset(12.0, 33.0),
    Offset(12.0, 34.0),
    Offset(13.0, 38.0),
    Offset(13.0, 39.0),
    Offset(12.0, 39.0),
    Offset(10.0, 39.0),
    Offset(10.0, 38.0),
    Offset(11.0, 37.0),
    Offset(10.0, 36.0),
    Offset(10.0, 35.0),
    Offset(10.0, 34.0),
    Offset(10.0, 32.0),
    Offset(9.0, 34.0),
    Offset(8.0, 34.0),
    Offset(7.0, 34.0),
    Offset(6.0, 34.0),
    Offset(5.0, 34.0),
    Offset(4.0, 33.0),
    Offset(4.0, 32.0),
    Offset(6.0, 32.0),
    Offset(7.0, 30.0),
    Offset(6.0, 30.0),
    Offset(5.0, 30.0),
    Offset(5.0, 32.0),
    Offset(4.0, 29.0),
    Offset(3.0, 29.0),
    Offset(2.0, 29.0),
    Offset(1.0, 29.0),
    Offset(0.0, 31.0),
    Offset(1.0, 31.0),
    Offset(2.0, 31.0),
    Offset(3.0, 31.0),
    Offset(0.0, 28.0),
    Offset(20.0, 37.0),
    Offset(19.0, 38.0),
    Offset(29.0, 26.0),
    Offset(29.0, 25.0),
    Offset(30.0, 25.0),
    Offset(30.0, 24.0),
    Offset(31.0, 23.0),
    Offset(32.0, 22.0),
    Offset(33.0, 22.0),
    Offset(34.0, 22.0),
    Offset(35.0, 22.0),
    Offset(24.0, 36.0),
    Offset(36.0, 22.0),
    Offset(37.0, 23.0),
    Offset(37.0, 25.0),
    Offset(36.0, 25.0),
    Offset(35.0, 24.0),
    Offset(34.0, 24.0),
    Offset(33.0, 24.0),
    Offset(32.0, 25.0),
    Offset(32.0, 26.0),
    Offset(31.0, 27.0),
    Offset(30.0, 28.0),
    Offset(14.0, 7.0),
    Offset(15.0, 7.0),
    Offset(16.0, 7.0),
    Offset(17.0, 8.0),
    Offset(9.0, 32.0),
    Offset(7.0, 32.0),
    Offset(18.0, 39.0),
    Offset(14.0, 11.0),
    Offset(8.0, 7.0),
    Offset(8.0, 8.0),
    Offset(8.0, 9.0),
    Offset(5.0, 21.0),
    Offset(35.0, 38.0),
    Offset(31.0, 34.0),
    Offset(8.0, 20.0),
    Offset(8.0, 21.0),
    Offset(7.0, 21.0),
  ];

  @override
  void initState() {
    List.generate(rows, (y) {
      List.generate(columns, (x) {
        final offset = Offset(x.toDouble(), y.toDouble());
        tiles.add(
          Tile(offset),
        );
      });
    });

    barriers.addAll(_barriers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phú Lương'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhuBinh()));
              },
              icon: Icon(Icons.navigate_next))
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _typeInput = TypeInput.START_POINT;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: _getColorSelected(TypeInput.START_POINT),
                  ),
                  child: Text('Bắt đầu'),
                )),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _typeInput = TypeInput.END_POINT;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: _getColorSelected(TypeInput.END_POINT),
                  ),
                  child: Text('Điểm đến'),
                )),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _typeInput = TypeInput.BARRIERS;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: _getColorSelected(TypeInput.BARRIERS),
                  ),
                  child: Text('Chướng ngại vật'),
                )),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // barriers.clear();
                      _cleanTiles();
                    });
                  },
                  child: Text('Xóa'),
                ))
              ],
            ),
          ),
          Expanded(
              child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(50),
            minScale: 0.5,
            maxScale: 4,
            //   constrained: false,
            //    scaleEnabled: true,
            child: Stack(
              children: [
                Container(
                  color: Colors.red.shade200,
                  child: Image.asset("assets/images/phuluong.jpg"),
                ),
                GridView.count(
                  crossAxisCount: columns,
                  children: tiles.map((e) {
                    return _buildItem(e);
                  }).toList(),
                ),
              ],
            ),
          )),
          Row(
            children: [
              Switch(
                value: _showDoneList,
                onChanged: (value) {
                  setState(() {
                    _showDoneList = value;
                  });
                },
              ),
              Text('Show done list')
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _start,
        tooltip: 'Find path',
        child: Icon(Icons.map),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Tile e) {
    Color color = Color.fromARGB(0, 255, 255, 255);
    if (e.selected) {
      color = Colors.blue;
    } else if (e.position == start) {
      color = Colors.yellow;
    } else if (e.position == end) {
      color = Colors.green;
    } else if (barriers.contains(e.position)) {
      //  color = Colors.red;
      color = Color.fromARGB(0, 255, 255, 255);
    } else if (e.done) {
      color = Colors.purple;
    }

    return InkWell(
      onTap: () {
        if (_typeInput == TypeInput.START_POINT) {
          start = e.position;
        }
        if (_typeInput == TypeInput.END_POINT) {
          end = e.position;
        }
        if (_typeInput == TypeInput.BARRIERS) {
          if (barriers.contains(e.position)) {
            barriers.remove(e.position);
          } else {
            print("${e.position},");
            barriers.add(e.position);
            //Log().i("${e.position}");
          }
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: Color.fromARGB(0, 158, 158, 158), width: 0.5),
          color: color,
        ),
        height: 10,
      ),
    );
  }

  MaterialStateProperty<Color> _getColorSelected(TypeInput input) {
    return MaterialStateProperty.all(
      _typeInput == input ? _getColorByType(input) : Colors.grey,
    );
  }

  Color _getColorByType(TypeInput input) {
    switch (input) {
      case TypeInput.START_POINT:
        return Colors.yellow;
      case TypeInput.END_POINT:
        return Colors.green;
      case TypeInput.BARRIERS:
        return Colors.red;
    }
  }

  void _start() {
    _cleanTiles();
    List<Offset> done = [];
    final result = AStar(
      rows: rows,
      columns: columns,
      start: start,
      end: end,
      barriers: barriers,
    ).findThePath(doneList: (doneList) {
      done = doneList;
    });

    print(AStar.resumePath(result));

    result.forEach((element) {
      done.remove(element);
    });

    done.remove(start);
    done.remove(end);

    setState(() {
      tiles.forEach((element) {
        element.selected = result.where((r) {
          return r == element.position;
        }).isNotEmpty;

        if (_showDoneList) {
          element.done = done.where((r) {
            return r == element.position;
          }).isNotEmpty;
        }
      });
    });
  }

  void _cleanTiles() {
    tiles.forEach((element) {
      element.selected = false;
      element.done = false;
    });
  }
}

class Tile {
  final Offset position;
  bool selected = false;
  bool done = false;

  Tile(this.position);
}
