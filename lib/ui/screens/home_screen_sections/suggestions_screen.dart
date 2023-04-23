import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/ui/widgets/custom_progress_indicator.dart';

import '../../../blocs/suggestion/suggestion_bloc.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/suggestions/suggestion_card.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final SuggestionBloc complaintBloc = SuggestionBloc();
  @override
  void initState() {
    super.initState();
    complaintBloc.add(GetAllSuggestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<SuggestionBloc>.value(
        value: complaintBloc,
        child: BlocConsumer<SuggestionBloc, SuggestionState>(
          listener: (context, state) {
            if (state is SuggestionFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                ),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: 1000,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: state is SuggestionSuccessState
                        ? state.suggestions.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) => SuggestionCard(
                                  suggestionDetails: state.suggestions[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: state.suggestions.length,
                              )
                            : const Center(
                                child: Text('No suggestions found'),
                              )
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
