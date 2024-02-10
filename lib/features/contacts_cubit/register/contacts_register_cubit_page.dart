import 'package:contact_bloc/features/contacts_cubit/register/cubit/contact_register_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsRegisterCubitPage extends StatefulWidget {
  const ContactsRegisterCubitPage({super.key});

  @override
  State<ContactsRegisterCubitPage> createState() =>
      _ContactsRegisterCubtPageState();
}

class _ContactsRegisterCubtPageState extends State<ContactsRegisterCubitPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _nameEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Cubit'),
      ),
      
      body: BlocListener<ContactRegisterCubit, ContactRegisterCubitState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (_) => true,
            orElse: () => false,
          );
        },
        
        listener: (context, state) {
          state.whenOrNull(
            success: () => Navigator.of(context).pop(),

            error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
          );
        },

        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
        
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
        
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    } 
                    
                    return null;
                  },
                ),
        
                TextFormField(
                  controller: _emailEC,
                  
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                  ),
        
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'E-Mail é obrigatório';
                    } 
                    
                    return null;
                  },
                ),
        
                ElevatedButton(
                  onPressed: () {
                    final validate = _formKey.currentState?.validate() ?? false;
        
                    if (validate) {
                      context
                          .read<ContactRegisterCubit>()
                          .register(ContactModel(
                            name: _nameEC.text,
                            email: _emailEC.text,
                          ));
                    }
                  },
                  child: const Text('Salvar'),
                ),
        
                Loader<ContactRegisterCubit, ContactRegisterCubitState>(
                  selector: (state) {
                    return state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
