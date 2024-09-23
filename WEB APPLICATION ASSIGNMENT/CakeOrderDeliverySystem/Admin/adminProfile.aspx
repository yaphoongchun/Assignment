<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminHeader.Master" AutoEventWireup="true" CodeBehind="adminProfile.aspx.cs" Inherits="CakeOrderDeliverySystem.Admin.adminProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="adminContent" runat="server">
    <form id="form2" runat="server">
    <div class="container-fluid">
        <br />       
        <h1>User Profile</h1>

    <center>
        <asp:HiddenField ID="userid" runat="server" />
            <asp:FormView ID="FormViewAdminProfile" runat="server" DefaultMode="Edit" CssClass="auto-style1">
                <EditItemTemplate>
                    <div class="row">
                        <!-- Column -->
                        <div class="col-md-15">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col">
                                            <center class="mt-4">
                                                <img src="../img/client/StupidClient.jpg"
                                                    class="rounded-circle" width="150" />
                                                <h4 class="card-title mt-2">
                                                    <asp:Label ID="Label3" runat="server" Text='<%#Bind("UserName") %>'></asp:Label></h4>
                                            </center>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                <div class="col">
                                <div>
                                    <hr>
                                </div>
                                </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="card-body">
                                            <small class="text-muted">Email address </small>
                                            <h6>
                                                <asp:Label ID="Label2" runat="server" Text='<%#Bind("Email") %>'></asp:Label></h6>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                     
                        <!-- Column -->
                        <!-- Column -->
                       
                        <div class="col-lg-15">
                            <div class="card">
                                <div class="card-body">         
                                        
                                            <form class="form-horizontal form-material mx-2">
                                                <div class="form-group">
                                                    <label for="example-username" class="col-md-12">Username</label>
                                                    <div class="col-md-12">
                                                        <asp:TextBox ID="username" runat="server" CssClass="form-control form-control-line" Text='<%#Bind("UserName") %>'></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="example-email" class="col-md-12">Email</label>
                                                    <div class="col-md-12">
                                                        <asp:TextBox ID="email" runat="server" CssClass="form-control form-control-line" Text='<%#Bind("Email") %>'></asp:TextBox>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="form-group">
                                                    <div class="col-sm-12">
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="adminbtn" OnClick="btnUpdated_Click" />
                                                    </div>
                                                </div>
                                            </form>
 
                                </div>
                            </div>
                        </div>
                       
                        <!-- Column -->
                    </div>
                </EditItemTemplate>
            </asp:FormView>
        </center>
            <asp:SqlDataSource ID="userProfile" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="Select * From vw_aspnet_MembershipUsers Where UserId = @Id">
                <SelectParameters>
                    <asp:ControlParameter ControlID="userid" Name="Id" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

    </div>
    </form>
</asp:Content>
