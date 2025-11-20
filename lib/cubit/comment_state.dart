import 'package:equatable/equatable.dart';
import 'package:socialapp/models/comments_model.dart';


sealed class CommentState extends Equatable {
  List<Object?> get props => [];
}

final class CommentInitial extends CommentState {}
final class CommentLoading extends CommentState {}

final class CommentSuccess extends CommentState {
  final List<CommentModel?> comments;

  CommentSuccess(this.comments);

  List<Object?> get props => [comments];
}
final class CommentError extends CommentState {
  final String error;

  CommentError(this.error);

  List<Object?> get props => [error];
}


