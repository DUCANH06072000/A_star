import 'dart:developer';
import 'package:a_star_algorithm/a_star_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:xx/shared.dart';
import 'barriers.dart';
import 'log_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int columns = 40;



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

    barriers.addAll(Shared().barriers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A*'),
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
                  child: Image.asset("assets/images/xx.jpg"),
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
      color =  Color.fromARGB(0, 255, 255, 255);
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
            print(e.position);
            barriers.add(e.position);
            //Log().i("${e.position}");
          }
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(20, 158, 158, 158), width: 0.5),
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
