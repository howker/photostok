import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/photos_cubit.dart';
import 'package:photostok/repository/photo_repository.dart';

import 'package:photostok/res/res.dart';
import 'package:photostok/res/styles.dart';
import 'package:photostok/screens/home.dart';
import 'package:photostok/screens/detail_photo_screen.dart';

const String transition = '/fullScreenImage';
final photoRepository = PhotoRepository();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoCubit>(
      create: (BuildContext context) {
        return PhotoCubit(photoRepository);
      },
      child: MaterialApp(
        theme: ThemeData(
          textTheme: buildAppTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings setting) {
          if (setting.name == transition) {
            FullScreenImageArguments args =
                (setting.arguments as FullScreenImageArguments);
            final route = FullScreenImage(
              photo: args.photo,
              heroTag: args.heroTag,
              index: args.index,
            );

            if (Platform.isAndroid) {
              return MaterialPageRoute(
                  builder: (context) => route, settings: args.routeSettings);
            } else if (Platform.isIOS) {
              return CupertinoPageRoute(
                  builder: (context) => route, settings: args.routeSettings);
            }
          }
          return null;
        },
        home: Home(Connectivity().onConnectivityChanged),
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
    overlayEntry.remove();
  }
}
