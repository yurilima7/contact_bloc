import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  // declaração
  late ContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

  // preparação
  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(contactsRepository: repository);
    contacts = [
      ContactModel(name: 'Lima', email: 'lima@gmail.com'),
      ContactModel(name: 'Lima Pessoal', email: 'lima2@gmail.com'),
    ];
  });

  // execução
  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),

    setUp: () {
      when(() => repository.findAll(),).thenAnswer((_) async => contacts);
    },
    
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(model: contacts),
    ],
  );

  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve retornar error ao buscar os contatos',
    build: () => cubit,
    act: (bloc) => cubit.findAll(),

    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.error(error: 'Erro ao buscar contatos'),
    ],
  );
}