part of "contact_list_bloc.dart";

@freezed
class ContactListState with _$ContactListState {
  factory ContactListState.initial() = ContactListStateInitial;
  factory ContactListState.data({required List<ContactModel> contacts}) =
      _ContactListStateData;
}