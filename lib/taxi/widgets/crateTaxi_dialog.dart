import 'package:flutter/material.dart';

class CreateTaxiDialog extends StatefulWidget {
  const CreateTaxiDialog({
    super.key,
    required this.userID,
  });
  final int userID;

  @override
  State<CreateTaxiDialog> createState() => _CreateTaxiDialogState();
}

class _CreateTaxiDialogState extends State<CreateTaxiDialog> {
  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.now();
    int month = date.month;
    int day = date.day;

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 20,),
                child: Row(
                  children: [
                    Text(
                      '동승팀 만들기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,),
                child: Row(
                  children: [
                    Text(
                      '출발일',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF767676),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_left_sharp, color: Color(0xFF767676),)),
                        Text('${date.month}월 ${date.day}일', style: TextStyle(fontSize: 18),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_right_sharp), color: Color(0xFF767676)),
        
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month))
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
