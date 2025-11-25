import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:socialapp/cubit/post/post_state.dart';
import 'package:socialapp/models/comments_model.dart';
import 'package:socialapp/models/posts_model.dart';
import '../../services/firebase_posts_service.dart';


class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  StreamSubscription? _streamSub;
  final _service = FirebasePostsService.instance;


  Future<void> listenToPosts() async {
    emit(PostLoading());
    // Cancel old stream before starting a new one
    await _streamSub?.cancel();
    _streamSub = _service.getPosts().listen((posts) {
      emit(PostSuccess(posts));
    }, onError: (error) {
      emit(PostFailure(error.toString()));
    });
  }

  Future<void> addPosts(String authorName, String content ) async {
    emit(PostLoading());
    final postsModel = PostsModel(authorName: authorName, content: content);
    try{
      await _service.addPost(postsModel);
      emit(PostInitial());
    }catch(e){
      emit(PostFailure(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _streamSub?.cancel();
    return super.close();
  }
}
