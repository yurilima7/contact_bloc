import 'package:contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocFreezedExample extends StatelessWidget {
  const BlocFreezedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Freezed'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ExampleFreezedBloc>().add(
                const ExampleFreezedEvent.addName('Sarah Connor'),
              );
        },

        child: const Icon(Icons.add),
      ),

      body: BlocListener<ExampleFreezedBloc, ExampleFreezedState>(
        listener: (context, state) {
          state.whenOrNull(
            showBanner: (_, messager) =>
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messager),
              ),
            ),
          );
        },

        child: Column(
          children: [
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, bool>(
              selector: (state) {
                return state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
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
        
            BlocSelector<ExampleFreezedBloc, ExampleFreezedState, List<String>>(
              selector: (state) {
                return state.maybeWhen(
                  data: (names) => names,
                  showBanner: (names, _) => names,
                  orElse: () => <String>[],
                );
              },
        
              builder: (_, names) => ListView.builder(
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                  
                  },
                  title: Text(names[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
