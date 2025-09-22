import 'package:fluttertoast/fluttertoast.dart';
import 'logger.dart';

void handleError(Object error, [StackTrace? stack]) {
  log.e('Error', error: error, stackTrace: stack);
  Fluttertoast.showToast(msg: 'Something went wrong. Please try again.');
}
