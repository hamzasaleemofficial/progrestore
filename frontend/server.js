const http = require("http");
const fs = require("fs");
const path = require("path");
const { URL } = require("url");

const PORT = 5173;
const DIST = path.join(__dirname, "dist");

const MIME_TYPES = {
  ".html": "text/html",
  ".js": "application/javascript",
  ".css": "text/css",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".svg": "image/svg+xml",
  ".ico": "image/x-icon",
  ".webp": "image/webp",
  ".woff": "font/woff",
  ".woff2": "font/woff2",
};

const server = http.createServer((req, res) => {
  try {
    const url = new URL(req.url, `http://${req.headers.host}`);
    let pathname = decodeURIComponent(url.pathname);

    if (pathname === "/") {
      pathname = "/index.html";
    }

    const requestedFile = path.normalize(path.join(DIST, pathname));

    if (!requestedFile.startsWith(DIST)) {
      res.writeHead(403);
      res.end("Forbidden");
      return;
    }

    if (fs.existsSync(requestedFile) && fs.statSync(requestedFile).isFile()) {
      const ext = path.extname(requestedFile);

      res.writeHead(200, {
        "Content-Type": MIME_TYPES[ext] || "application/octet-stream",
      });

      fs.createReadStream(requestedFile).pipe(res);
      return;
    }

    // SPA fallback
    const indexFile = path.join(DIST, "index.html");

    res.writeHead(200, {
      "Content-Type": "text/html",
    });

    fs.createReadStream(indexFile).pipe(res);
  } catch {
    res.writeHead(500);
    res.end("Internal Server Error");
  }
});

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Frontend running on port ${PORT}`);
});