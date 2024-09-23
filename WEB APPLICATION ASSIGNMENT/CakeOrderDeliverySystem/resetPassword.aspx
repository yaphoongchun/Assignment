<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="resetPassword.aspx.cs" Inherits="CakeOrderDeliverySystem.resetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="limiter">
            <div class="container-login100" style="background-image: url('img/breadpattern.png');">
                <div class="wrap-login100">

                    <div class="row">
                        <div class="col">
                            <center>
                                <br />
                                <h4 style="color: deeppink;"><b>Reset Password</b></h4>
                                <br />
                                <div style="color: black;">
                                    <p><b>Please fill in the new password</b></p>
                                </div>
                            </center>
                        </div>
                    </div>
                    <br />

                    <div class="row">

                        <div class="col">
                            <label class="font-weight-bold" style="color: deeppink;">New Password</label>
                            <div class="form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtNewPassword" placeholder="New Password" TextMode="Password" ReadOnly="False"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row">

                        <div class="col">
                            <label class="font-weight-bold" style="color: deeppink;">Confirm New Password</label>
                            <div class="form-group">
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtConfirmPassword" placeholder="New Password" TextMode="Password" ReadOnly="False"></asp:TextBox>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col">

                            <center>
                                <div class="form-group">
                                    <br />
                                    <asp:Button CssClass="login100-form-btn" ID="resetbtn" runat="server" OnClick="resetbtn_Click" Text="Submit" />
                                </div>
                                <asp:Label ID="lblErrorMsg" runat="server" Text=""></asp:Label>
                            </center>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <center>
                                <div class="text-center">
                                    <div style="color: deeppink;">
                                        <b>Already register? </b>
                                        <a class="txt1" href="login.aspx">Click here!</a>
                                    </div>
                                </div>
                            </center>
                        </div>
                    </div>


                </div>
            </div>

        </div>
    </form>
</asp:Content>
