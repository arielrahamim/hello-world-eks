const http = require('http');
const fs = require('fs');

const serverHost = process.env.serverHost;
const serverPort = process.env.serverPort;

const options = {
  hostname: serverHost,
  port: serverPort,
  path: '/',
  method: 'GET',
};

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    // Make the HTTP request to serverHost
    const reqToServerHost = http.request(options, (responseFromServerHost) => {
      let data = '';

      responseFromServerHost.on('data', (chunk) => {
        data += chunk;
      });

      responseFromServerHost.on('end', () => {
        const filePath = 'response.html';
        const htmlContent = generateHTML(data);
        fs.writeFileSync(filePath, htmlContent);

        res.writeHead(200, { 'Content-Type': 'text/html' });
        fs.createReadStream(filePath).pipe(res);
      });
    });

    reqToServerHost.on('error', (error) => {
      console.error(`Request to serverHost failed: ${error.message}`);
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Internal Server Error');
    });

    reqToServerHost.end();
  } else {
    // Handle other routes (if needed)
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
  }
});

const PORT = 8080;

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}/`);
});

function generateHTML(response) {
  // Make the response 10 times bigger and change its font
  const enlargedResponse = response.repeat(1);
  
  return `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Server Response</title>
      <style>
        body {
          font-family: 'Comic Sans MS', cursive, sans-serif;
        }
      </style>
    </head>
    <body>
      <div style="text-align: center; margin-top: 50px;">
        <h1>Server Response from ${serverHost}:</h1>
        <p>${enlargedResponse}</p>
      </div>
    </body>
    </html>
  `;
}
