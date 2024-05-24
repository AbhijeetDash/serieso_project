// Dependencies for callable functions.
const {onCall} = require("firebase-functions/v2/https");
const authtri = require("firebase-functions/v1/auth")
const {setGlobalOptions} = require("firebase-functions/v2");

// Dependencies for Misc.
const axios = require('axios');
const path = require('path');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});

const fs = require('fs');
const crypto = require('crypto');

// TODO : Save it somewhere on the server.
const sandboxKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJmNjEwM2MwMi1kOTkyLTQ3ZjItOWQzYy01ODM5Yzc4NGI4MjkiLCJuYW1lIjoiWm90dGFnZSBzZXJ2aWNlcyBMTFAiLCJyZWciOiJlYmxNQ2Rvc2txWXNlc0xHaTU2UiIsImNvbmZpZyI6IlpvdHRhZ2UiLCJpYXQiOjE2ODE4MTA1MjV9.VTn77pgKHQwzqBYrARxJ0VLbei9nbHLq45DIFrP4Snk";
const signature_algorithm = "SHA256";


// Using gmail to send OTP emails.
// TODO : Switch to Gmail API from GCP.
let transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
      user: 'abhijeet.dash@serieso.com',
      pass: 'I forgot my serieso password.'
  }
});

// Set the maximum instances to 10 for all functions
setGlobalOptions({maxInstances: 10});

function privateSign(payload) {
  var privateKey = fs.readFileSync('./crtkey.key');
  var binaryData = Buffer.from(JSON.stringify(payload));
  var signature = crypto.sign(signature_algorithm, binaryData, privateKey).toString("base64");
  return signature;
}

exports.openEscrowAccount = onCall((data, context) => {
  // Create an escrow
  var payload = {
    escrow_id: "test-02",
    escrow_name: "Dummy name one",
    terms_and_conditions: "Dummy T&C",
    key_deliverables: "Release of funds at end of day",
  };

  // Put the timestamp in the payload.
  var timestamp = new Date().toLocaleString("en-IN", { timeZone: "Asia/Kolkata" });
  payload.timestamp = timestamp;

  // Signing the payload.
  const signature = privateSign(payload);
  console.log(signature);
  payload.signature = signature;

  var body = JSON.stringify(payload);

  let config = {
    method: 'post',
    maxBodyLength: Infinity,
    url: 'https://sim.iamvouched.com/v1/escrow/create_escrow',
    headers: { 
      'apikey': sandboxKey,
      "Content-Type": "application/json",
    },
    data : body,
  };
  
  return axios.request(config).then((response) => {
    console.log(JSON.stringify(response.data));
  }).catch((error) => {
    console.log(error);
  });
});

exports.sendTokenEmail = authtri.user().onCreate((data, context) => {
  // Get all user data payload.
  var  {email, displayName} = user;

  var payload = {
    "email": email,
    "dsn": displayName
  }

  cors(req, res, () => {
        
    // getting dest email by query string
    const dest = req.query.dest;

    const mailOptions = {
        from: 'SeriesO <abhijeet.dash@serieso.com>', // Something like: Jane Doe <janedoe@gmail.com>
        to: dest,
        subject: 'SeriesO Account Verification', // email subject
        html: `<p style="font-size: 16px;">Copy the below line and paste it in the Auth Code.</p>
            <br />
            <p>${otp}</p>
            <br />
            <p>Thanks,\nTeam SeriesO</p>
        ` // email content in HTML
    };

    // returning result
    return transporter.sendMail(mailOptions, (erro, info) => {
        if(erro){
            return res.send(erro.toString());
        }
        return res.send('Sent');
    });
  });    
});
