import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final Logger logger;
  const AppBlocObserver({required this.logger});
  ///We can run something, when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.i("BlocObserver: Created Bloc [$bloc]");
    ///We can check, if the BlocBase is a Bloc or a Cubit
    if (bloc is Cubit) {
      logger.i("BlocObserver: Created Cubit [$bloc]");
    } else {
      logger.i("BlocObserver: Created Cubit [$bloc]");
    }
  }

  ///We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i("an event Happened in $bloc the event is $event");
  }

  ///We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    /// With this we can specifically know, when and what changed in our Bloc
    logger.i("There was a transition from ${transition.currentState} to ${transition.nextState}");
  }

  ///We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.i("Error happened in $bloc with error $error and the stacktrace is $stackTrace");
  }

  ///We can even run something, when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.i("BLOC is closed");
  }
}