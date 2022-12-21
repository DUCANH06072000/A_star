import 'package:flutter/painting.dart';

class dataBarriers{
  List<Offset> barriers = [];

  dataBarriers(this.barriers){
    barriers.add(Offset(0.0, 8.0));
    barriers.add(Offset(1.0, 7.0));
    barriers.add(Offset(2.0, 6.0));
  }
}