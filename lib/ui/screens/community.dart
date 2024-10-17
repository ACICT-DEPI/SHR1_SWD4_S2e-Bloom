import 'package:bloom/constants.dart';
import 'package:bloom/models/user_model.dart';
import 'package:bloom/ui/screens/add_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  UserModel? userData;

  List name = [ "Roaa Ayman", "Asmaa Ali", "Ghada Fawzy", "Yasmeen Osama", 
  "Nada Hassan", "Aya Ahmed", "Lina Hossam", "Salma Tarek", 
  "Maha Khaled", "Hana Mostafa"];

List time = [
  "07:23", "12:33", "01:09", "10:18", 
  "03:45", "09:30", "05:17", "08:12", 
  "11:22", "06:50"
];

List like = [
  "687", "968", "342", "177", 
  "456", "789", "512", "624", 
  "901", "112"
];

List comment = [
  "22", "14", "88", "23", 
  "34", "19", "51", "62", 
  "72", "29"
];

List  share = [
  "4", "12", "13", "23", 
  "7", "5", "9", "10", 
  "6", "8"
];

List  photo = [
  "assets/plants/c4f2cff083701e6d7d628aeacdb6f9a0.jpg", "assets/plants/Id6.jpg", 
  "assets/plants/Id0(1).jpg", "assets/plants/Id5.jpg", 
  "assets/plants/Id1.jpg", "assets/plants/Id5(2).jpg", 
  "assets/plants/Id6(2).jpg", "assets/plants/Id5.jpg", 
  "assets/plants/Id6(1).jpg", "assets/plants/Id0.jpg"
];

List post = [
  "Plants play a crucial role in improving indoor air quality by filtering toxins and releasing oxygen. Having a variety of plants in your living space not only beautifies your home but also contributes to a healthier environment, reducing stress levels and promoting well-being.",
  
  "Herbs such as basil, mint, and rosemary are easy to grow at home and can add a fresh and vibrant flavor to your meals. Growing your own herbs in small pots on your kitchen windowsill ensures you always have fresh ingredients on hand while also giving your home a touch of nature.",
  
  "Succulents are popular for their low-maintenance nature and ability to thrive in arid environments. They come in a variety of shapes and colors, making them a versatile option for home decor. Whether placed in a sunny window or a decorative pot, succulents add a unique touch to any space.",
  
  "Research has shown that indoor plants can help reduce anxiety, lower blood pressure, and improve concentration and productivity. By incorporating plants into your living or workspace, you create a calming atmosphere that promotes relaxation and mental clarity, helping you stay focused and less stressed throughout the day.",
  
  "Ferns are excellent plants for humid areas like bathrooms or kitchens. Their lush, feathery fronds add a touch of elegance to any space, and they thrive in indirect light and moist soil. Adding ferns to your home not only enhances its beauty but also helps maintain humidity levels, which can benefit your skin and respiratory system.",
  
  "Caring for plants teaches valuable lessons in patience, consistency, and responsibility. By taking the time to nurture your plants, you develop an appreciation for nature’s slow, steady growth. This mindfulness can be a rewarding experience, as you witness the progress of your plants over time.",
  
  "Spider plants are among the top-rated air-purifying plants, known for their ability to remove harmful pollutants like formaldehyde and carbon monoxide from the air. Easy to care for and capable of thriving in a variety of light conditions, spider plants make an excellent choice for both beginners and experienced plant enthusiasts.",
  
  "Aloe vera is not only an attractive plant but also has numerous health benefits. Known for its healing properties, aloe vera gel can be used to treat minor cuts, burns, and skin irritations. Having an aloe vera plant at home provides easy access to this natural remedy, while also serving as a decorative piece for your space.",
  
  "Cacti are hardy, resilient plants that require minimal care, making them perfect for people with busy schedules or those who tend to forget to water their plants. With their striking shapes and ability to survive in harsh conditions, cacti can add an interesting, modern touch to your home decor without demanding much attention.",
  
  "Adding greenery to your living space can dramatically improve its aesthetics and atmosphere. Plants not only bring a sense of freshness and vitality to your home but also create a more welcoming and inviting environment. Whether you choose hanging plants, potted flowers, or trailing vines, incorporating plants into your decor brings nature indoors, creating a peaceful, calming retreat."
];


  //bool loading = true ;

    void initState() {
// TODO: implement initState
    super.initState();
    UserModelProvider().getUserData().then((user) {
      setState(() {
        userData = user;
        //loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                   Navigator.push(
                     context, MaterialPageRoute(builder: (BuildContext) => const AddPostScreen()));
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                         CircleAvatar(
                                radius: 20,
                                backgroundColor: Constants.primaryColor,
                                backgroundImage: const AssetImage("assets/images/profile.jpg"),
                              ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container( 
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black45) 
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("Add New Post .... " , style: Constants.style4,),
                              ),
                            ),
                          ) ,
                          const SizedBox(width: 10,),
                          Icon(Icons.add_photo_alternate_outlined , color: Constants.primaryColor, size: 25,)   
                    
                    ],),
                  ),
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context ,index) => BuildPostItem(index), 
                itemCount: 10, 
                separatorBuilder: ( context, index) => const SizedBox(height: 15,),
                
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildPostItem(int index ) {
    return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Constants.primaryColor,
                            backgroundImage: const AssetImage("assets/plants/5915a8419ddae5a091c77078360f3a3c.jpg"),
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${name[index]}", style: Constants.style3),
                                Text("${time[index]} pm", style: Constants.style4.copyWith(fontSize: 13)),
                              ],
                            ),
                          ),
                          const Icon(Icons.more_horiz_rounded),
                        ],
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,  
                      ),
                      Text('${post[index]}',style: Constants.style3.copyWith(fontWeight: FontWeight.w500),),
                      Wrap(
                        spacing: 5,
                        children: [
                          InkWell(child:  Text("#plants",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell( child: Text("#green",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell(child: Text("#garden",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell(child: Text("#greenPlants",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell(child: Text("#flower",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell(child: Text("#bloom",style: Constants.style3.copyWith(color: Colors.blue),)),
                          InkWell(child: Text("#indoor",style: Constants.style3.copyWith(color: Colors.blue),)),
                        ],

                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        // elevation: 3,
                        child: Image.asset("${photo[index]}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                                 const Icon(CupertinoIcons.heart_fill , color: Colors.red, size: 16,) ,
                                 Text("${like[index]} " , style: Constants.style4.copyWith(fontSize: 12),),
                            ],
                          ),
                          const SizedBox(width: 10,),
                           Expanded(
                             child: Row(
                               children: [
                                    Icon(CupertinoIcons.chat_bubble , color: Constants.primaryColor,size: 16,) ,
                                    const SizedBox(width: 5,),
                                    Text("${comment[index]} Comment" , style: Constants.style4.copyWith(fontSize: 12),),
                               ],
                             ),
                           ),
                            Row(
                             children: [
                                  Icon(CupertinoIcons.share , color: Constants.primaryColor,size: 16,) ,
                                  const SizedBox(width: 5,),
                                  Text("${share[index]} Share" , style: Constants.style4.copyWith(fontSize: 12),),
                             ],
                                                       ),
                        ],
                      ), 
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,  
                      ),
                       Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Constants.primaryColor,
                            backgroundImage: const AssetImage("assets/images/profile.jpg"),
                            
                          ),
                          const SizedBox(width: 10,),
                          Text("Write a comment ...", style: Constants.style4.copyWith(fontSize: 13)),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }
}

