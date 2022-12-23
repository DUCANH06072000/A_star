import 'dart:developer';
import 'package:a_star_algorithm/a_star_algorithm.dart';
import 'package:flutter/material.dart';
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
  int rows = 60;
  int columns = 59;

  List<Offset> _barriers = [
    Offset(0.0, 18.0),
    Offset(0.0, 19.0),
    Offset(0.0, 20.0),
    Offset(2.0, 21.0),
    Offset(2.0, 20.0),
    Offset(2.0, 19.0),
    Offset(0.0, 22.0),
    Offset(0.0, 23.0),
    Offset(0.0, 24.0),
    Offset(0.0, 25.0),
    Offset(1.0, 26.0),
    Offset(1.0, 27.0),
    Offset(1.0, 28.0),
    Offset(2.0, 22.0),
    Offset(2.0, 23.0),
    Offset(3.0, 24.0),
    Offset(3.0, 25.0),
    Offset(3.0, 26.0),
    Offset(3.0, 27.0),
    Offset(3.0, 28.0),
    Offset(3.0, 29.0),
    Offset(2.0, 29.0),
    Offset(1.0, 29.0),
    Offset(1.0, 25.0),
    Offset(0.0, 15.0),
    Offset(1.0, 15.0),
    Offset(2.0, 16.0),
    Offset(3.0, 15.0),
    Offset(4.0, 14.0),
    Offset(5.0, 13.0),
    Offset(6.0, 12.0),
    Offset(7.0, 11.0),
    Offset(9.0, 10.0),
    Offset(8.0, 11.0),
    Offset(10.0, 9.0),
    Offset(11.0, 8.0),
    Offset(12.0, 7.0),
    Offset(12.0, 6.0),
    Offset(9.0, 0.0),
    Offset(10.0, 1.0),
    Offset(11.0, 3.0),
    Offset(11.0, 4.0),
    Offset(12.0, 5.0),
    Offset(10.0, 2.0),
    Offset(12.0, 0.0),
    Offset(12.0, 1.0),
    Offset(13.0, 2.0),
    Offset(13.0, 3.0),
    Offset(14.0, 4.0),
    Offset(14.0, 5.0),
    Offset(15.0, 4.0),
    Offset(16.0, 3.0),
    Offset(17.0, 3.0),
    Offset(18.0, 3.0),
    Offset(19.0, 2.0),
    Offset(20.0, 3.0),
    Offset(19.0, 3.0),
    Offset(21.0, 2.0),
    Offset(21.0, 3.0),
    Offset(8.0, 26.0),
    Offset(23.0, 0.0),
    Offset(24.0, 1.0),
    Offset(25.0, 2.0),
    Offset(24.0, 2.0),
    Offset(23.0, 2.0),
    Offset(22.0, 2.0),
    Offset(26.0, 4.0),
    Offset(25.0, 4.0),
    Offset(24.0, 4.0),
    Offset(23.0, 5.0),
    Offset(22.0, 5.0),
    Offset(21.0, 5.0),
    Offset(20.0, 5.0),
    Offset(19.0, 5.0),
    Offset(18.0, 5.0),
    Offset(18.0, 5.0),
    Offset(17.0, 6.0),
    Offset(16.0, 6.0),
    Offset(15.0, 7.0),
    Offset(14.0, 8.0),
    Offset(13.0, 9.0),
    Offset(12.0, 10.0),
    Offset(11.0, 11.0),
    Offset(10.0, 12.0),
    Offset(9.0, 13.0),
    Offset(8.0, 14.0),
    Offset(7.0, 14.0),
    Offset(6.0, 15.0),
    Offset(7.0, 15.0),
    Offset(5.0, 16.0),
    Offset(4.0, 17.0),
    Offset(5.0, 17.0),
    Offset(6.0, 18.0),
    Offset(6.0, 19.0),
    Offset(7.0, 20.0),
    Offset(7.0, 21.0),
    Offset(8.0, 22.0),
    Offset(9.0, 23.0),
    Offset(9.0, 24.0),
    Offset(10.0, 25.0),
    Offset(10.0, 26.0),
    Offset(11.0, 27.0),
    Offset(12.0, 28.0),
    Offset(12.0, 29.0),
    Offset(13.0, 30.0),
    Offset(13.0, 31.0),
    Offset(14.0, 32.0),
    Offset(14.0, 33.0),
    Offset(15.0, 34.0),
    Offset(16.0, 36.0),
    Offset(16.0, 35.0),
    Offset(17.0, 37.0),
    Offset(18.0, 38.0),
    Offset(3.0, 20.0),
    Offset(4.0, 21.0),
    Offset(5.0, 22.0),
    Offset(13.0, 9.0),
    Offset(12.0, 10.0),
    Offset(11.0, 11.0),
    Offset(10.0, 12.0),
    Offset(9.0, 13.0),
    Offset(8.0, 14.0),
    Offset(5.0, 23.0),
    Offset(6.0, 24.0),
    Offset(7.0, 25.0),
    Offset(8.0, 27.0),
    Offset(9.0, 28.0),
    Offset(9.0, 29.0),
    Offset(9.0, 30.0),
    Offset(10.0, 30.0),
    Offset(10.0, 31.0),
    Offset(11.0, 32.0),
    Offset(12.0, 33.0),
    Offset(12.0, 34.0),
    Offset(12.0, 35.0),
    Offset(11.0, 36.0),
    Offset(10.0, 36.0),
    Offset(9.0, 37.0),
    Offset(8.0, 38.0),
    Offset(7.0, 38.0),
    Offset(6.0, 39.0),
    Offset(5.0, 39.0),
    Offset(4.0, 38.0),
    Offset(3.0, 37.0),
    Offset(3.0, 36.0),
    Offset(3.0, 35.0),
    Offset(3.0, 34.0),
    Offset(3.0, 33.0),
    Offset(3.0, 32.0),
    Offset(3.0, 31.0),
    Offset(2.0, 30.0),
    Offset(3.0, 31.0),
    Offset(1.0, 31.0),
    Offset(1.0, 32.0),
    Offset(1.0, 33.0),
    Offset(1.0, 34.0),
    Offset(1.0, 35.0),
    Offset(1.0, 33.0),
    Offset(1.0, 35.0),
    Offset(1.0, 36.0),
    Offset(1.0, 37.0),
    Offset(0.0, 37.0),
    Offset(0.0, 40.0),
    Offset(1.0, 40.0),
    Offset(2.0, 40.0),
    Offset(3.0, 40.0),
    Offset(4.0, 41.0),
    Offset(5.0, 42.0),
    Offset(6.0, 42.0),
    Offset(7.0, 41.0),
    Offset(8.0, 41.0),
    Offset(9.0, 40.0),
    Offset(10.0, 39.0),
    Offset(11.0, 38.0),
    Offset(12.0, 38.0),
    Offset(13.0, 37.0),
    Offset(14.0, 38.0),
    Offset(15.0, 39.0),
    Offset(15.0, 40.0),
    Offset(16.0, 41.0),
    Offset(16.0, 42.0),
    Offset(17.0, 43.0),
    Offset(18.0, 44.0),
    Offset(18.0, 45.0),
    Offset(19.0, 46.0),
    Offset(19.0, 47.0),
    Offset(20.0, 48.0),
    Offset(20.0, 49.0),
    Offset(21.0, 50.0),
    Offset(21.0, 51.0),
    Offset(22.0, 52.0),
    Offset(23.0, 53.0),
    Offset(24.0, 54.0),
    Offset(25.0, 55.0),
    Offset(25.0, 56.0),
    Offset(24.0, 57.0),
    Offset(23.0, 57.0),
    Offset(22.0, 58.0),
    Offset(21.0, 58.0),
    Offset(20.0, 58.0),
    Offset(18.0, 57.0),
    Offset(16.0, 57.0),
    Offset(17.0, 57.0),
    Offset(15.0, 58.0),
    Offset(14.0, 58.0),
    Offset(13.0, 59.0),
    Offset(19.0, 38.0),
    Offset(20.0, 37.0),
    Offset(21.0, 36.0),
    Offset(22.0, 36.0),
    Offset(21.0, 35.0),
    Offset(20.0, 34.0),
    Offset(20.0, 33.0),
    Offset(20.0, 32.0),
    Offset(20.0, 31.0),
    Offset(21.0, 31.0),
    Offset(22.0, 32.0),
    Offset(23.0, 33.0),
    Offset(23.0, 34.0),
    Offset(24.0, 35.0),
    Offset(25.0, 36.0),
    Offset(25.0, 37.0),
    Offset(26.0, 38.0),
    Offset(27.0, 39.0),
    Offset(27.0, 40.0),
    Offset(28.0, 41.0),
    Offset(29.0, 42.0),
    Offset(29.0, 43.0),
    Offset(30.0, 44.0),
    Offset(31.0, 45.0),
    Offset(32.0, 46.0),
    Offset(32.0, 47.0),
    Offset(33.0, 48.0),
    Offset(31.0, 46.0),
    Offset(33.0, 49.0),
    Offset(19.0, 58.0),
    Offset(34.0, 50.0),
    Offset(35.0, 50.0),
    Offset(35.0, 51.0),
    Offset(36.0, 50.0),
    Offset(37.0, 49.0),
    Offset(38.0, 48.0),
    Offset(39.0, 47.0),
    Offset(39.0, 48.0),
    Offset(40.0, 47.0),
    Offset(41.0, 46.0),
    Offset(42.0, 46.0),
    Offset(42.0, 45.0),
    Offset(41.0, 44.0),
    Offset(41.0, 43.0),
    Offset(40.0, 42.0),
    Offset(39.0, 41.0),
    Offset(39.0, 40.0),
    Offset(38.0, 39.0),
    Offset(37.0, 38.0),
    Offset(37.0, 36.0),
    Offset(37.0, 37.0),
    Offset(37.0, 35.0),
    Offset(38.0, 35.0),
    Offset(39.0, 35.0),
    Offset(39.0, 36.0),
    Offset(41.0, 38.0),
    Offset(40.0, 37.0),
    Offset(41.0, 39.0),
    Offset(42.0, 40.0),
    Offset(42.0, 41.0),
    Offset(43.0, 42.0),
    Offset(44.0, 43.0),
    Offset(44.0, 44.0),
    Offset(45.0, 45.0),
    Offset(45.0, 46.0),
    Offset(46.0, 46.0),
    Offset(47.0, 46.0),
    Offset(47.0, 47.0),
    Offset(47.0, 48.0),
    Offset(47.0, 47.0),
    Offset(48.0, 49.0),
    Offset(48.0, 50.0),
    Offset(48.0, 51.0),
    Offset(48.0, 52.0),
    Offset(48.0, 53.0),
    Offset(48.0, 54.0),
    Offset(48.0, 55.0),
    Offset(49.0, 56.0),
    Offset(49.0, 57.0),
    Offset(48.0, 58.0),
    Offset(48.0, 59.0),
    Offset(46.0, 59.0),
    Offset(46.0, 58.0),
    Offset(46.0, 57.0),
    Offset(46.0, 56.0),
    Offset(46.0, 55.0),
    Offset(45.0, 54.0),
    Offset(46.0, 54.0),
    Offset(45.0, 53.0),
    Offset(45.0, 52.0),
    Offset(45.0, 51.0),
    Offset(45.0, 50.0),
    Offset(45.0, 49.0),
    Offset(45.0, 48.0),
    Offset(44.0, 48.0),
    Offset(43.0, 48.0),
    Offset(42.0, 48.0),
    Offset(41.0, 49.0),
    Offset(40.0, 50.0),
    Offset(39.0, 51.0),
    Offset(38.0, 52.0),
    Offset(36.0, 53.0),
    Offset(37.0, 54.0),
    Offset(37.0, 55.0),
    Offset(38.0, 56.0),
    Offset(39.0, 57.0),
    Offset(39.0, 58.0),
    Offset(39.0, 59.0),
    Offset(37.0, 59.0),
    Offset(36.0, 58.0),
    Offset(35.0, 57.0),
    Offset(36.0, 57.0),
    Offset(35.0, 56.0),
    Offset(34.0, 55.0),
    Offset(34.0, 54.0),
    Offset(33.0, 53.0),
    Offset(32.0, 52.0),
    Offset(32.0, 51.0),
    Offset(31.0, 50.0),
    Offset(30.0, 49.0),
    Offset(29.0, 48.0),
    Offset(30.0, 48.0),
    Offset(29.0, 47.0),
    Offset(28.0, 46.0),
    Offset(28.0, 45.0),
    Offset(27.0, 44.0),
    Offset(26.0, 43.0),
    Offset(25.0, 42.0),
    Offset(25.0, 41.0),
    Offset(24.0, 40.0),
    Offset(26.0, 42.0),
    Offset(27.0, 43.0),
    Offset(24.0, 39.0),
    Offset(23.0, 38.0),
    Offset(29.0, 46.0),
    Offset(31.0, 49.0),
    Offset(22.0, 39.0),
    Offset(21.0, 39.0),
    Offset(20.0, 40.0),
    Offset(19.0, 41.0),
    Offset(20.0, 42.0),
    Offset(20.0, 43.0),
    Offset(21.0, 44.0),
    Offset(21.0, 45.0),
    Offset(22.0, 46.0),
    Offset(23.0, 47.0),
    Offset(23.0, 48.0),
    Offset(24.0, 49.0),
    Offset(25.0, 50.0),
    Offset(26.0, 51.0),
    Offset(26.0, 52.0),
    Offset(27.0, 53.0),
    Offset(28.0, 54.0),
    Offset(29.0, 55.0),
    Offset(30.0, 55.0),
    Offset(30.0, 56.0),
    Offset(31.0, 57.0),
    Offset(32.0, 58.0),
    Offset(33.0, 59.0),
    Offset(27.0, 57.0),
    Offset(26.0, 58.0),
    Offset(25.0, 59.0),
    Offset(24.0, 59.0),
    Offset(26.0, 0.0),
    Offset(27.0, 1.0),
    Offset(27.0, 2.0),
    Offset(27.0, 4.0),
    Offset(28.0, 4.0),
    Offset(29.0, 4.0),
    Offset(30.0, 3.0),
    Offset(31.0, 3.0),
    Offset(32.0, 2.0),
    Offset(33.0, 3.0),
    Offset(34.0, 3.0),
    Offset(37.0, 5.0),
    Offset(35.0, 4.0),
    Offset(37.0, 4.0),
    Offset(36.0, 4.0),
    Offset(38.0, 4.0),
    Offset(39.0, 5.0),
    Offset(40.0, 5.0),
    Offset(41.0, 5.0),
    Offset(42.0, 5.0),
    Offset(43.0, 6.0),
    Offset(44.0, 6.0),
    Offset(28.0, 1.0),
    Offset(29.0, 1.0),
    Offset(30.0, 1.0),
    Offset(31.0, 0.0),
    Offset(32.0, 0.0),
    Offset(33.0, 0.0),
    Offset(35.0, 1.0),
    Offset(34.0, 0.0),
    Offset(36.0, 2.0),
    Offset(37.0, 2.0),
    Offset(38.0, 2.0),
    Offset(39.0, 2.0),
    Offset(40.0, 3.0),
    Offset(41.0, 3.0),
    Offset(42.0, 3.0),
    Offset(42.0, 2.0),
    Offset(41.0, 1.0),
    Offset(41.0, 0.0),
    Offset(43.0, 0.0),
    Offset(44.0, 1.0),
    Offset(44.0, 2.0),
    Offset(45.0, 3.0),
    Offset(45.0, 4.0),
    Offset(46.0, 5.0),
    Offset(47.0, 6.0),
    Offset(48.0, 7.0),
    Offset(48.0, 8.0),
    Offset(49.0, 10.0),
    Offset(49.0, 9.0),
    Offset(50.0, 11.0),
    Offset(51.0, 12.0),
    Offset(51.0, 11.0),
    Offset(52.0, 10.0),
    Offset(52.0, 9.0),
    Offset(53.0, 8.0),
    Offset(54.0, 8.0),
    Offset(55.0, 7.0),
    Offset(56.0, 7.0),
    Offset(57.0, 7.0),
    Offset(58.0, 7.0),
    Offset(58.0, 9.0),
    Offset(57.0, 10.0),
    Offset(56.0, 10.0),
    Offset(55.0, 10.0),
    Offset(54.0, 11.0),
    Offset(53.0, 12.0),
    Offset(54.0, 12.0),
    Offset(55.0, 12.0),
    Offset(57.0, 12.0),
    Offset(58.0, 12.0),
    Offset(56.0, 12.0),
    Offset(55.0, 15.0),
    Offset(56.0, 15.0),
    Offset(57.0, 15.0),
    Offset(58.0, 15.0),
    Offset(58.0, 14.0),
    Offset(57.0, 14.0),
    Offset(56.0, 14.0),
    Offset(45.0, 7.0),
    Offset(46.0, 8.0),
    Offset(46.0, 9.0),
    Offset(46.0, 10.0),
    Offset(47.0, 11.0),
    Offset(47.0, 12.0),
    Offset(48.0, 13.0),
    Offset(49.0, 14.0),
    Offset(50.0, 14.0),
    Offset(51.0, 14.0),
    Offset(52.0, 14.0),
    Offset(53.0, 14.0),
    Offset(54.0, 16.0),
    Offset(54.0, 17.0),
    Offset(53.0, 18.0),
    Offset(52.0, 19.0),
    Offset(51.0, 20.0),
    Offset(51.0, 21.0),
    Offset(50.0, 22.0),
    Offset(50.0, 23.0),
    Offset(49.0, 23.0),
    Offset(50.0, 24.0),
    Offset(50.0, 25.0),
    Offset(50.0, 27.0),
    Offset(51.0, 28.0),
    Offset(52.0, 29.0),
    Offset(53.0, 29.0),
    Offset(53.0, 30.0),
    Offset(54.0, 31.0),
    Offset(55.0, 32.0),
    Offset(55.0, 33.0),
    Offset(55.0, 34.0),
    Offset(55.0, 35.0),
    Offset(55.0, 36.0),
    Offset(56.0, 35.0),
    Offset(57.0, 35.0),
    Offset(58.0, 35.0),
    Offset(56.0, 36.0),
    Offset(56.0, 39.0),
    Offset(57.0, 38.0),
    Offset(58.0, 37.0),
    Offset(52.0, 15.0),
    Offset(52.0, 16.0),
    Offset(51.0, 17.0),
    Offset(50.0, 18.0),
    Offset(49.0, 19.0),
    Offset(48.0, 20.0),
    Offset(48.0, 21.0),
    Offset(47.0, 22.0),
    Offset(47.0, 23.0),
    Offset(47.0, 24.0),
    Offset(47.0, 25.0),
    Offset(48.0, 26.0),
    Offset(48.0, 27.0),
    Offset(48.0, 28.0),
    Offset(49.0, 29.0),
    Offset(50.0, 30.0),
    Offset(51.0, 31.0),
    Offset(52.0, 32.0),
    Offset(53.0, 33.0),
    Offset(53.0, 34.0),
    Offset(52.0, 35.0),
    Offset(52.0, 36.0),
    Offset(52.0, 37.0),
    Offset(52.0, 38.0),
    Offset(53.0, 39.0),
    Offset(54.0, 40.0),
    Offset(54.0, 41.0),
    Offset(55.0, 42.0),
    Offset(55.0, 43.0),
    Offset(55.0, 44.0),
    Offset(55.0, 45.0),
    Offset(55.0, 46.0),
    Offset(55.0, 47.0),
    Offset(56.0, 46.0),
    Offset(55.0, 48.0),
    Offset(55.0, 49.0),
    Offset(55.0, 50.0),
    Offset(55.0, 51.0),
    Offset(55.0, 52.0),
    Offset(54.0, 53.0),
    Offset(54.0, 54.0),
    Offset(53.0, 55.0),
    Offset(53.0, 56.0),
    Offset(53.0, 57.0),
    Offset(53.0, 58.0),
    Offset(52.0, 59.0),
    Offset(56.0, 40.0),
    Offset(57.0, 41.0),
    Offset(57.0, 42.0),
    Offset(57.0, 43.0),
    Offset(58.0, 44.0),
    Offset(58.0, 45.0),
    Offset(58.0, 46.0),
    Offset(58.0, 47.0),
    Offset(58.0, 48.0),
    Offset(58.0, 49.0),
    Offset(58.0, 50.0),
    Offset(58.0, 52.0),
    Offset(57.0, 53.0),
    Offset(56.0, 54.0),
    Offset(56.0, 55.0),
    Offset(56.0, 56.0),
    Offset(57.0, 57.0),
    Offset(55.0, 58.0),
    Offset(57.0, 59.0),
    Offset(56.0, 59.0),
    Offset(55.0, 59.0),
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
                  child: Image.asset("assets/images/ictuvip.jpg"),
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
