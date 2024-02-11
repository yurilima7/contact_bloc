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

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/contacts/cubit/register');
          context.read<ContactListCubit>().findAll();
        },
        child: const Icon(Icons.add),
      ),


      body: BlocListener<ContactListCubit, ContactListCubitState>(
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

        child: RefreshIndicator(
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
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                '/contacts/cubit/update',
                                arguments: contacts[index],
                              );
                              
                              context
                                  .read<ContactListCubit>().findAll();
                            },
  
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
      ),
    );
  }
}
