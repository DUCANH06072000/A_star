import 'package:logger/logger.dart';

class Log {
  static final Log _instance = Log._internal();
  Logger? _logger;

  factory Log() =>_instance;
  Log._internal(){
    _logger = Logger();
  }

  void e(String msg) {
    _logger?.e(">>> $msg");
  }

  void d(String msg) {
    _logger?.d(">>> $msg");
  }

  void i(String msg) {
    _logger?.i(">>> $msg");
  }
}
