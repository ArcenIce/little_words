import 'package:flutter/material.dart';
import 'package:little_words/components/homepage.dart';
import '../helpers/dataHelper.dart';
import '../components/mainapp.dart';


class AddButton extends StatefulWidget {

  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}


class _AddButtonState extends State<AddButton>{

  final _textEditingController = TextEditingController();
  var content = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_editingText);
  }


  void _addNoteInDatabase() async {
    var user = await getData();
    var location = await getPosition();
    print(location.latitude);
    print(location.longitude);
    postRequest(content, user, location.latitude, location.longitude);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
  }

  void _editingText(){
    setState(() {
      content = _textEditingController.text;      
    });
  }


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Button',
      onPressed: (){
        showModalBottomSheet(
          context: context, 
          builder: (BuildContext context) {
            return Container(
              height: 260, 
              color: Colors.white,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children : <Widget>[   
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0,top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Création d'une note",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0),
                      child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Taper le contenu de votre mot',
                        ),
                        minLines: 4, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.purple.shade300, // foreground
                            ),
                            onPressed:_addNoteInDatabase,
                            child: const Text('Ajouter le mot'),
                          )),
                        ],
                      ),
                    )
                ]
              )
            );
          });
      },
      child: const Icon(Icons.add),
    );
  }



}