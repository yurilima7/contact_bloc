part of 'contact_update_cubit.dart';

@freezed
class ContactUpdateCubitState with _$ContactUpdateCubitState {
  factory ContactUpdateCubitState.initial() = _Initial;
  factory ContactUpdateCubitState.loading() = _Loading;
  factory ContactUpdateCubitState.success() = _Success;
  factory ContactUpdateCubitState.error({required String message}) = _Error;
}
