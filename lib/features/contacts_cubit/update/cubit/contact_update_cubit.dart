import 'dart:developer';

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_cubit_state.dart';
part 'contact_update_cubit.freezed.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateCubitState> {
  final ContactsRepository _repository;

  ContactUpdateCubit({required ContactsRepository contactsRepository})
      : _repository = contactsRepository,
        super(ContactUpdateCubitState.initial());

  Future<void> update(ContactModel model) async {
    try {
      emit(ContactUpdateCubitState.loading());

      await _repository.update(model);
      
      emit(ContactUpdateCubitState.success());
    } catch (e, s) {
      log('Erro ao atualizar o contato', error: e, stackTrace: s);
      emit(ContactUpdateCubitState.error(
          message: 'Erro ao atualizar o contato'));
    }
  }
}
