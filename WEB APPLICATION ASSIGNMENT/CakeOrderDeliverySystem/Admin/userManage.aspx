<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/adminHeader.Master" AutoEventWireup="true" CodeBehind="userManage.aspx.cs" Inherits="CakeOrderDeliverySystem.Admin.userManage" %>

<%@ Register Src="~/Admin/adminList.ascx" TagPrefix="uc1" TagName="adminList" %>
<%@ Register Src="~/Admin/bakerList.ascx" TagPrefix="uc1" TagName="bakerList" %>
<%@ Register Src="~/Admin/userList.ascx" TagPrefix="uc1" TagName="userList" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="adminContent" runat="server">
    <form id="form2" runat="server">
   <div class="container-fluid">
   <br />       
   <h1>User Management</h1>
   <div class="row">
      <div class="col-md-5">

         <div class="card">
            <div class="card-body">
               <div class="row">
                  <div class="col">
                     <center>
                        <h4>User Details</h4>
                     </center>
                  </div>
               </div>
               <div class="row">
                  <div class="col">
                     <center>
                        <img style="width:90px;" src="../img/client/StupidClient.jpg" class="rounded-circle"/>
                     </center>
                  </div>
               </div>
               <div class="row">
                  <div class="col">
                     <hr>
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-6">
                     <label>Username</label>
                     <div class="form-group">
                        <div class="input-group">
                           <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server" placeholder="Username"></asp:TextBox>
                           <asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server"><i class="fa fa-check-circle-o"></i></asp:LinkButton>
                        </div>
                     </div>
                  </div>
                
                  <div class="col-md-6">
                     <label>Active Status</label>
                     <div class="form-group">
                        <div class="input-group">
                           <asp:DropDownList CssClass="form-control mr-1" ID="StatusDropDown" runat="server">
                               <asp:ListItem Text="Active" Value="true"></asp:ListItem>
                               <asp:ListItem Text="Inactive" Value="false"></asp:ListItem>
                           </asp:DropDownList>
                        </div>
                     </div>
                  </div>
               </div>
               <br />
             
                  
               <div class="row">
                  <div class="col-8 mx-auto">
                    <br />
                    <br />
                    <center>
                    <asp:Button ID="Button2" CssClass="adminbtn" runat="server" Text="Update User" />
                    </center>
                      <br />
                      <br />
                  </div>
               </div>
            </div>
         </div>
         <br>
      </div>
      <div class="col-md-7">
         <div class="card">
            <div class="card-body">
               <div class="row">
                  <div class="col">
                     <center>
                        <h4>User List</h4>
                     </center>
                  </div>
               </div>
               <div class="row">
                  <div class="col">
                     <hr>
                  </div>
               </div>
               <%--<div class="row">
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" SelectCommand="SELECT aspnet_Users.UserName, aspnet_Membership.Email, aspnet_Users.MobileAlias, aspnet_Membership.CreateDate, aspnet_Membership.LastLoginDate FROM aspnet_Membership INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId"></asp:SqlDataSource>

    <div class="col">
        <table id="myTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Mobile Contact</th>
                    <th>Created Date</th>
                    <th>Last Login Date</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("UserName") %></td>
                            <td><%# Eval("Email") %></td>
                            <td><%# Eval("MobileAlias") %></td>
                            <td><%# Eval("CreateDate") %></td>
                            <td><%# Eval("LastLoginDate") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    </div>--%>

        <div class="row">
            <div class="col">
                <ul class="nav nav-tabs" role="tablist">

                            <li class="nav-item" role="presentation">
                                <a class="nav-link active" data-bs-toggle="tab" href="#admin" aria-selected="false" tabindex="-1" role="tab">Admin</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" data-bs-toggle="tab" href="#baker" aria-selected="false" tabindex="-1" role="tab">Baker</a>
                            </li>     
                            <li class="nav-item" role="presentation">
                                <a class="nav-link" data-bs-toggle="tab" href="#customer" aria-selected="true" role="tab">Customer</a>
                            </li>
                 </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade show active" id="admin" role="tabpanel">
                        <uc1:adminList runat="server" id="adminList" />
                    </div>
                    <div class="tab-pane fade" id="baker" role="tabpanel">
                        <uc1:bakerList runat="server" id="bakerList" />
                    </div>
                    <div class="tab-pane fade" id="customer" role="tabpanel">
                        <uc1:userList runat="server" id="userList" />
                    </div>
                </div>
            </div>
        </div>




            </div>
         </div>
      </div>
   </div>
     <%-- stop --%>

</div>
</form>
</asp:Content>
