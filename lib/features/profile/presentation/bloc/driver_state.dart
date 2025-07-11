import 'package:profile_page/features/profile/domain/driver.dart';

abstract class DriverState {
  const DriverState();
}

class InitialDriverSTate extends DriverState {} 

class LoadingDriverState extends DriverState {}

class LoadedDriverState extends DriverState {
  final Driver driver;

  const LoadedDriverState({
    required this.driver,
  });
}

class UpdatedDriverInfoState extends DriverState {
  final Driver driver;

  const UpdatedDriverInfoState({
    required this.driver,
  });
}

class ErrorDriverState extends DriverState {
  final String message;

  const ErrorDriverState({
    required this.message,
  });
}
