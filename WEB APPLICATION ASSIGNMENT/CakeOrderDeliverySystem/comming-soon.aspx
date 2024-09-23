<%@ Page Title="" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="comming-soon.aspx.cs" Inherits="CakeOrderDeliverySystem.comming_soon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
    var countDownDate = new Date("Mar 31, 2024 00:00:00").getTime();

    var x = setInterval(function() {
    
        var now = new Date().getTime();
        var distance = countDownDate - now;
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    
        document.getElementById("clockdiv").innerHTML = "<div class='counter-item'><span class='days'>" + days + "</span><div class='smalltext'>Days</div></div>" +
            "<div class='counter-item'><span class='hours'>" + hours + "</span><div class='smalltext'>Hours</div></div>" +
            "<div class='counter-item'><span class='minutes'>" + minutes + "</span><div class='smalltext'>Minutes</div></div>" +
            "<div class='counter-item'><span class='seconds'>" + seconds + "</span><div class='smalltext'>Seconds</div></div>";
    
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("clockdiv").innerHTML = "EXPIRED";
        }
    }, 1000);
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--================Comming Soon Area =================-->
    <section class="coming_soon_area">
        <div class="coming_soon">
            <div class="welcome-text-area">
                <div class="container">
                    <h2 class="coming-header">Comming Soon</h2>
                    <div id="clockdiv" class="coming_soon_counter">
                        <div class="counter-item">
                            <span class="days"></span>
                            <div class="smalltext">Days</div>
                        </div>
                        <div class="counter-item">
                            <span class="hours"></span>
                            <div class="smalltext">Hours</div>
                        </div>
                        <div class="counter-item">
                            <span class="minutes"></span>
                            <div class="smalltext">Minutes</div>
                        </div>
                        <div class="counter-item">
                            <span class="seconds"></span>
                            <div class="smalltext">Seconds</div>
                        </div>
                    </div>
                    <p>Website is under construction. We'll be here soon with new<br> awesome site, Subscribe to be notified.</p>
                </div>
            </div>
        </div>
    </section>
    <!--================End Footer Area =================-->
</asp:Content>
