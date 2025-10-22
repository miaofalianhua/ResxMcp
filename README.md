# 🌐 ResxMcp
> A lightweight MCP server for managing `.resx` localization files  
> 一个用于管理 `.resx` 本地化资源文件的轻量级 MCP 服务器

<p align="center">
  <img src="https://img.shields.io/badge/.NET-8.0-blue?logo=dotnet&logoColor=white" alt=".NET" />
  <img src="https://img.shields.io/badge/MCP-Compatible-success?logo=protocols.io" alt="MCP Compatible" />
  <img src="https://img.shields.io/badge/Platform-Windows-green?logo=windows" alt="Windows" />
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License" />
</p>

---

## 🧭 Overview
**ResxMcp** is a minimal **MCP (Model Context Protocol)** compatible tool server that allows safe **read / write / modify** operations on `.resx` files.  
It works with **any MCP client** such as Gemini CLI, Claude Desktop, or Cursor IDE.

---

## ⚙️ Features
✅ Read `.resx` files as UTF-8 text  
✅ Atomic write with optional `.bak` backup  
✅ Add / update / remove resource keys  
✅ Works with all MCP clients  
✅ Diff-friendly deterministic output

---

## 🧰 Available Tools

| Tool | Description | Parameters |
|------|--------------|-------------|
| `resx.read` | Read `.resx` as UTF-8 text | `{ "file": "path/to/file.resx" }` |
| `resx.write` | Write UTF-8 text (atomic replace) | `{ "file": "path/to/file.resx", "content": "<xml>", "backup": true }` |
| `resx.setEntry` | Add or update a key/value pair | `{ "file": "path/to/file.resx", "name": "Key", "value": "Value", "comment": "Optional" }` |
| `resx.removeEntry` | Remove a key from `.resx` | `{ "file": "path/to/file.resx", "name": "Key" }` |

---

## 🚀 Quick Start

### 1️⃣ Build & Publish
```bash
dotnet publish -c Release -r win-x64 -p:PublishSingleFile=true -o ./publish
```

### 2️⃣ Register in Gemini CLI
```bash
gemini mcp add-process resx-tool "./publish/ResxMcp.exe"
```

### 3️⃣ Test Connection
```bash
gemini @resx-tool tools/list
```

You should see:
```json
{
  "tools": [
    "resx.read",
    "resx.write",
    "resx.setEntry",
    "resx.removeEntry"
  ]
}
```

---

## 🖥️ Example Usage
```bash
gemini @resx-tool tools/call resx.setEntry --arguments '{"file":"lang.zh-CN.resx","name":"App.Title","value":"Triad Controls"}'
```

---

## 🧩 Integration
ResxMcp communicates over **stdio (JSON-RPC)**,  
so it can be used by any modern **AI-assisted development tool** or **automation pipeline** following the MCP standard.

Compatible with:
- 🪄 Gemini CLI  
- 🧠 Claude Desktop  
- 🧰 Cursor IDE  
- ⚙️ Any MCP-based custom workflow

---

## 🪶 License
Licensed under the [MIT License](LICENSE).

---

## ✨ Author
**斌哥 (Miaofalianhua)**  
🌍 GitHub: [@miaofalianhua](https://github.com/miaofalianhua)  
🧠 Focus: C#, Localization, AI-assisted Development

> 💡 *ResxMcp bridges classic .NET localization with modern AI workflows — simple, safe, and open.*
