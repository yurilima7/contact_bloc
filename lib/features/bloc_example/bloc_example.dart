import 'package:contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample extends StatelessWidget {
  const BlocExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),

      body: BlocListener<ExampleBloc, ExampleState>(
        listener: (context, state) {
          if (state is ExampleStateData) {  
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('A quantidade de nomes é ${state.names.length}'),
                ),
              );
          }
        },

        child: Column(
          children: [
            BlocConsumer<ExampleBloc, ExampleState>(
              listener: (context, state) {
                debugPrint('Estado alterado para ${state.runtimeType}');
              },

              builder: (_, state) {
                if (state is ExampleStateData) {
                  return Text('O total de nomes é ${state.names.length}');
                }

                return const SizedBox.shrink();
              },
            ),

            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }

                return false;
              },

              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleStateData) {
                  return state.names;
                }

                return [];
              },

              builder: (context, names) => ListView.builder(
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(names[index]),
                ),
              ),
            ),

            // BlocBuilder<ExampleBloc, ExampleState>(builder: (context, state) {
            //   if (state is ExampleStateData) {
            //     return ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: state.names.length,
            //       itemBuilder: (context, index) => ListTile(
            //         title: Text(state.names[index]),
            //       ),
            //     );
            //   }
            
            //   return const SizedBox.shrink();
            // }),
          ],
        ),
      ),
    );
  }
}
