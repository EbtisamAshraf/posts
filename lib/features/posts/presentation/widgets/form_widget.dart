import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/domain/entities/posts.dart';
import 'package:posts/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:posts/features/posts/presentation/widgets/custom_text_form_field.dart';

class CustomFormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const CustomFormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text =  widget.post!.title;
      bodyController.text = widget.post!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            hint: 'title',
            controller: titleController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            hint: 'Body',
            controller: bodyController,
            maxLines: 6,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: onPress,
              icon: Icon(widget.isUpdatePost ? Icons.edit : Icons.add),
              label: Text(widget.isUpdatePost ? 'Edit' : 'add'))
        ],
      ),
    );
  }

  onPress() async{
    if (formKey.currentState!.validate())  {
      Post post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: titleController.text,
          body: bodyController.text);

      if (widget.isUpdatePost) {
      await  BlocProvider.of<PostsCubit>(context).updatePost(post);
      
      } else {
      await  BlocProvider.of<PostsCubit>(context).addPost(post);
      
      }
    }
  }
}
