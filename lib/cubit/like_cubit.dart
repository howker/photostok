import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photostok/cubit/like_state.dart';

@immutable
class LikeCubit extends Cubit<LikeState> {
  final bool isLiked;

  LikeCubit(this.isLiked) : super(null);
}
