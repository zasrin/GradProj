<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SocialTest.aspx.cs" Inherits="SocialTesting.SocialTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://apis.google.com/js/client.js?onload=OnLoadCallback"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
        var clientId = '416591950232-imjssg6nik9782oav5lv3nu9i1ajj6vm.apps.googleusercontent.com';
        var apiKey = 'AIzaSyCm8XJRnOORsqYGuTsWWV8cJ_o3iKzbJJw';
        var scopes = 'https://www.googleapis.com/auth/plus.me';

        function handleClientLoad() {
            gapi.client.setApiKey(apiKey);
            window.setTimeout(checkAuth, 1);
        }

        function checkAuth() {
            gapi.auth.authorize({ client_id: clientId, scope: scopes, immediate: true }, handleAuthResult);
        }

        function handleAuthResult(authResult) {
            //var authorizeButton = document.getElementById('authorize-button');
            if (authResult && !authResult.error) {
                //authorizeButton.style.visibility = 'hidden';
                makeApiCall();
            } else {
                alert("no");
                authorizeButton.style.visibility = '';
                authorizeButton.onclick = handleAuthClick;
            }
        }

        function handleAuthClick(event) {
            gapi.auth.authorize({ client_id: clientId, scope: scopes, immediate: false }, handleAuthResult);
            return false;
        }

        function makeApiCall() {
            gapi.client.load('plus', 'v1', function () {
                var request = gapi.client.plus.people.get({
                    'userId': 'me'
                });
                request.execute(function (resp) {
                    $('body').html('<h1>Data That Will be Written to DB<h1><br/><h2>Display Name: </h2>' + resp.displayName +
                                    '<br/><h2>ID: </h2>' + resp.id +
                                    '<br/><h2>First: </h2>' + resp.name.givenName +
                                    '<br/><h2>Last: </h2>' + resp.name.familyName +
                                    '<br/><h2>Gender: </h2>' + resp.gender +
                                    '<br/><h2>Image URL: </h2>' + resp.image.url);

                });
            });
        }

        function google() {
            handleClientLoad();
            handleAuthClick(null);
        }
    </script> 
    <script>
    // Additional JS functions here
    window.fbAsyncInit = function () {
        FB.init({
            appId: '562289093805700', // App ID
            channelUrl: 'http://localhost:24339/channel.aspx', // Channel File
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true  // parse XFBML
        });

        FB.getLoginStatus(function (response) {
            if (response.status === 'connected') {
                alert('already logged into fb and approved app, auto login ID = ' + resp.authResponse.userID);
            } else if (response.status === 'not_authorized') {
                // not_authorized
            } else {
                // not_logged_in
            }
        });

        // Additional init code here

    };

    // Load the SDK Asynchronously
    (function (d) {
        var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement('script'); js.id = id; js.async = true;
        js.src = "//connect.facebook.net/en_US/all.js";
        ref.parentNode.insertBefore(js, ref);
    }(document));

    function FBlogin() {
        FB.login(function (response) {
            if (response.authResponse) {
                FB.api('/me', function (resp) {
                    $('body').html('<h1>Data That Will be Written to DB<h1><br/><h2>Display Name: </h2>' + resp.name +
                                    '<br/><h2>ID: </h2>' + resp.id +
                                    '<br/><h2>First: </h2>' + resp.first_name +
                                    '<br/><h2>Last: </h2>' + resp.last_name +
                                    '<br/><h2>Gender: </h2>' + resp.gender +
                                    '<br/><h2>Image URL: </h2>' + 'http://graph.facebook.com/' + resp.id + '/picture?type=large');
                });
            } else {
                // cancelled
            }
        });
    }
</script>
</head>
<body id="content">
    <form id="form1" runat="server">
    <div>
        <input type="button" onclick="google();" value="Use Google" />
        <input type="button" onclick="FBlogin();" value="Use Facebook" />
        <div id="fb-root"></div>
    </div>
    </form>
</body>
</html>
