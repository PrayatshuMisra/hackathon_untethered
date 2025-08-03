#!/usr/bin/env python3
import http.server
import socketserver
import os
import sys

# Change to the build/web directory
os.chdir('build/web')

PORT = 8080

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

print(f"Starting HTTP server on port {PORT}")
print(f"Serving files from: {os.getcwd()}")
print(f"App will be available at: http://localhost:{PORT}")
print("Press Ctrl+C to stop the server")

try:
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        httpd.serve_forever()
except KeyboardInterrupt:
    print("\nServer stopped.")
except OSError as e:
    if e.errno == 48:  # Address already in use
        print(f"Port {PORT} is already in use. Please stop any existing servers.")
    else:
        print(f"Error: {e}")
    sys.exit(1) 