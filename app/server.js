const http = require('http');
const fs = require('fs');
const path = require('path');

const port = process.env.PORT || 8080;
const indexPath = path.join(__dirname, 'index.html');

const server = http.createServer((req, res) => {
  if (req.url === '/' || req.url.startsWith('/index.html')) {
    const html = fs.readFileSync(indexPath, 'utf8');
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(html);
    return;
  }
  res.writeHead(404);
  res.end('Not found');
});

if (require.main === module) {
  server.listen(port, () => console.log(`Server running on ${port}`));
} else {
  module.exports = server;
}
