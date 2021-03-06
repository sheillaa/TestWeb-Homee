﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="TestWeb_Homee.Detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script type="text/javascript">

        var map = null;
        var pinLatitude = <%=JavaScript.Serialize(this.pinLat) %>;
        var pinLogitude = <%=JavaScript.Serialize(this.pinLong) %>;

      function GetMap()
      {  

          map = new Microsoft.Maps.Map(document.getElementById("mapDiv"), { credentials: "tWgpi2HaCXqooP5GHW1b~vn1xeAe1yOew9eEQ4hHQ4w~AvjXYQHCZVkuxT5CKbBmRtYZuqTL2MkDxSJhMqqCZbWG9dAf-7RH5wHcjo9xAXga" });
          setPushpin();
          console.log(pinLatitude);
      }

      function setPushpin(longlat) {
         
          try {
              map.entities.clear();
              var location;
              for (var i = 0; i < pinLatitude.length; i++) {
                  location = new Microsoft.Maps.Location(pinLatitude[i], pinLogitude[i]);
                  var pushpin = new Microsoft.Maps.Pushpin(location,{ draggable: false });
                  pushpin.setOptions({ visible: true });
                  map.entities.push(pushpin);

              }
          }
          catch (err) {
              alert(err)
          }
      }

      </script>

</head>
<body onload="GetMap();">
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <h3 class="text-center"><i class="glyphicon glyphicon-map-marker"></i>&nbsp;Peta Lokasi-Lokasi Rumah</h3>
                <a href="/Rumah.aspx"><i class="glyphicon glyphicon-home"></i>&nbsp;Kembali</a>
                <div id='mapDiv' style="position:relative; width:100%; height:600px;"></div>
            </div>
        </div>
    </div>
</body>
</html>
