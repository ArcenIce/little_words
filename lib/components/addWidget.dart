import 'package:flutter/material.dart';

class addButton extends StatelessWidget{

  const addButton({super.key});

  void _addNoteInDatabase(){
    print('Test');
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
                      child: TextFormField(
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
                            onPressed: _addNoteInDatabase,
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