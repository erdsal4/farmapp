import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/Site.dart';
import '../providers/User.dart';
import '../providers/SiteProvider.dart';

class SiteSelection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Text("Select a site", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
            SizedBox(height: 15),
            MyDropdown()          
          ]
        )
      );
    
    }
  
  }
  
class MyDropdown extends StatefulWidget {
  MyDropdown({Key key}) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}
  

class _MyDropdownState extends State<MyDropdown> {

  Site selectedSite;
  List<Site> allSites;
  SiteLoadingStatus status;  
  
  @override
  void initState() {

    final token = Provider.of<User>(context, listen: false).token;
    final sites = Provider.of<SiteProvider>(context, listen:false);
    sites.fetchSites(token);
    print("initstate");

    super.initState();
  }

  @override    
  void didChangeDependencies() async {

    final provider = Provider.of<SiteProvider>(context, listen:true);
    allSites = provider.sites;
    status = provider.status;
    print("heredidchange");
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {
    print("herebuild");
    final user = Provider.of<User>(context, listen: false);    
    if(status == SiteLoadingStatus.Loading){
      return Column(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ]
          );
        }
    else if(status == SiteLoadingStatus.Loaded){
      return Container(
        width: 300.0,
        decoration: BoxDecoration(
          border: Border.all(width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<Site>(
              icon: Icon(Icons.arrow_downward),
              iconSize: 16,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              value: selectedSite,
              onChanged: (Site newSite) {
                user.siteN = newSite.name;
                setState(() {
                    selectedSite = newSite;
                });
                
              },
              items: allSites.map<DropdownMenuItem<Site>>((Site site) {
                  return DropdownMenuItem<Site>(
                    value: site,
                    child: Text(site.name, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
                  );
              }).toList(),
              hint: Text('Select Site')
            )
          )
        )
      ); 
    } else{
      return Text("there was an error");
    } 
  }
}       
    
    /*
    return FutureBuilder<List<Site>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Site>> snapshot) {
        if(snapshot.hasData) {
          return Container(
            width: 300.0,
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Site>(
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 16,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  value: selectedSite,
                  onChanged: (Site newSite) {
                    setState(() {
                        selectedSite = newSite;
                    });
                    
                  },
                  items: snapshot.data.map<DropdownMenuItem<Site>>((Site site) {
                      return DropdownMenuItem<Site>(
                        value: site,
                        child: Text(site.name, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5)),
                      );
                  }).toList(),
                  hint: Text('Select Site')
                )
              )
            )
          ); 
        } else if (snapshot.hasError) {
          return Text("there was an error");
          
        } else {
          return Column(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ]
          );
        }
      }
    );
*/


   

