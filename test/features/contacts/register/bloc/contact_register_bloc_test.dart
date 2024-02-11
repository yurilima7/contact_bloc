import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts/register/bloc/contact_register_bloc.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository contactsRepository;
  late ContactRegisterBloc bloc;
  late List<ContactModel> contacts;

  setUp(() {
    contactsRepository = MockContactsRepository();
    bloc = ContactRegisterBloc(contactsRepository: contactsRepository);
    contacts = [
      ContactModel(name: 'Lima', email: 'lima@gmail.com'),
      ContactModel(name: 'Lima Pessoal', email: 'lima2@gmail.com'),
    ];
  });

  blocTest<ContactRegisterBloc, ContactRegisterState>(
    'Deve inserir novo contato',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactRegisterEvent.save(name: 'James', email: 'James@gmail.com',)),

    setUp: () {
      when(
        () => contactsRepository
            .create(any()),
      ).thenAnswer((_) async {});
    },

    expect: () => [
      const ContactRegisterState.loading(),
      const ContactRegisterState.success(),
    ],
  );
}
