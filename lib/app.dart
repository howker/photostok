import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/collections_cubit.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/cubit/related_photo_cubit.dart';
import 'package:photostok/cubit/search_cubit.dart';
import 'package:photostok/cubit/user_cubit.dart';
import 'package:photostok/repository/photo_repository.dart';
import 'package:photostok/res/res.dart';
import 'package:photostok/res/styles.dart';
import 'package:photostok/screens/home.dart';
import 'package:photostok/screens/detail_photo_screen.dart';
import 'package:photostok/screens/profile_screen.dart';

const String transitionToDetailScreen = '/fullScreenImage';
const String transitionToProfileScreen = '/profileScreen';
const String transitionToHome = '/home';

final photoRepository = PhotoRepository();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotoCubit>(
          create: (BuildContext context) {
            return PhotoCubit(photoRepository);
          },
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) {
            return UserCubit(photoRepository);
          },
        ),
        BlocProvider<CollectionsCubit>(
          create: (BuildContext context) {
            return CollectionsCubit(photoRepository);
          },
        ),
        BlocProvider<RelatedPhotoCubit>(
          create: (BuildContext context) {
            return RelatedPhotoCubit(photoRepository);
          },
        ),
        BlocProvider<SearchCubit>(
          create: (BuildContext context) {
            return SearchCubit(photoRepository);
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: buildAppTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings setting) {
          if (setting.name == transitionToDetailScreen) {
            FullScreenImageArguments args =
                (setting.arguments as FullScreenImageArguments);
            final route = FullScreenImage(
              photo: args.photo,
              heroTag: args.heroTag,
              index: args.index,
            );
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (setting.name == transitionToProfileScreen) {
            ProfileScreenArguments args =
                (setting.arguments as ProfileScreenArguments);
            final route = ProfileScreen(
              photo: args.photo,
              isMyProfile: args.isMyProfile,
            );
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (setting.name == transitionToHome) {
            final route = Home(
                onConnectivityChanged: Connectivity().onConnectivityChanged);
            return MaterialPageRoute(builder: (context) => route);
          } else
            return null;
        },
        home: Home(onConnectivityChanged: Connectivity().onConnectivityChanged),
      ),
    );
  }
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context).insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    overlayEntry?.remove();
  }
}
