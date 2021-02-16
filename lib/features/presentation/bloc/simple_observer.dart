import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  var logger = Logger();
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    logger.i('onCreate -- cubit: ${cubit.runtimeType}');
    // print('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    logger.i('onChange -- cubit: ${cubit.runtimeType}, change: $change');
    // print('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    logger.e('onError -- cubit: ${cubit.runtimeType}, error: $error');
    // print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    logger.d('onClose -- cubit: ${cubit.runtimeType}');
    // print('onClose -- cubit: ${cubit.runtimeType}');
  }
}
