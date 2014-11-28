<%@ Page Title="Courts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courts.aspx.cs" Inherits="TCCONE.Courts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %></h1>
        <h2>Réservation des courts</h2>
    </hgroup>
    <section class="contact">
        <header>
            <h3>Tableau de réservations :</h3>
        </header>
        <asp:Table ID="tblLanguages" runat="server">
        </asp:Table>
        <div ID="messageBox" runat="server"><span id="messageText" runat="server"></span></div>
        Jour : <asp:TextBox ID="Day" runat="server"></asp:TextBox><br />
        Heure : <asp:TextBox ID="Hour" runat="server"></asp:TextBox><br />
        Nom : <asp:TextBox ID="Name" runat="server"></asp:TextBox><br />
        <asp:Button ID="Add" runat="server" Text="Ajouter" OnClick="Add_Click" />
        <asp:Button ID="Delete" runat="server" Text="Supprimer" OnClick="Delete_Click" />
    </section>
</asp:Content>
