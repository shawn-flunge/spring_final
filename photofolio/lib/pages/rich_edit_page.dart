


import 'package:flutter/cupertino.dart';

import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';

class RichEditor extends StatefulWidget{

  RichEditorState createState() => RichEditorState();
}


class RichEditorState extends State<RichEditor>{

  QuillController quillController = QuillController.basic();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillToolbar.basic(
            controller: quillController, ), //uploadFileCallback: _uploadImageCallBack
        Expanded(
          child: Container(
            child: QuillEditor.basic(
              controller: quillController,
              readOnly: false, // change to true to be view only mode
            ),
          ),
        )
      ],
    );
  }


}