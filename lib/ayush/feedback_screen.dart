import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEFF5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/bg.jpg"),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 100),
                  child: Text(
                    "FeedBack",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          maxLines: 12,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26,width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Enter Your feedBack Here',
                            hintStyle: TextStyle(
                              color: Colors.black
                            )
        
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 4, color: Color(0xFF3b3b6d)),
                              shadowColor: Colors.black,
                              backgroundColor: const Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              surfaceTintColor: Colors.white,
                              foregroundColor: Colors.grey,
                              minimumSize: Size(300, 60)
                          ),
                          onPressed: (){},
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 25,
                              color:  Colors.white,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
