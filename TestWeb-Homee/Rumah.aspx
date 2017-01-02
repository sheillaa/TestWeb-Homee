<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rumah.aspx.cs" Inherits="TestWeb_Homee.Rumah" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>Tipe</td>
                <td><asp:TextBox ID="tipe" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Alamat</td>
                <td><asp:TextBox ID="alamat" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Latitude/Longitude</td>
                <td><asp:TextBox ID="latitude" runat="server"></asp:TextBox>/<asp:TextBox ID="longitude" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Button ID="btnSubmit" runat="server" Text="Simpan" OnClick="btnSave_Click" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
