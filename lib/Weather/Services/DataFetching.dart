import 'dart:convert';
import '../Services/Location.dart' as location;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/weather.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  Future<WeatherData> getData() async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=13.35&lon=74.79&appid=358af07939445d0f4e5c3daf89f19537'));
    var data = jsonDecode(response.body.toString());
    print(data.toString());
    if(response.statusCode==200){
      return WeatherData.fromJson(data);
    }
    else{
      return WeatherData.fromJson(data);
    }
  }
  final temp= [14.5,28.0,18.5,20.0,41.2,19.5,16.3,35.2,19.1];
  final day= ["Today","Tuesday","Wednesday"];
  int d=0;

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextStyle titlefont= TextStyle(fontWeight: FontWeight.w600, fontSize: width*0.055);
    TextStyle infofont= TextStyle(fontWeight: FontWeight.w400, fontSize: width*0.053,color: Color.fromRGBO(255,255,255,0.8));



    return FutureBuilder<WeatherData>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Center(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: height*0.03,
                    ),
                    Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: height*0.1,
                    ),

                    SizedBox(
                      height: height*0.01,
                    ),
                    Text((((snapshot.data!.main!.temp)!-273).round().toString())+" °C",style: TextStyle(fontWeight: FontWeight.w400,fontSize: width*0.16),),
                    // Column(
                    //   children: [
                    //     FutureBuilder<WeatherData>(
                    //       future: getData(),
                    //       builder: (context, snapshot){
                    //         if(snapshot.hasData){
                    //           return Text(snapshot.data!.weather![0].main.toString(),
                    //             style: TextStyle(fontWeight: FontWeight.w700,fontSize: width*0.1),
                    //            );
                    //         }
                    //         else{
                    //           return Text('Loading');
                    //         }
                    //       },
                    //     )
                    //    ],
                    //   ),
                    Text(snapshot.data!.name.toString(), style: TextStyle(fontSize: width*0.06,color:Colors.grey ),),

                    SizedBox(height: height*0.03,),

                    //SizedBox(height: height*0.02),
                    Container(

                      height: height*0.2,
                      width: width*0.9,
                      child: ListView.builder(
                          itemCount: temp.length,
                          scrollDirection: Axis.horizontal,

                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: Card(
                                elevation: 05.0,
                                color: Colors.transparent,

                                child: Container(


                                  decoration: BoxDecoration(
                                    color: concolor(temp[index]),
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),

                                  ),
                                  width: width * 0.3,


                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Text(day[(index/3).floor()],
                                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: width*0.053,color: Colors.white),
                                            ),

                                            SizedBox(height: height*0.02,),

                                            Icon(Icons.water_drop,
                                              color: Colors.blue,
                                            size: height*0.05,),

                                            SizedBox(height: height*0.02,),

                                            Text(temp[index].toString(),
                                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: width*0.053,color: Colors.white),
                                          )],
                                        ),
                                      )
                                  ),

                                ),
                              ),
                            );

                          }

                      ),
                    ),
                    SizedBox(height: height*0.06),
                    Align(
                      child: Padding(
                        padding:  EdgeInsets.only(left:width*0.05),
                        child: Text("Additional Information",
                          style: TextStyle(fontSize: width*0.06,color: Colors.black54, fontWeight: FontWeight.w800),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Divider(
                      thickness: height*0.001,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height*0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left:width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('Visibility', style: titlefont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text('Pressure', style: titlefont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text('Min Temp', style: titlefont,)
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(((snapshot.data!.visibility)!/1000).toString()+" KM", style: infofont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text(snapshot.data!.main!.pressure.toString(), style: infofont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text(snapshot.data!.main!.tempMin.toString(), style: infofont,)
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('Humidity', style: titlefont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text('Feels Like', style: titlefont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text('Max Temp', style: titlefont,)
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:width*0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(snapshot.data!.main!.humidity.toString()+"%", style: infofont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text(snapshot.data!.main!.feelsLike.toString(), style: infofont,),
                              SizedBox(
                                height: height*0.01,
                              ),
                              Text(snapshot.data!.main!.tempMax.toString(), style: infofont,)
                            ],
                          ),
                        ),
                      ],

                    )

                  ],
                )
            );
          }
          else{
            return Text('Loading');
          }
        }
    );
  }
}
Color concolor(double a)
{
  final container_color=[Color.fromRGBO(0, 0, 139, 0.7),Colors.lightBlue,Colors.amber,Colors.orange,Colors.deepOrange,Colors.red];
  int i;
  if(a<15.0)
  {
    i=0;
  }
  else if(a>=15.0 && a<20.0)
  {
    i=1;
  }
  else if(a>=20.0 && a<25.0)
  {
    i=2;
  }
  else if(a>=25.0 && a<30.0)
  {
    i=3;
  }
  else if(a>=30.0 && a<35)
  {
    i=4;
  }
  else
  {
    i=5;
  }
  return container_color[i];
}