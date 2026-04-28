import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:have_you_heard/core/di/service_locator.dart';
import 'package:have_you_heard/core/router/app_router.dart';
import 'package:have_you_heard/features/home/presentation/bloc/home_bloc.dart';
import 'package:have_you_heard/features/home/presentation/widgets/artist_carousel_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _carouselKey = GlobalKey<ArtistCarouselWidgetState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(sl(), sl(), sl())
        ..add(GetUserEvent())
        ..add(GetUserArtistsEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listenWhen: (prev, curr) => prev.user != null && curr.user == null,
        listener: (context, state) {
          context.router.replaceAll([const AuthRoute()]);
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: switch (state) {
                    HomeState(user: final user?) => Text(user.name),
                    HomeState(failure: final failure?) => Text(failure.message),
                    _ => const Text('. . .'),
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(LogoutEvent());
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: Column(
                children: [
                  if (state.artists != null && state.artists!.isNotEmpty)
                    ArtistCarouselWidget(
                      key: _carouselKey,
                      artists: state.artists!,
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _carouselKey.currentState?.scrollToRandomArtist();
                      },
                      child: const Text('Random Artist'),
                    ),
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
