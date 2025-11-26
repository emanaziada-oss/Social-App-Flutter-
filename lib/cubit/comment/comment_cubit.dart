import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:socialapp/models/comments_model.dart';
import '../../services/firebase_comment_service.dart';
import 'comment_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  StreamSubscription? _streamSub;
  final _service = FirebaseCommentService.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  String? get uname => FirebaseAuth.instance.currentUser!.displayName;

  Future<void> listenToComments(String postId) async {
    emit(CommentLoading());
    // Cancel old stream before starting a new one
    await _streamSub?.cancel();
    _streamSub = _service.getComments(postId).listen((comments) {
      emit(CommentSuccess(comments));
    }, onError: (error) {
      emit(CommentError(error.toString()));
    });
  }

  Future<void> addComment(String postId, String text ) async {
    emit(CommentLoading());
    final commentModel = CommentModel(authorName: uname!, text: text);
    try{
      await _service.addComment(postId, commentModel);
      emit(CommentInitial());
    }catch(e){
      emit(CommentError(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _streamSub?.cancel();
    return super.close();
  }
}

