<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="LearnEnglish.Chat.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Q&A CHAT ROOM</title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .content {
            background-color:orange;
            border:thin solid red;

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="auto-style1"><em>Q&amp;A CHAT ROOM</em></h2>
    <div class="content">
        <input type="text" id="message" />
        <input type="button" id="sendmessage" value="Send" />
        <input type="hidden" id="displayname" />
        <br />
        <br />
            <ul id="discussion">
            </ul>
    </div>

    <script src="../Scripts/jquery-1.6.4.min.js"></script>
    <script src="../Scripts/jquery.signalR-2.4.0.min.js"></script>
    <script src="../signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            var chat = $.connection.chatHub;
            chat.client.broadcastMessage = function (name, message) {
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                $('#discussion').append('<li><strong>' + encodedName
                    + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
            };

             var uName = '<%=@HttpContext.Current.User.Identity.Name%>';
            if (uName != "") {
               
                $('#displayname').val(uName);
            }
            else {
                $('#displayname').val(prompt('Enter your name:', ''));
            }
            $('#message').focus();
            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    chat.server.send($('#displayname').val(), $('#message').val());
                    $('#message').val('').focus();
                });
            });
        });
    </script>
    <div style="height: 450px;">

    </div>
</asp:Content>
