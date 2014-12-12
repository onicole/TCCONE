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
    <asp:Label ID="Firstname" runat="server" Text="Firstname"></asp:Label>
    <asp:TextBox ID="Firstname_TextBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator id="Validator1" runat="server" ControlToValidate="Firstname_TextBox" ErrorMessage="*First name is a required field." ForeColor="Red"></asp:RequiredFieldValidator>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="Lastname" runat="server" Text="Lastname"></asp:Label>
    <asp:TextBox ID="Lastname_TextBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator id="Validator2" runat="server" ControlToValidate="Lastname_TextBox" ErrorMessage="*Last name is a required field." ForeColor="Red"></asp:RequiredFieldValidator>
    </td>
        </tr>
    <tr>
    <td>
    <asp:Label ID="Address1" runat="server" Text="Address1"></asp:Label>
    <asp:TextBox ID="Address1_TextBox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator id="Validator3" runat="server" ControlToValidate="Address1_TextBox" ErrorMessage="*Address1 is a required field." ForeColor="Red"></asp:RequiredFieldValidator>
    </td>
        </tr>
    <tr>
    <td>
    <asp:Label ID="Address2" runat="server" Text="Address2"></asp:Label>
    <asp:TextBox ID="Address2_TextBox" runat="server"></asp:TextBox>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="NPA" runat="server" Text="NPA"></asp:Label>
    <asp:TextBox ID="NPA_TextBox" runat="server"></asp:TextBox>
    <asp:Label ID="Ville" runat="server" Text="Ville"></asp:Label>
    <asp:TextBox ID="Ville_TextBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator id="Validator4" runat="server" ControlToValidate="NPA_TextBox" ErrorMessage="*NPA is a required field." ForeColor="Red"></asp:RequiredFieldValidator>
    </td>
    </tr>
     <tr>
    <td>
    <asp:Label ID="Phone" runat="server" Text="Phone"></asp:Label>
    <asp:TextBox ID="Phone_TextBox" runat="server"></asp:TextBox>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="Email" runat="server" Text="Email"></asp:Label>
    <asp:TextBox ID="Email_TextBox" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator id="Validator5" runat="server" ControlToValidate="Email_TextBox" ErrorMessage="*Last name is a required field." ForeColor="Red"></asp:RequiredFieldValidator>
    </td>
    </tr>
    </table>
    <asp:Button ID="btnsubmit" runat="server" Text="Modifier" OnClick="btnsubmit_Click" />
    </div>
</asp:Content>
