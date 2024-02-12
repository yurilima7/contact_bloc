import 'package:bloc_test/bloc_test.dart';
import 'package:contact_bloc/features/contacts_cubit/register/cubit/contact_register_cubit.dart';
import 'package:contact_bloc/models/contact_model.dart';
import 'package:contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
  late ContactsRepository repository;
  late ContactRegisterCubit cubit;

  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactRegisterCubit(contactsRepository: repository);
  });
  
  final model = ContactModel(name: 'James', email: 'James@gmail.com');

  blocTest<ContactRegisterCubit, ContactRegisterCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.register(model),

    setUp: () {
      when(() => repository.create(model)).thenAnswer((_) async => Future<void>);
    },
    
    expect: () => [
      ContactRegisterCubitState.loading(),
      ContactRegisterCubitState.success(),
    ],
  );
}