import 'package:cubit_teste/home/home_cubit.dart';
import 'package:cubit_teste/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late final HomeCubit cubit;
  final TextEditingController _nameControl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<HomeCubit>(context);

    cubit.stream.listen((state) {
      if (state is ErrorHomeState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message))
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('teste'),
          backgroundColor: Colors.amber,
        ),
        body: Stack(
          children: [
            // Text('teste'),
            BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is InitialHomeState) {
                  return const Center(
                    child: Text('Não tem Tarefa'),
                  );
                } else if (state is LoadingHomeState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedHomeState) {
                  return _buildTarefas(state.tarefas);
                } else {
                  return _buildTarefas(cubit.tarefas);
                }
              },
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                height: 150,
                color: Colors.white10,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _nameControl,
                        decoration: const InputDecoration(
                            label: Text('Nome'), border: OutlineInputBorder()),
                      )),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            cubit.addTarefa(tarefa: _nameControl.text);
                            _nameControl.clear();
                          },
                          child: Icon(Icons.add))
                    ],
                  ),
                ),
              ),
            ),
            // Text('teste')
          ],
        ));
  }

  Widget _buildTarefas(List<String> tarefas) {
    return ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Center(
              child: Text(tarefas[index][0]),
            ),
          ),
          title: Text(tarefas[index]),
          trailing: IconButton(
            onPressed: () {
              cubit.removeTarefa(index: index);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
