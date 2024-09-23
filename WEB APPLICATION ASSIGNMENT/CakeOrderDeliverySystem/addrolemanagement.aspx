<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addrolemanagement.aspx.cs" Inherits="CakeOrderDeliverySystem.addrolemanagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Role<br />
            <asp:TextBox ID="txtRole" runat="server"></asp:TextBox>
            <asp:Button ID="btnInsertRole" runat="server" OnClick="btnInsertRole_Click" Text="Insert Role" />
            <br />
            <br />
            Role List<br />
            <asp:ListBox ID="lbxRole" runat="server"></asp:ListBox>
            <br />
            <br />
            User List<br />
            <asp:ListBox ID="lbxUser" runat="server"></asp:ListBox>
            <br />
            <br />
            <asp:Button ID="btnAssignRole" runat="server" Text="Assign Role to User"  />
            <br />
            <br />
            Role&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="ddlRole" runat="server">
            </asp:DropDownList>
&nbsp;<asp:Button ID="btnGetUser" runat="server" Text="Get User"  style="height: 28px" />
            <br />
            <br />
            User-Role List:<br />
            <asp:ListBox ID="lbxUserRole" runat="server" AutoPostBack="True"></asp:ListBox>
        </div>
    </form>
</body>
</html>
