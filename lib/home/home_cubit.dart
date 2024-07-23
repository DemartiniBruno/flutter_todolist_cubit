import 'package:cubit_teste/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final List<String> _tarefas = [];

  /*
  * Criando um getter para o array privado _tarefas
  * */
  List<String> get tarefas => _tarefas;

  HomeCubit() : super(InitialHomeState());

  Future<void> addTarefa({required String tarefa}) async {
    emit(LoadingHomeState());

    await Future.delayed(const Duration(seconds: 1));

    if (_tarefas.contains(tarefa)) {
      emit(ErrorHomeState('Tarefa já adicionada'));
    } else {
      _tarefas.add(tarefa);
      emit(LoadedHomeState(_tarefas));
    }
  }

  Future<void> removeTarefa({required int index}) async {
    emit(LoadingHomeState());

    await Future.delayed(const Duration(seconds: 1));

    _tarefas.removeAt(index);
    emit(LoadedHomeState(_tarefas));
  }
}
