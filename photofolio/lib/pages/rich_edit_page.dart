


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        Align(
          child: IconButton(
              iconSize: 20,
              icon: Icon(Icons.cancel_outlined,size: 25,),
              onPressed: () {
                print(quillController.document.runtimeType.toString() +
                  quillController.document.toPlainText().toString()
                );
              },
          ), 
          alignment: FractionalOffset(1, 0),
        ),
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