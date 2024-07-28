import 'package:logger/logger.dart';

Logger kLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: false,
    printTime: false,
  ),
);





 