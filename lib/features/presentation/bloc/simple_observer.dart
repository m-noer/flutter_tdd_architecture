import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object event) {
  //   print('onEvent $event');
  //   super.onEvent(bloc, event);
  // }

  // @override
  // onTransition(Bloc bloc, Transition transition) {
  //   print('onTransition $transition');
  //   super.onTransition(bloc, transition);
  // }

  // @override
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   print('onError $error');
  //   super.onError(cubit, error, stackTrace);
  // }
   @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    print('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print('onClose -- cubit: ${cubit.runtimeType}');
  }
}
