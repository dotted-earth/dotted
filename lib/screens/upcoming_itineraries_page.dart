import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/bloc/itinerary/upcoming_itineraries_bloc.dart';
import 'package:dotted/widgets/upcoming_itineraries_list.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingItinerariesPage extends StatefulWidget {
  const UpcomingItinerariesPage({super.key});

  @override
  State<UpcomingItinerariesPage> createState() =>
      _UpcomingItinerariesPageState();
}

class _UpcomingItinerariesPageState extends State<UpcomingItinerariesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RepositoryProvider(
      create: (context) => ItinerariesRepository(
          ItinerariesProvider(), UnsplashRepository(UnsplashProvider())),
      child: BlocProvider(
        create: (context) =>
            UpcomingItinerariesBloc(context.read<ItinerariesRepository>()),
        child: const UpcomingItinerariesList(),
      ),
    );
  }
}
