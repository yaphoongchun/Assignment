<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="customerProfileHistory.aspx.cs" Inherits="CakeOrderDeliverySystem.Customer.customerProfileHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="section profile">
        <form id="changePasswordForm" runat="server">
            <br />
            <div class="row">
                <div class="col-xl-4">

                    <div style="margin-bottom: 500px;" class="card">
                        <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                            <img src="../img/client/StupidClient.jpg" alt="Profile" class="rounded-circle">
                            <h2>
                                <asp:Label ID="lblSecondCustomerName" runat="server" Text=""></asp:Label>
                            </h2>
                            <div class="social-links mt-2">
                                <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
                                <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
                                <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
                                <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-xl-8">

                    <div class="card mx-auto">
                        <!-- Add mx-auto class to center content -->
                        <div class="card-body pt-3">
                            <!-- Bordered Tabs -->
                            <ul class="nav nav-tabs nav-tabs-bordered">

                                <li class="nav-item">
                                    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                                </li>

                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                                </li>

                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                                </li>

                            </ul>
                            <div class="tab-content pt-2">
                                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                    <!-- Profile Details -->
                                    <div class="profile-details">
                                        <h5 class="card-title">Profile Details</h5>
                                        <div class="row mb-3">
                                            <div class="col-lg-4 col-md-6 label">Full Name</div>
                                            <div class="col-lg-8 col-md-6">
                                                <asp:Label ID="lblCustomerName" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-lg-4 col-md-6 label">Last Login Date</div>
                                            <div class="col-lg-8 col-md-6">
                                                <asp:Label ID="lblLastLoginDate" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-lg-4 col-md-6 label">Phone</div>
                                            <div class="col-lg-8 col-md-6">
                                                <asp:Label ID="lblMobileAlias" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-lg-4 col-md-6 label">Email</div>
                                            <div class="col-lg-8 col-md-6">
                                                <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                                    <!-- Profile Edit Form -->
                                    <div class="row mb-3">
                                        <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Name</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="fullNameTextBox" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="Phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="phoneTextBox" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="emailTextBox" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="SaveChangesButton_Click" OnClientClick="return validateForm();" />
                                    </div>
                                    <!-- End Profile Edit Form -->
                                </div>


                                <div class="tab-pane fade pt-3" id="profile-settings">
                                </div>

                                <div class="tab-pane fade pt-3" id="profile-change-password">
                                    <div class="row mb-3">
                                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="currentPasswordTextBox" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="newPasswordTextBox" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <asp:TextBox ID="confirmPasswordTextBox" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <asp:Button ID="changePasswordButton" runat="server" Text="Change Password" CssClass="btn btn-primary" OnClick="ChangePasswordButton_Click" OnClientClick="return validatePassword();" />
                                    </div>
                                </div>

                            </div>
                            <!-- End Bordered Tabs -->
                        </div>
                    </div>
                </div>

            </div>
        </form>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <!-- Include SweetAlert library -->

        <script>
            function validateForm() {
                var isValid = true;

                // Name validation
                var fullName = document.getElementById('<%= fullNameTextBox.ClientID %>').value;
        if (!fullName.match(/^[a-zA-Z\s]+$/)) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Input',
                text: 'Name must contain only alphabets.'
            });
            isValid = false;
        }

        // Phone validation
        var phone = document.getElementById('<%= phoneTextBox.ClientID %>').value;
        if (!phone.match(/^0[0-9]{9,10}$/)) {
            Swal.fire({
                icon: 'error',
                title: 'Invalid Input',
                text: 'Phone number must start with 0 and be 10 or 11 digits long.'
            });
            isValid = false;
        }

        // Email validation
        var email = document.getElementById('<%= emailTextBox.ClientID %>').value;
                if (!email.match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Input',
                        text: 'Invalid email address.'
                    });
                    isValid = false;
                }

                return isValid;
            }

            function validatePassword() {
                var currentPassword = document.getElementById('<%= currentPasswordTextBox.ClientID %>').value;
    var newPassword = document.getElementById('<%= newPasswordTextBox.ClientID %>').value;
                var confirmPassword = document.getElementById('<%= confirmPasswordTextBox.ClientID %>').value;

                // Check if current password is the same as new password
                if (currentPassword === newPassword) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Current and New Passwords Match',
                        text: 'New password must be different from the current password.'
                    });
                    return false;
                }

                // Password validation
                if (!newPassword.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Password',
                        text: 'Password must be at least 8 characters long and contain at least one digit, one lowercase letter, one uppercase letter, and one special character (!@#$%^&*).'
                    });
                    return false;
                }

                // Check if the new password matches the confirm password
                if (newPassword !== confirmPassword) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Passwords Do Not Match',
                        text: 'New password and confirm password do not match.'
                    });
                    return false;
                }

                return true;
            }
        </script>

    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
