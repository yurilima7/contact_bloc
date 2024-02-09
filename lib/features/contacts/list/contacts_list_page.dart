import 'package:contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),

      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) => current.maybeWhen(
          error: (error) => true,
          orElse: () => false,
        ),

        listener: (context, state) {
          state.whenOrNull(
            error: (error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          );
        },

        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactListBloc, ContactListState>(
                    selector: (state) =>
                      state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                  ),

                  BlocSelector<ContactListBloc, ContactListState,
                      List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => [],
                      );
                    },

                    builder: (_, contacts) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,

                      itemBuilder: (context, index) => ListTile(
                        title: Text(contacts[index].name),
                        subtitle: Text(contacts[index].email),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
