import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_users_event.dart';
part 'manage_users_state.dart';

class ManageUsersBloc extends Bloc<ManageUsersEvent, ManageUsersState> {
  ManageUsersBloc() : super(ManageUsersInitialState()) {
    on<ManageUsersEvent>((event, emit) async {
      emit(ManageUsersLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('profiles');
      try {
        List<dynamic> temp = [];

        if (event.query != null) {
          temp = await queryTable
              .select('*')
              .ilike('name', '%${event.query}%')
              .order(
                'name',
                ascending: true,
              );
        } else {
          temp = await queryTable.select('*').order(
                'name',
                ascending: true,
              );
        }

        List<Map<String, dynamic>> users =
            temp.map((e) => e as Map<String, dynamic>).toList();

        emit(
          ManageUsersSuccessState(
            users: users,
          ),
        );
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ManageUsersFailureState());
      }
    });
  }
}
