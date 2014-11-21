<%@ Page Title="Accueil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TCCONE._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %> : </h1>
                <h2>
                    <% Welcome(); %>
                    et bienvenue sur le site du Tennis Club Chavornay</h2>
            </hgroup>
            <p>
                Cette application vous permet de réserver les courts de tennis à Chavornay.
            </p>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>Vous n'avez pas de compte ?</h3>
    <ol class="round">
        <li class="one">
            <h5>S'enregistrer</h5>
            Pour commencer, créez vous un compte sur notre site internet !
            <a href="/Account/Register">S'enregistrer</a>
        </li>
        <li class="two">
            <h5>Se connecter</h5>
            Une fois votre compte créé. Connectez-vous pour profiter de notre application !
            <a href="/Account/Login">Connexion</a>
        </li>
        <li class="three">
            <h5>Réserver</h5>
            Maintenant vous pouvez profiter des fonctionnalités de réservation des courts proposée par le tennis club de Chavornay !
        </li>
    </ol>
</asp:Content>
