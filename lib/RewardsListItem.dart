import 'package:flutter/material.dart';
import 'package:quizcircle/RewardPage.dart';
import 'package:quizcircle/model/Reward.dart';

class RewardsListItem extends StatelessWidget {
  final Reward reward;

  RewardsListItem(this.reward);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(children: [
        new Expanded(
            child: new ListTile(
              title: new Text(reward.name,
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text(reward.description,
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
              trailing: new Text("${reward.cost}",
                  style: new TextStyle(fontWeight: FontWeight.w500)),
	      onTap: () {
	        if(reward.cost > 0) {
  		  Navigator.push(context, new MaterialPageRoute(
		    builder: (BuildContext context) => new RewardPage(reward),
		  ));
		} else {
		  showDialog<Null>(
		    context: context,
                    child: new AlertDialog(
		      title: const Text('Not enough hearts'),
		      content: const Text('You don\'t have enough hearts'),
		      actions: <Widget>[
		        new FlatButton(
			  child: const Text('GOT IT!'),
			    onPressed: () { Navigator.of(context).pop(); }
			    )]
                    )
		  );
	        }
              }
	    ))
	  ]
	));
  }
}



