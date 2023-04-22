import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      emit(CategoriesLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('pet_categories');
      try {
        if (event is GetAllCategoriesEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('category', '%${event.query}%')
                .order('category', ascending: true);
          } else {
            temp =
                await queryTable.select('*').order('category', ascending: true);
          }

          List<Map<String, dynamic>> categories =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            CategoriesSuccessState(
              categories: categories,
            ),
          );
        } else if (event is AddCategoriesEvent) {
          String path = await supabaseClient.storage.from('docs').uploadBinary(
                'categories/${DateTime.now().millisecondsSinceEpoch.toString()}${event.image.name}',
                event.image.bytes!,
              );

          path = path.replaceRange(0, 5, '');

          await queryTable.insert(
            {
              'category': event.category,
              'image_url':
                  supabaseClient.storage.from('docs').getPublicUrl(path),
            },
          );

          add(GetAllCategoriesEvent());
        } else if (event is EditCategoriesEvent) {
          if (event.image != null) {
            String path =
                await supabaseClient.storage.from('docs').uploadBinary(
                      'categories/${DateTime.now().millisecondsSinceEpoch.toString()}${event.image!.name}',
                      event.image!.bytes!,
                    );
            path = path.replaceRange(0, 5, '');
            await queryTable.update(
              {
                'category': event.category,
                'image_url':
                    supabaseClient.storage.from('docs').getPublicUrl(path),
              },
            ).eq('id', event.categoryId);
          } else {
            await queryTable.insert(
              {
                'category': event.category,
              },
            );
          }

          add(GetAllCategoriesEvent());
        } else if (event is DeleteCategoriesEvent) {
          await queryTable.delete().eq('id', event.categoryId);
          add(GetAllCategoriesEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(CategoriesFailureState());
      }
    });
  }
}
