import 'package:contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListCubitPage extends StatelessWidget {
  const ContactsListCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Cubit'),
      ),

      body: RefreshIndicator(
        onRefresh: () => context.read<ContactListCubit>().findAll(),

        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactListCubit, ContactListCubitState>(
                    selector: (state) => state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                  ),
        
                  BlocSelector<ContactListCubit, ContactListCubitState,
                      List<ContactModel>>(
        
                    selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => <ContactModel>[],
                      );
                    },
        
                    builder: (_, contacts) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contacts.length,
        
                      itemBuilder: (_, index) {
                        final contact = contacts[index];
        
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(contact.name),

                              IconButton(
                                onPressed: () => context
                                    .read<ContactListCubit>()
                                    .deleteByModel(contact),
                                        
                                icon: const Icon(Icons.delete),
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                          
                          subtitle: Text(contact.email),
                        );
                      },
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
