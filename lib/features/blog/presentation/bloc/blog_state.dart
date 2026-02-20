part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  const BlogFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class BlogsDisplaySuccess extends BlogState {
  final List<Blog> blogs;

  const BlogsDisplaySuccess(this.blogs);

  @override
  List<Object> get props => [blogs];
}

final class BlogUploadSuccess extends BlogState {}
