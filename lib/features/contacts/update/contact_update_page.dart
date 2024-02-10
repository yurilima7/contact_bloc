import 'package:contact_bloc/features/contacts/update/bloc/contact_update_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contactModel;

  const ContactUpdatePage({super.key, required this.contactModel});

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailEC;
  late final TextEditingController _nameEC;

  @override
  void initState() {
    _nameEC = TextEditingController(text: widget.contactModel.name);
    _emailEC = TextEditingController(text: widget.contactModel.email);
    super.initState();
  }

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
        title: const Text('Update'),
      ),

      body: BlocListener<ContactUpdateBloc, ContactUpdateState>(
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
            },
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
                      context.read<ContactUpdateBloc>().add(
                            ContactUpdateEvent.save(
                              id: widget.contactModel.id!,
                              name: _nameEC.text,
                              email: _emailEC.text,
                            ),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
        
                Loader<ContactUpdateBloc, ContactUpdateState>(
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
