import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'docs_trains_event.dart';
part 'docs_trains_state.dart';

class DocsTrainsBloc extends Bloc<DocsTrainsEvent, DocsTrainsState> {
  DocsTrainsBloc() : super(DocsTrainsInitialState()) {
    on<DocsTrainsEvent>((event, emit) async {
      emit(DocsTrainsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable =
          supabaseClient.from('doctors_and_trainers');
      try {
        if (event is GetAllDocsTrainsEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .eq('type', event.type)
                .ilike('name', '%${event.query}%')
                .order('name', ascending: true);
          } else {
            temp = await queryTable
                .select('*')
                .eq('type', event.type)
                .order('name', ascending: true);
          }

          List<Map<String, dynamic>> docsTrains =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            DocsTrainsSuccessState(
              docsTrains: docsTrains,
            ),
          );
        } else if (event is AddDocsTrainsEvent) {
          await queryTable.insert(
            {
              'name': event.name,
              'address_line': event.address,
              'place': event.place,
              'district': event.district,
              'state': event.state,
              'pin_code': event.pin,
              'phone': event.phone,
              'description': event.description,
              'type': event.type,
            },
          );

          add(GetAllDocsTrainsEvent(type: event.type));
        } else if (event is EditDocsTrainsEvent) {
          await queryTable.update(
            {
              'name': event.name,
              'address_line': event.address,
              'place': event.place,
              'district': event.district,
              'state': event.state,
              'pin_code': event.pin,
              'phone': event.phone,
              'description': event.description,
            },
          ).eq('id', event.docsTrainsId);

          add(GetAllDocsTrainsEvent(type: event.type));
        } else if (event is DeleteDocsTrainsEvent) {
          await queryTable.delete().eq('id', event.docsTrainsId);
          add(GetAllDocsTrainsEvent(type: event.type));
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(DocsTrainsFailureState());
      }
    });
  }
}
