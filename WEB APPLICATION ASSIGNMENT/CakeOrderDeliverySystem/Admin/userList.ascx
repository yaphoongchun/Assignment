<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="userList.ascx.cs" Inherits="CakeOrderDeliverySystem.Admin.userList" %>

<div class="table-responsive">
    <asp:GridView ID="UserList1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-hover" OnRowCommand="UserList1_RowCommand" OnSorting="UserList1_Sorting">
        <Columns>

            <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" HeaderStyle-CssClass="border-top-0" ItemStyle-CssClass="txt-oflo">

                <HeaderStyle CssClass="border-top-0"></HeaderStyle>

                <ItemStyle CssClass="txt-oflo"></ItemStyle>
            </asp:BoundField>

            <asp:BoundField DataField="MobileAlias" HeaderText="Contact Num" SortExpression="MobileAlias" ItemStyle-CssClass="txt-oflo" HeaderStyle-CssClass="border-top-0">

                <HeaderStyle CssClass="border-top-0"></HeaderStyle>

                <ItemStyle CssClass="txt-oflo"></ItemStyle>
            </asp:BoundField>

            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-CssClass="txt-oflo">

                <HeaderStyle CssClass="border-top-0"></HeaderStyle>

                <ItemStyle CssClass="txt-oflo"></ItemStyle>
            </asp:BoundField>

            <asp:BoundField DataField="CreateDate" HeaderText="Create Date" SortExpression="CreateDate" ItemStyle-CssClass="txt-oflo" HeaderStyle-CssClass="border-top-0">

                <HeaderStyle CssClass="border-top-0"></HeaderStyle>

                <ItemStyle CssClass="txt-oflo"></ItemStyle>
            </asp:BoundField>

            <asp:TemplateField HeaderText="Status" SortExpression="IsApproved" HeaderStyle-CssClass="border-top-0">
                <ItemTemplate>
                    <asp:Label ID="Span" runat="server" Cssclass='<%# Eval("IsApproved") != null && (bool)Eval("IsApproved") ? "label label-success label-rounded" : "label label-danger label-rounded" %>'>
                        <asp:Label ID="Status" runat="server" Text='<%# Eval("IsApproved") != null && (bool)Eval("IsApproved") ? "Active" : "Inactive" %>'>
                        </asp:Label>
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="border-top-0"></HeaderStyle>
            </asp:TemplateField>

            <asp:TemplateField HeaderStyle-CssClass="border-top-0">
                <ItemTemplate>
                    <asp:Button ID="btnChangeStatus" runat="server" CssClass='<%# Eval("IsApproved") != null && (bool)Eval("IsApproved") ? "btn btn-secondary text-white" : "btn btn-info text-white" %>' Text='<%# Eval("IsApproved") != null && (bool)Eval("IsApproved") ? "Inactive" : "Active" %>' CommandName="ChangeStatus" CommandArgument='<%# Container.DataItemIndex %>' ></asp:Button>
                </ItemTemplate>
                <HeaderStyle CssClass="border-top-0"></HeaderStyle>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OnlineCakeDeliverySystem %>" SelectCommand="SELECT aspnet_Users.UserName, aspnet_Users.MobileAlias, aspnet_Membership.Email, aspnet_Membership.CreateDate, aspnet_Membership.IsApproved FROM aspnet_Membership INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId INNER JOIN aspnet_UsersInRoles ON aspnet_Membership.UserId = aspnet_UsersInRoles.UserId AND aspnet_Users.UserId = aspnet_UsersInRoles.UserId WHERE aspnet_UsersInRoles.RoleId = @roleId">
    <SelectParameters>
        <asp:ControlParameter ControlID="roleId" Name="roleId" PropertyName="Text" />
    </SelectParameters>
    </asp:SqlDataSource>
</div>

<asp:Label ID="roleId" runat="server" Visible="false"></asp:Label>