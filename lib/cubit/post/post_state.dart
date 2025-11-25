
sealed class PostState {
  List <Object?> get props => [];
}
final class PostInitial extends PostState {}
final class PostLoading extends PostState {}
final class PostSuccess extends PostState{
  final List <Object?> posts;
  PostSuccess(this.posts);
  List <Object?> get props => [posts];
}
final class PostFailure extends PostState{
  final String message;
  PostFailure(this.message);
  List <Object?> get props => [message];
}


