const line = require('@line/bot-sdk');
const client = new line.Client({channelAccessToken: process.env.ACCESS_TOKEN});

exports.handler = async function (event, context) {
  let body = JSON.parse(event.body);
  if (body.events[0].replyToken === '00000000000000000000000000000000') {
    let lambdaResponse = {
      statusCode: 200,
      headers: { "X-Line-Status" : "OK"},
      body: '{"result":"connect check"}'
    };
    context.succeed(lambdaResponse);
  } else {
   var ret = {
     'type': 'text',
     'text': 'Hello World!'
   };
   var response = await client.replyMessage(body.events[0].replyToken, ret);
   let lambdaResponse = {
     statusCode: 200,
     headers: { "X-Line-Status" : "OK"},
     body: '{"result":"completed"}'
   };
   context.succeed(lambdaResponse);
 }
};
