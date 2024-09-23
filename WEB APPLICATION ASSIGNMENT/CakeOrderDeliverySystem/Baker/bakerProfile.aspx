<%@ Page Title="" Language="C#" MasterPageFile="~/Baker/bakerHeader.Master" AutoEventWireup="true" CodeBehind="bakerProfile.aspx.cs" Inherits="CakeOrderDeliverySystem.Baker.bakerProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bakerContent" runat="server">
    <div class="container-fluid">
        <form runat="server" id="form1">
            <asp:HiddenField ID="userid" runat="server" />
<asp:FormView ID="FormViewBakerProfile" runat="server" DefaultMode="Edit" CssClass="auto-style1">
    <EditItemTemplate>
        <div class="row">
            <!-- Column -->
            <div class="col-lg-8 col-xlg-9">
                <div class="card">
                    <div class="card-body">
                      <center class="mt-4">
                          <img src="../img/client/StupidClient.jpg" class="rounded-circle" width="150" />
                            <h4 class="card-title mt-2">
                            <asp:Label ID="Label1" runat="server" Text='<%#Bind("UserName") %>'></asp:Label></h4>
                        </center>
                      </div>
                    <div class="card-body">
                        <form class="form-horizontal form-material mx-2">
                            <div class="form-group">
                                <label for="example-username" class="col-md-12">Username</label>
                                <div class="col-md-12">
                                    <asp:TextBox ID="username" runat="server" CssClass="form-control form-control-line" Text='<%# Bind("UserName") %>' ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="example-email" class="col-md-12">Email</label>
                                <div class="col-md-12">
                                    <asp:TextBox ID="email" runat="server" CssClass="form-control form-control-line" Text='<%# Bind("Email") %>'></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="example-password" class="col-md-12">Password</label>
                                <div class="col-md-12">
                                    <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="form-control form-control-line"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-success text-white" OnClick="btnUpdateBaker_Click" />
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
        </form>
    </div>
    <asp:SqlDataSource ID="userProfile" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="SELECT * FROM vw_aspnet_MembershipUsers INNER JOIN Baker ON Baker.bakerID = vw_aspnet_MembershipUsers.UserId WHERE UserId = @Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="userid" Name="Id" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>