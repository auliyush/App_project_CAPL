import 'package:flutter/material.dart';

class PlayerAccountScreen extends StatelessWidget {
  final String playerPhotoUrl;
  final String? playerName;
  final String? playerNickName;
  final String? playerPhone;
  final String? playerEmail;
  final String playerType;
  final String playerSubType;
  final String playerAddress;
  final int highestScore;
  final int totalHalfCentury;
  final int totalFullCentury;
  final int totalMatches;
  final int totalRuns;
  final int totalFours;
  final int totalSixes;

  const PlayerAccountScreen({super.key,
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerPhone,
    required this.playerEmail,
    required this.playerType,
    required this.playerSubType,
    required this.playerAddress,
    required this.highestScore,
    required this. totalHalfCentury,
    required this. totalFullCentury,
    required this. totalMatches,
    required this. totalRuns,
    required this. totalFours,
    required this. totalSixes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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
                    "Account",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 19.0,),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: playerPhotoUrl.isNotEmpty // Check if a Cloudinary URL is available
                    ? NetworkImage(playerPhotoUrl) // Display the image from Cloudinary
                      : AssetImage('assets/images/default.jpg') as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerName!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerNickName!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerEmail!,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.sports_cricket,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerType,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.sports_cricket,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerSubType,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.home_work,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(7),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 8, left: 8),
                        child: Text(
                          playerAddress,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            buildStatsGrid([
              {'title': 'Matches', 'value': totalMatches.toString()},
              {'title': 'Runs', 'value': totalRuns.toString()},
              {'title': 'Highest Score', 'value': highestScore.toString()},
              {'title': '50s', 'value': totalHalfCentury.toString()},
              {'title': '100s', 'value': totalFullCentury.toString()},
              {'title': '4s/6s', 'value': '$totalFours/$totalSixes'},
            ]),
          ],
        ),
      ),
    );
  }
  Widget buildStatsGrid(List<Map<String, String>> stats) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridWidth = constraints.maxWidth - 32; // Subtract padding
        double itemWidth = gridWidth / 3; // Width for each item
        double itemHeight = 120; // Adjust height for better visibility

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: stats.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final stat = stats[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        stat['value']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        stat['title']!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
