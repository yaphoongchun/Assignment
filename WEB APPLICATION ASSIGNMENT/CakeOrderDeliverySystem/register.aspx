<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="CakeOrderDeliverySystem.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 28px;
        }

        table {
            width: 100% !important;
        }

        label {
            display: inline;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="limiter">
        <div class="container-login100" style="background-image: url('img/error-bg.jpg');">
            <div class="wrap-login100">

                <form id="form1" runat="server">

                    <span class="login100-form-logo">
                        <img style="width:95px;" src="img/account-image2.png" />
                    </span>

                    <span class="login100-form-title p-b-34 p-t-27">
                        <label style="color: deeppink;"><b>Register</b></label>
                    </span>

                    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" Width="497px">
                        <WizardSteps>
                            <asp:CreateUserWizardStep runat="server">
                                <ContentTemplate>

                                    <table>
                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Username</b></label>
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="UserName" runat="server" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Name</b></label>
                                                    <asp:RequiredFieldValidator ID="NameRequired" runat="server" ControlToValidate="Name" ErrorMessage="Name is required." ToolTip="UName is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="Name" runat="server" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Password</b></label>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Confirm Password</b></label>
                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Email</b></label>
                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="Email" runat="server" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>


                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Contact Number</b></label>
                                                    <asp:RequiredFieldValidator ID="MobileRequired" runat="server" ControlToValidate="Mobile" ErrorMessage="Contact Number is required to fill." ToolTip="Contact Number is required to fill." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="Mobile" runat="server" CssClass="input100"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2">
                                                <div class="wrap-input100">
                                                    <label style="color: deeppink; font-size: 1.2rem;"><b>Date of Birth</b></label>
                                                    <asp:RequiredFieldValidator ID="DateBirthRequired" runat="server" ControlToValidate="DateBirth" ErrorMessage="Date Birth required to fill." ToolTip="Date Birth required to fill." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="DateBirth" runat="server" CssClass="input100" TextMode="Date"></asp:TextBox>
                                                    <span class="focus-input100"></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="auto-style2">
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="color: Red;" class="auto-style2">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>

                                    <div class="auto-style4 p-t-20 p-b-30 text-center">
                                        Already have account?
					            	<a class="txt1" href="login.aspx">Click here to Login
                                    </a>
                                    </div>

                                </ContentTemplate>

                                <CustomNavigationTemplate>

                                    <div class="container-login100-form-btn">
                                        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Sign Up" ValidationGroup="CreateUserWizard1" CssClass="login100-form-btn" />
                                    </div>

                                </CustomNavigationTemplate>


                            </asp:CreateUserWizardStep>


                            <asp:CompleteWizardStep runat="server">
                                <ContentTemplate>
                                    <table style="font-size: 100%; width: 497px;">
                                        <tr>
                                            <td align="center" colspan="2">Successful</td>
                                        </tr>
                                        <tr>
                                            <td align="center">Your account has been successfully created.</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="container-login100-form-btn">
                                                    <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue" Text="Continue" ValidationGroup="Register" CssClass="login100-form-btn" OnClick="ContinueButton_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:CompleteWizardStep>
                        </WizardSteps>
                    </asp:CreateUserWizard>

                </form>
            </div>
        </div>
    </div>

</asp:Content>
