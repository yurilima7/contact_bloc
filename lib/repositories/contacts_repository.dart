import 'package:contact_bloc/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  final link = 'https://b1ea-45-231-15-210.ngrok-free.app/contacts';

  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get(link);

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) => Dio().post(link, data: model.toMap());

  Future<void> update(ContactModel model) => Dio().put('$link/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) => Dio().delete('$link/${model.id}');
}
