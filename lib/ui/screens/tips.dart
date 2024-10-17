import 'package:bloom/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class TipsAndTricksScreen extends StatelessWidget {
  final String featuredTipUrl = "https://www.longfield-gardens.com/article/how-to-water-your-plants";

  const TipsAndTricksScreen({super.key}); 
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Tips & Tricks'),
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/images/plant_background.jpg'),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16.0,
              //   ),
              //   width: size.width ,
              //   decoration: BoxDecoration(
              //     color: Constants.primaryColor.withOpacity(.1),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.search,
              //         color: Colors.black54.withOpacity(.6),
              //       ),
              //       const Expanded(
              //           child: TextField(
              //         showCursor: false,
              //         decoration: InputDecoration(
              //           hintText: 'Search For Tips...',
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //         ),
              //       )
              //       ),
              //       Icon(
              //         Icons.mic,
              //         color: Colors.black54.withOpacity(.6),
              //       ),
              //     ],
              //   ),
              // ),
          
            // const TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search for tips...',
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(Icons.search),
            //   ),
            // ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: const [
        
                  TipsCard(
                    imageUrl: 'assets/images/watering.jpg',
                    title: 'Best Time to Water',
                    description: 'Water in the morning using room temperature water.',
                  ),
                  SizedBox(height: 10.0),
        
                  TipsCard(
                    imageUrl: 'assets/images/fertilizing_tips.jpg',
                    title: 'Fertilizing Tips',
                    description: 'Use balanced fertilizer every 4-6 weeks.',
                  ),
                  SizedBox(height: 10.0),
        
        
                  TipsCard(
                    imageUrl: 'assets/images/pests_control.jpg',
                    title: 'Pest Control',
                    description: 'Use natural remedies and inspect regularly.',
                  ),
                ],
              ),
            ),
        
        
            Wrap(
              spacing: 8.0,
              children: [
                GestureDetector(
                  onTap: () => _launchURL("https://www.thesill.com/blogs/plants-101/top-ten-plant-care-tips?srsltid=AfmBOorGja4-WunQN9pDZ1yq72tVc_8tagUi_g1v_4IVkL6LIECbgBwT"),
                  child: const Chip(label: Text('Indoor Plants')),
                ),
                GestureDetector(
                  onTap: () => _launchURL("https://sloatgardens.com/how-to-plant-a-plant-in-8-steps/"),
                  child: const Chip(label: Text('Outdoor Plants')),
                ),
                GestureDetector(
                  onTap: () => _launchURL("https://www.smilinggardener.com/organic-fertilizers/garden-fertilizer-tips/"),
                  child: const Chip(label: Text('Fertilizing')),
                ),
                GestureDetector(
                  onTap: () => _launchURL("https://www.fieldroutes.com/blog/pest-control-methods"),
                  child: const Chip(label: Text('Pest Control')),
                ),
              ],
            // Wrap(
            //   spacing: 8.0,
            //   children: [
            //
            //     Chip(label: Text('Indoor Plants')),
            //     Chip(label: Text('Outdoor Plants')),
            //     Chip(label: Text('Fertilizing')),
            //     Chip(label: Text('Pest Control')),
            //   ],
            ),
            const SizedBox(height: 16.0),
        
        Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Tip: How to Prune',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Best practices for pruning your plants.'),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () => _launchURL(featuredTipUrl),
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Tips'),
      //     BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'My Plants'),
      //     BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
      //   ],
      // ),
    );
  }


  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

}

class TipsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const TipsCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10.0),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}