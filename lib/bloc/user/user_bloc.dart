import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';


class UserBloc extends Bloc<UserEvent,UserState> {
  UserBloc():super(const UserInitialState()){
  
    on<ActivateUser>( (event, emit) {

      emit( UserSetState(event.user) );

    });

    on<ChangeUserAge>((event, emit) {
      if (!state.existUser) return;
      emit( UserSetState(state.user!.copyWith(edad: event.age)) );
    });

    on<AddProfesionUser>((event, emit) {
      if (!state.existUser) return;
      final auxUser = state.user!.copyWith();
      auxUser.profesiones.add(event.profesion);
      emit( UserSetState(auxUser) );
    });
  }


}