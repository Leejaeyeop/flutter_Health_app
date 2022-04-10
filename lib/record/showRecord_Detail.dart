import 'package:flutter/material.dart';

class ShowRecord_Detail extends StatelessWidget {
  
   ShowRecord_Detail({Key key,this.record}) : super(key: key);
  List<dynamic> record = [];
   var i;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        

        
      body: Center(
        child: ListView.builder(
          itemCount: this.record.length,
          itemBuilder: (context, index) {  
            i= 1+index;
            return ListTile(
              title: Text('$i' +'세트'),
              subtitle: Text(record[index]),
            );
          },
        ),
      ),
      );
  }
}
