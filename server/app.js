var http = require('http');
var express = require('express');
var { RtcTokenBuilder, RtmTokenBuilder, RtcRole, RtmRole } = require('agora-access-token')

var PORT = 3000;

// Fill the appID and appCertificate key given by Agora.io
// These are only for test and doesn't have any value
var appID = "efcf1a8519c042a0ae9ea0417c608c6e";
var appCertificate = "640afced84b84159b2a280c7cb0df8d1";

// token expire time, hardcode to 3600 seconds = 1 hour
var expirationTimeInSeconds = 3600
var role = RtcRole.PUBLISHER

var app = express();
app.disable('x-powered-by');
app.set('port', PORT);
app.use(express.favicon());
app.use(app.router);

const channels = [];

function addChannelToken(channelName, token) {
    let index = -1;

    index = channels.findIndex((channel) => channel.name == channelName);

    if (index == -1) {
        channels.push({ token, name: channelName });
    }
    else {
        channels[index].token = token;
    }
}

function findChannelToken(channelName) {
    index = channels.findIndex((channel) => channel.name == channelName);

    if (index == -1) {
        return null;
    }
    else {
        return channels[index].token;
    }
}

var generateRtcToken = function (req, resp) {
    var currentTimestamp = Math.floor(Date.now() / 1000)
    var privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds
    var channelName = req.query.channelName;
    // use 0 if uid is not specified
    var uid = req.query.uid || 0
    if (!channelName) {
        return resp.status(400).json({ 'error': 'channel name is required' }).send();
    }


    var key = RtcTokenBuilder.buildTokenWithUid(appID, appCertificate, channelName, uid, role, privilegeExpiredTs);
    addChannelToken(channelName, key);

    resp.header("Access-Control-Allow-Origin", "*")

    return resp.json({ 'key': key }).send();
};

var getToken = function (req, resp) {
    var currentTimestamp = Math.floor(Date.now() / 1000)
    var privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds
    var channelName = req.query.channelName;
    if (!channelName) {
        return resp.status(400).json({ 'error': 'channel name is required' }).send();
    }

    var key = findChannelToken(channelName);

    resp.header("Access-Control-Allow-Origin", "*")

    if (key) {
        return resp.json({ 'key': key }).send();
    }
    else {
        resp.status(400).json({ 'error': 'channel dosen\'t found.' }).send();
    }
};

app.get('/rtcToken', generateRtcToken);
app.get('/getToken', getToken);


http.createServer(app).listen(app.get('port'), function () {
    console.log('AgoraSignServer starts at ' + app.get('port'));
});