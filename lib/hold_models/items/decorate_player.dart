import 'package:flutter/material.dart';
import 'player_data.dart';

class DecoratePlayer extends StatelessWidget{
  final PlayerData playerData;

  const DecoratePlayer({
    Key? key, required this.playerData,
  }) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 16.0,bottom: 16,left: 0,right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('${playerData.playerPhotoUrl}') ,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${playerData.playerName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${playerData.playerNickName}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onPressed: (){
        },
      ),
    );
  }

}