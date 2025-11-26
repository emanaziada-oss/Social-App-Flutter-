
import 'package:socialapp/models/posts_model.dart';

sealed class PostState {
  List <Object?> get props => [];
}
final class PostInitial extends PostState {}
final class PostLoading extends PostState {}
final class PostSuccess extends PostState{
  final List <PostsModel> posts;
  PostSuccess(this.posts);
  @override
  List <Object?> get props => [posts];
}
final class PostFailure extends PostState{
  final String message;
  PostFailure(this.message);
  @override
  List <Object?> get props => [message];
}


