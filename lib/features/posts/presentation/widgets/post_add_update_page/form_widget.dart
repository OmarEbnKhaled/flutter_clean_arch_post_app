import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../bloc/add_delete_updete_post/add_delete_update_post_bloc.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({
    super.key,
    required this.isUpdatePost,
    this.post,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    final Post updatedpost = Post(
      id: widget.isUpdatePost ? widget.post!.id : null,
      title: _titleController.text,
      body: _bodyController.text,
    );

    if (isValid) {
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: updatedpost));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: updatedpost));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: 'Title',
            controller: _titleController,
            linesNumber: 1,
          ),
          TextFormFieldWidget(
            name: 'Body',
            controller: _bodyController,
            linesNumber: 6,
          ),
          ElevatedButton.icon(
            onPressed: validateFormThenUpdateOrAddPost,
            icon: widget.isUpdatePost
                ? const Icon(Icons.edit)
                : const Icon(Icons.add),
            label: Text(
              widget.isUpdatePost ? 'Update' : 'Add',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
