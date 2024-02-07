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

      body: BlocBuilder<ExampleBloc, ExampleState>(builder: (context, state) {
        if (state is ExampleStateData) {
          return ListView.builder(
            itemCount: state.names.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(state.names[index]),
            ),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
