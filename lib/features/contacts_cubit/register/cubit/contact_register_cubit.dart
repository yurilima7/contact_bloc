import 'dart:developer';

import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_cubit_state.dart';
part 'contact_register_cubit.freezed.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterCubitState> {
  final ContactsRepository _repository;

  ContactRegisterCubit({required ContactsRepository contactsRepository})
      : _repository = contactsRepository,
        super(ContactRegisterCubitState.initial());

  Future<void> register(ContactModel model) async {
    try {
      emit(ContactRegisterCubitState.loading());

      await _repository.create(model);

      emit(ContactRegisterCubitState.success());
    } catch (e, s) {
      log('Erro ao inserir contato', error: e, stackTrace: s);
      emit(ContactRegisterCubitState.error(message: 'Erro ao inserir contato'));
    }
  }
}
