import 'package:contact_bloc/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('https://c1c7-45-231-15-210.ngrok-free.app/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) => Dio().post('https://c1c7-45-231-15-210.ngrok-free.app/contacts', data: model.toMap());

  Future<void> update(ContactModel model) => Dio().put('https://c1c7-45-231-15-210.ngrok-free.app/contacts/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) => Dio().delete('https://c1c7-45-231-15-210.ngrok-free.app/contacts/${model.id}');
}
