import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dashboard_count_event.dart';
part 'dashboard_count_state.dart';

class DashboardCountBloc
    extends Bloc<DashboardCountEvent, DashboardCountState> {
  DashboardCountBloc() : super(DashboardCountInitialState()) {
    on<DashboardCountEvent>((event, emit) async {
      emit(DashboardCountLoadingState());

      final SupabaseClient supabaseClient = Supabase.instance.client;

      PostgrestResponse ordersCount = await supabaseClient
          .from('pet_listings')
          .select('*', const FetchOptions(count: CountOption.exact))
          .neq('status', 'pending');

      PostgrestResponse listingsCount = (await supabaseClient
          .from('pet_listings')
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq('status', 'pending'));

      PostgrestResponse doctorCount = await supabaseClient
          .from('doctors_and_trainers')
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq('type', 'doctor');

      PostgrestResponse trainerCount = await supabaseClient
          .from('doctors_and_trainers')
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq('type', 'trainer');

      try {
        Map<String, dynamic> dashbordCount = {
          'orders': ordersCount.count.toString(),
          'listings': listingsCount.count.toString(),
          'doctors': doctorCount.count.toString(),
          'trainers': trainerCount.count.toString(),
        };

        Logger().w(dashbordCount);

        emit(DashboardCountSuccessState(dashbordCount: dashbordCount));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DashboardCountFailureState());
      }
    });
  }
}
