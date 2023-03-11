part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ActivateUser extends UserEvent{
  final User user;

  ActivateUser(this.user);

}

class ChangeUserAge extends UserEvent {
  final int age;

  ChangeUserAge(this.age);

}

class AddProfesionUser extends UserEvent{
  final String profesion;

  AddProfesionUser(this.profesion); 
}