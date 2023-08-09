import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int currentStep = 0;
  List<String> backgroundImages = [
    'https://images.template.net/116336/1-week-weight-loss-diet-chart-wmzws.jpeg',
    'https://twosleevers.com/wp-content/uploads/2018/02/KETO-DIET-PLAN-2post.jpg',
    'https://i.pinimg.com/564x/d5/cd/8e/d5cd8e8cff8a6378f6aa2289272ace98.jpg',
    'https://i.pinimg.com/originals/f6/c2/1a/f6c21a58818b9d09ce1daef9bb2818a8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress',
          style: TextStyle(color: Color(0xFFFFC300)),
        ),
        backgroundColor: const Color(0xFF581845), // Change app bar color to red
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(backgroundImages[currentStep]),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Week ${currentStep + 1} Progress:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      currentStep == 0 ? FontWeight.bold : FontWeight.normal,
                  color: currentStep == 0 ? Colors.red : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (currentStep + 1) / backgroundImages.length,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (currentStep < backgroundImages.length - 1) {
                      currentStep++;
                    } else {
                      currentStep = 0; // Reset to the first week when completed
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF581845), // Change button color to red
                ),
                child: Text(
                  'Complete Week ${currentStep + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: currentStep == backgroundImages.length - 1
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Completed successfully!!'),
                      content: const Text('Check out the other things'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.pop(context); // Go back to CardsPage
                          },
                          child: const Text('Back to CardsPage'),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor:
                  Colors.red,
              child: const Icon(Icons.check), // Change floating action button color to red
            )
          : null,
    );
  }
}

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diet',
          style: TextStyle(color: Color(0xFFFFC300)),
        ),
        backgroundColor: const Color(0xFF581845),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Section(
                title: 'Weight loss',
                cardCount: 2,
                imageUrls: [
                  'https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781638780540/28-day-liver-health-weight-loss-solution-9781638780540_hr.jpg',
                  'https://blogger.googleusercontent.com/img/a/AVvXsEiPrc9ojtALkbWFzkpXIlonGKPm1W6XfiybNV094SRWEc33L_evoZ9mad3jo60_TCTDn2atInTGu6EQQ-T1taW4Wnaj7Mbqu4KpHUIjw5-fWpJueHcLDCCk-GquTwEL6YnX13OVMgnMIFAJWm6dIQA8ZBL5G9pf0kacQMZ-FNa9tEmg6C9FhUE1KofqAQ=w640-h426',
                ],
              ),
              const Section(
                title: 'Health and longevity',
                cardCount: 3,
                imageUrls: [
                  'https://fitelo.co/wp-content/uploads/2022/12/COver0661.png',
                  'https://www.bajajfinservmarkets.in/content/dam/bajajfinserv/banner-website/heath-insurance/support-pages/Healthydiet1.png',
                  'https://i.pinimg.com/originals/b4/d4/45/b4d445dc10ee1804a8221139b4ede86f.jpg',
                ],
              ),
              const Section(
                title: 'Weight gain',
                cardCount: 2,
                imageUrls: [
                  'https://fitelo.co/wp-content/uploads/2022/08/image_6487327.jpg',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjxtvw6J1ooxqhU3kQuDjM9JLcSvzw3uNbBA&usqp=CAU',
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProgressPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF581845), // Change button color to red
                ),
                child: const Text(
                  'Go to Progress Page',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final int cardCount;
  final List<String> imageUrls;

  const Section({
    Key? key,
    required this.title,
    required this.cardCount,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(cardCount, (index) {
              return buildCard(context, index);
            }),
          ),
        ),
      ],
    );
  }

  Widget buildCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProgressPage(),
          ),
        );
      },
      child: Container(
        width: 250,
        height: 250,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              imageUrls[index],
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
