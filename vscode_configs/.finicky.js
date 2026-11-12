// thing for opening links to codein VS Code via browser, e.g. for code review links
export default {
  defaultBrowser: "Firefox", // your usual browser
  rewrite: [
    {
      // http://localhost:8765/<path>:<line> -> vscode://file/<path>:<line>:1
      match: "http://localhost:8765/*",
      url: (url) => `vscode://file${url.pathname}:1`,
    },
  ],
  handlers: [
    {
      match: (url) => url.protocol.startsWith("vscode"),
      browser: "Visual Studio Code",
    },
  ],
};
EOF