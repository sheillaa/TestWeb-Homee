﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rumah.aspx.cs" Inherits="TestWeb_Homee.Rumah" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- BING MAPS Control -->
    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.3"></script>

    <script>
      $( function() {
          var kota = <%=JavaScript.Serialize(this.kota) %>;
        $("#alamat" ).autocomplete({
            source: kota,
            select: function (a, b) {
                changeMapByAddress(b.item.value);
            }
        });
      } );
    </script>

    <script type="text/javascript">
        var myMap = null;         

         function LoadMap()
         {
             myMap = new VEMap("mapDiv");
             myMap.LoadMap();
         }

         function UnloadMap()
         {
             if (myMap != null) {
                 myMap.Dispose();
             }
         }
         function StartGeocoding( address )
          {
              myMap.Find(null,    // what
                         address, // where
                         null,    // VEFindType (always VEFindType.Businesses)
                         null,    // VEShapeLayer (base by default)
                         null,    // start index for results (0 by default)
                         null,    // max number of results (default is 10)
                         null,    // show results? (default is true)
                         null,    // create pushpin for what results? (ignored since what is null)
                         null,    // use default disambiguation? (default is true)
                         null,    // set best map view? (default is true)
                         GeocodeCallback);  // call back function
          }
          function GeocodeCallback (shapeLayer, findResults, places, moreResults, errorMsg)
          {
              // if there are no results, display any error message and return
              if(places == null)
              {
                  alert( (errorMsg == null) ? "There were no results" : errorMsg );
                  return;
              }

              var bestPlace = places[0];

              // Add pushpin to the *best* place
              var location = bestPlace.LatLong;

              var newShape = new VEShape(VEShapeType.Pushpin, location);
              var desc = "Latitude: " + location.Latitude + "<br>Longitude:" + location.Longitude;
              newShape.SetDescription(desc);
              newShape.SetTitle(bestPlace.Name);
              myMap.AddShape(newShape);
              
              document.getElementById("latitude").value = location.Latitude;
              document.getElementById("longitude").value = location.Longitude;
          }
          function changeMapByAddress(address){
              myMap.Clear();
              StartGeocoding(address);
          }
      </script>
    <style>
        table tr td{
            padding:5px;
        }
    </style>
</head>
<body onload="LoadMap()" onunload="UnloadMap()">
    <form id="form1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3 class="text-center">Form Input Data Rumah</h3>
                <div class="row">
                    <div class="col-md-6">
                        
                        <table>
                            <tr>
                                <td>Tipe</td>
                                <td><asp:DropDownList ID="tipe" runat="server" Width="50">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td>Alamat</td>
                                <td><asp:TextBox ID="alamat" runat="server" onchange="javascript: changeMapByAddress(this.value);" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Latitude/Longitude</td>
                                <td><asp:TextBox ID="latitude" runat="server"></asp:TextBox>
                                    &nbsp;/&nbsp;
                                    <asp:TextBox ID="longitude" runat="server"></asp:TextBox> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><asp:Button ID="btnSubmit" runat="server" Text="Simpan" OnClick="btnSave_Click"  class="btn btn-primary"/>
                                    <a href="/Detail.aspx"><i class="glyphicon glyphicon-map-marker"></i>&nbsp;Lihat Lokasi Rumah</a>
                                </td>
                            </tr>
                        </table>
                        
                        <asp:GridView ID="GridListRumah" runat="server" DataKeyNames="id" class="table table-striped">
                        </asp:GridView>
                    </div>
                    <div class="col-md-6"><div style="position:relative;width:400px;height:400px;" id="mapDiv"></div></div>
                </div>
            
            </div>
        </div>
    </div>
    </form>
</body>
</html>
