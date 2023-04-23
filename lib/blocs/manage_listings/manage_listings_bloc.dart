import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_listings_event.dart';
part 'manage_listings_state.dart';

class ManageListingsBloc
    extends Bloc<ManageListingsEvent, ManageListingsState> {
  ManageListingsBloc() : super(ManageListingsInitialState()) {
    on<ManageListingsEvent>((event, emit) async {
      emit(ManageListingsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('pet_listings');
      SupabaseQueryBuilder categoryTable =
          supabaseClient.from('pet_categories');
      SupabaseQueryBuilder favoritesTable = supabaseClient.from('favorites');
      SupabaseQueryBuilder profileTable = supabaseClient.from('profiles');
      SupabaseQueryBuilder imageTable =
          supabaseClient.from('pet_listing_images');
      try {
        if (event is GetAllListingsEvent) {
          List<dynamic> temp = [];

          if (event.query != null && event.categoryId != null) {
            temp = await queryTable
                .select('*')
                .ilike('title', '%${event.query}%')
                .eq('category_id', event.categoryId)
                .eq('status', event.status)
                .order('title', ascending: true);
          } else if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('title', '%${event.query}%')
                .eq('status', event.status)
                .order('title', ascending: true);
          } else if (event.categoryId != null) {
            temp = await queryTable
                .select('*')
                .eq('category_id', event.categoryId)
                .eq('status', event.status)
                .order('title', ascending: true);
          } else {
            temp = await queryTable
                .select('*')
                .eq('status', event.status)
                .order('title', ascending: true);
          }

          List<Map<String, dynamic>> listings =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < listings.length; i++) {
            listings[i]['images'] = await imageTable
                .select('*')
                .eq('pet_listing_id', listings[i]['id']);

            listings[i]['seller'] = await profileTable
                .select('*')
                .eq('user_id', listings[i]['by_user_id'])
                .single();

            listings[i]['category'] = await categoryTable
                .select('*')
                .eq('id', listings[i]['category_id'])
                .single();

            if (listings[i]['bought_by'] != null) {
              listings[i]['bought_user'] = await profileTable
                  .select('*')
                  .eq('user_id', listings[i]['bought_by'])
                  .single();
            }
          }

          Logger().w(listings);

          if (event.status == 'pending') {
            emit(
              ManageListingsSuccessState(
                listings: listings,
              ),
            );
          } else {
            emit(
              OrdersListingsSuccessState(
                listings: listings,
              ),
            );
          }
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ManageListingsFailureState());
      }
    });
  }
}
