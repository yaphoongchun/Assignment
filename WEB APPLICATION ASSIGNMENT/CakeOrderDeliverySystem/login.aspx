<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="CakeOrderDeliverySystem.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
         <style type="text/css">
        .auto-style1 {
            width: 377px;
        }

        label {
            display:inline;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="limiter">
		<div class="container-login100" style="background-image: url('img/error-bg.jpg');">
			<div class="wrap-login100">

				<form id="form1" runat="server">

					<span class="login100-form-logo">
						<img width="95px" src="img/account-image2.png"/>
					</span>

					<span class="login100-form-title p-b-34 p-t-27">
						<label style="color:deeppink;"><b>Log in</b></label>
					</span>

                    <asp:Login ID="Login1" runat="server" Width="379px" OnLoggedIn="LoginButton_Click">
                        <LayoutTemplate>
                            <table class="auto-style1">
                                <tr>
                                    <td>
                                        <div class="wrap-input100">
                                            <label style="color:deeppink; font-size:1.2rem;"><b>Username</b></label>                                        
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            <asp:TextBox ID="UserName" runat="server" CssClass="input100"></asp:TextBox>
                                            <span class="focus-input100"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="wrap-input100">
                                           <label style="color:deeppink; font-size:1.2rem;"><b>Password</b></label>                                        
										   <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                            <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="input100"></asp:TextBox>
                                            <span class="focus-input100"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox CssClass="input-checkbox100" ID="RememberMe" runat="server" Text="Remember me next time." />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <div class="container-login100-form-btn">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" CssClass="login100-form-btn"/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                    </asp:Login>


					<div class="text-center p-t-90">
						<a class="txt1" href="forgotPassword.aspx">
							Forgot Password?
						</a>
					</div>

					<div class="text-center">
						Haven't register?
						<a class="txt1" href="register.aspx">
							Click here!
						</a>
					</div>
				</form>
			</div>
		</div>
	</div> 
</asp:Content>
