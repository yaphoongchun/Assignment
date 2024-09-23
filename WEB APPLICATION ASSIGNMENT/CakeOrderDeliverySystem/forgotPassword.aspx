<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="forgotPassword.aspx.cs" Inherits="CakeOrderDeliverySystem.forgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="limiter">
            <div class="container-login100" style="background-image: url('../img/breadpattern.png');">
                <div class="wrap-login100">

                    <div class="row">
                        <div class="col">
                            <center>
                                <br />
                                <h4 style="color: deeppink;"><b>Forgot Password?</b></h4>
                                <br />
                                <div style="color: black;">
                                    <p><b>No worries. Just enter your email here:</b></p>
                                </div>
                            </center>
                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="col">
                            <label class="font-weight-bold" style="color: deeppink;">Email</label>
                            <div class="form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="email" placeholder="Email" TextMode="Email"></asp:TextBox>

                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col">

                            <center>
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="login100-form-btn" ID="forgotbtn" Text="Submit" OnClick="forgotbtn_Click" />
                                </div>
                                <br />
                                <br />
                                <asp:Label ID="lblErrorMsg" runat="server" Text=""></asp:Label>
                            </center>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </form>
</asp:Content>
