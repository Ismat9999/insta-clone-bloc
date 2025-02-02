import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_bloc.dart';

import '../../../data/models/member_model.dart';


Widget itemOfMember(Member member, MySearchBloc searchBloc,BuildContext context) {
  return Container(
    height: 90,
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              width: 1.5,
              color: Color.fromRGBO(193, 53, 132, 1),
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(22.5),
              child: member.img_url.isEmpty
                  ? Image(
                image: AssetImage("assets/images/ic_person.png"),
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              )
                  : Image.network(
                member.img_url,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.fullname,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              member.email,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(!member.followed){
                        searchBloc.followMember(member);
                      }else{
                        searchBloc.unFollowMember(member);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Center(
                        child: member.followed ? Text("Following"): Text("Follow"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
