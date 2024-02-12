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

  setUp(() {
    contactsRepository = MockContactsRepository();
    bloc = ContactRegisterBloc(contactsRepository: contactsRepository);
  });

  final model = ContactModel(name: 'James', email: 'James@gmail.com');

  blocTest<ContactRegisterBloc, ContactRegisterState>(
    'Deve inserir novo contato',
    build: () => bloc,
    act: (bloc) => bloc.add(
      ContactRegisterEvent.save(
        name: model.name,
        email: model.email,
      ),
    ),

    setUp: () {
      when(() => contactsRepository.create(model)).thenAnswer((_) async => Future<void>);
    },

    expect: () => [
      const ContactRegisterState.loading(),
      const ContactRegisterState.success(),
    ],
  );
}
