import 'package:budget/widgets/globalSnackbar.dart';
import 'package:budget/widgets/navigationFramework.dart';

openSnackbar(SnackbarMessage message, {bool postIfQueue = true}) {
  snackbarKey.currentState!.post(message, postIfQueue: postIfQueue);
  return;
}
