import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/bloc/itinerary/upcoming_itineraries_bloc.dart';
import 'package:dotted/widgets/upcoming_itineraries_list.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingItineraries extends StatefulWidget {
  const UpcomingItineraries({super.key});

  @override
  State<UpcomingItineraries> createState() => _UpcomingItinerariesPageState();
}

class _UpcomingItinerariesPageState extends State<UpcomingItineraries>
    with AutomaticKeepAliveClientMixin {
  double boxHeight = 340;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RepositoryProvider(
      create: (context) => ItinerariesRepository(
          ItinerariesProvider(), UnsplashRepository(UnsplashProvider())),
      child: BlocProvider(
        create: (context) => UpcomingItinerariesBloc(
          context.read<ItinerariesRepository>(),
        ),
        child: UpcomingItinerariesConsumer(boxHeight: boxHeight),
      ),
    );
  }
}

class UpcomingItinerariesConsumer extends StatefulWidget {
  const UpcomingItinerariesConsumer({
    super.key,
    required this.boxHeight,
  });

  final double boxHeight;

  @override
  State<UpcomingItinerariesConsumer> createState() =>
      _UpcomingItinerariesConsumerState();
}

class _UpcomingItinerariesConsumerState
    extends State<UpcomingItinerariesConsumer> {
  @override
  void initState() {
    super.initState();
    context.read<UpcomingItinerariesBloc>().add(UpcomingItinerariesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpcomingItinerariesBloc, UpcomingItinerariesState>(
      listener: (context, state) {
        if (state is UpcomingItinerariesFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
            height: widget.boxHeight,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.upcomingItineraries.isEmpty) {
          return SizedBox.shrink();
        }

        return Column(
          children: [
            Text(
              "Upcoming Trips",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            UpcomingItinerariesList(
              upcomingItineraries: state.upcomingItineraries,
            ),
          ],
        );
      },
    );
  }
}
