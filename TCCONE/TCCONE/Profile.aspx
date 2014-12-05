<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TCCONE.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %></h1>
        <h2>Your app description page.</h2>
    </hgroup>
    <div>
    <table>
    <tr>
    <td>
    <asp:Label ID="UserId" runat="server" Text="UserId"></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="Firstname" runat="server" Text="Firstname"></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </td>
        </tr>
    <tr>
    <td>
    <asp:Label ID="Lastname" runat="server" Text="Lastname"></asp:Label>
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    </td>
        </tr>
    <tr>
    <td>
    <asp:Label ID="UserName" runat="server" Text="UserName"></asp:Label>
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    </td>
        </tr>
    <tr>
    <td>
    <asp:Label ID="Password" runat="server" Text="Password"></asp:Label>
    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="ConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
    </td>
    </tr>
    </table>
    <asp:Button ID="btnsubmit" runat="server" Text="Modifier" OnClick="btnsubmit_Click" />
    </div>
</asp:Content>
