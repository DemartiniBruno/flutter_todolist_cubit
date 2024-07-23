abstract class HomeState{}

class InitialHomeState extends HomeState{}

class LoadingHomeState extends HomeState{}

class LoadedHomeState extends HomeState{
  List<String> tarefas;

  LoadedHomeState(this.tarefas);
}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState(this.message);
}