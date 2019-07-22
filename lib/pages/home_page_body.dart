import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_smart_home_app/model/appliance.dart';
import 'package:flutter_smart_home_app/pages/user_profile_page.dart';
import 'package:flutter_smart_home_app/scopedModel/connectedModel.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody(this.model);

  final ApplianceModel model;

  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  Widget _upperContainer() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'July 11 2019',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Hello DeathStroke!',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserProfilePage()));
                },
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  Icons.power,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '7.9',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'kwh',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Text(
                    'Power uses for today',
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _roomCategories() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Text(
              'Bedroom',
              style: TextStyle(
                  color: Color(0xff4e80f3),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 25,
            ),
            _roomLabel(
              'Living Room',
               ),
            SizedBox(
              width: 25,
            ),
            _roomLabel(
              'Study Room',
               ),
            SizedBox(
              width: 25,
            ),
            _roomLabel(
              'Kitchin',
            ),
            SizedBox(
              width: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget _roomLabel(String title){
    return Text(
              'Kitchin',
              style: TextStyle(
                  color: Color(0xffb2b0b9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            );
  }

  Widget _buildApplianceCard(ApplianceModel model, int index) {
    return Container(
      height: 220,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: index % 2 == 0
          ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
          : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 10, offset: Offset(0, 10), color: Color(0xfff1f0f2))
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: model.allYatch[index].isEnable
                  ? [Color(0xff669df4), Color(0xff4e80f3)]
                  : [Colors.white, Colors.white]),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(model.allYatch[index].leftIcon,
                  color: model.allYatch[index].isEnable
                      ? Colors.white
                      : Color(0xffa3a3a3)),
              Switch(
                  value: model.allYatch[index].isEnable,
                  activeColor: Color(0xff457be4),
                  onChanged: (_) {
                    setState(() {
                      model.allYatch[index].isEnable =
                          !model.allYatch[index].isEnable;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 46,
          ),
          Text(
            model.allYatch[index].title,
            style: TextStyle(
                color: model.allYatch[index].isEnable
                    ? Colors.white
                    : Color(0xff302e45),
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
          Text(
            model.allYatch[index].subtitle,
            style: TextStyle(
                color: model.allYatch[index].isEnable
                    ? Colors.white
                    : Color(0xffa3a3a3),
                fontSize: 20),
          ),
          // Icon(model.allYatch[index].topRightIcon,color:model.allYatch[index].isEnable ? Colors.white : Color(0xffa3a3a3))
        ],
      ),
    );
  }

  Widget _applianceGrid(ApplianceModel model) {
    return Container(
        alignment: Alignment.topCenter,
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        height: 487,
        child: GridView.count(
          // mainAxisSpacing: 10,
          // crossAxisSpacing: 10,
          crossAxisCount: 2,
          padding: EdgeInsets.all(0),
          children: List.generate(model.allYatch.length, (index) {
            return model.allYatch[index].title != null
                ? _buildApplianceCard(model, index)
                : Container(
                    height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    margin: index % 2 == 0
                        ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                        : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(0, 10),
                              color: Color(0xfff1f0f2))
                        ],
                        color: Colors.white,
                        border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Color(0xffa3a3a3)),
                        borderRadius: BorderRadius.circular(20)),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  );
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 258,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 50,
            bottom: 30,
            left: 30,
            right: 30.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff669df4), Color(0xff4e80f3)]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: _upperContainer(),
      ),
      _roomCategories(),
      _applianceGrid(widget.model)
    ]);
  }
}
