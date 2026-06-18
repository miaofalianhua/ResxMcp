# 🌐 ResxMcp
<p align="right">🌏 <a href="README.md">English</a> | <a href="README.zh-CN.md">中文</a> | <a href="README.ko-KR.md">한국어</a></p>

> A lightweight MCP server for managing `.resx` localization files  
> 一个用于管理 `.resx` 本地化资源文件的轻量级 MCP 服务器

<p align="center">
  <img src="https://img.shields.io/badge/.NET-8.0-blue?logo=dotnet&logoColor=white" alt=".NET" />
  <img src="https://img.shields.io/badge/MCP-Compatible-success?logo=protocols.io" alt="MCP Compatible" />
  <img src="https://img.shields.io/badge/Platform-Windows-green?logo=windows" alt="Windows" />
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License" />
</p>

---

## 🎬 Visual Walkthrough
**Editing multi-language `.resx` via Gemini CLI + ResxMcp**

**Step 1 — Update `Strings.resx` (neutral/en):**  
![Step 1](docs/images/resxmcp-step1-write-en.png)

**Step 2 — Update `Strings.zh-CN.resx` (Simplified Chinese):**  
![Step 2](docs/images/resxmcp-step2-write-zhCN.png)

**Step 3 — Update `Strings.ja-JP.resx` (Japanese):**  
![Step 3](docs/images/resxmcp-step3-write-jaJP.png)

**✅ Step 4 — Final Multilingual Result:**  
Below is the merged multilingual view of all `.resx` files.  
![Final](docs/images/resxmcp-localization-example.png)

---

---

## 🧭 Overview
**ResxMcp** is a minimal **MCP (Model Context Protocol)** compatible tool server that allows safe **read / write / modify** operations on `.resx` files.  
It works with **any MCP client** such as Gemini CLI, Claude Desktop, or Cursor IDE.

---

## ⚙️ Features
✅ Read `.resx` files as UTF-8 text  
✅ Atomic write with optional `.bak` backup (off by default)  
✅ Add / update / remove resource keys  
✅ Works with all MCP clients  
✅ Diff-friendly deterministic output

---

## 🧰 Available Tools

| Tool | Description | Parameters |
|------|--------------|-------------|
| `resx.read` | Read `.resx` as UTF-8 text | `{ "file": "path/to/file.resx" }` |
| `resx.write` | Write UTF-8 text (atomic replace) | `{ "file": "path/to/file.resx", "content": "<xml>", "backup": false }` |
| `resx.setEntry` | Add or update a key/value pair | `{ "file": "path/to/file.resx", "name": "Key", "value": "Value", "comment": "Optional", "backup": false }` |
| `resx.setEntries` | Add or update **multiple** keys in one pass (1 read + 1 write) | `{ "file": "path/to/file.resx", "entries": [{ "name": "K1", "value": "V1", "comment": "Optional" }, ...], "backup": false }` |
| `resx.removeEntry` | Remove a key from `.resx` | `{ "file": "path/to/file.resx", "name": "Key", "backup": false }` |
| `resx.removeEntries` | Remove **multiple** keys in one pass (1 read + 1 write) | `{ "file": "path/to/file.resx", "names": ["K1", "K2"], "backup": false }` |

> The `backup` parameter is **optional** on `resx.write`, `resx.setEntry`, `resx.setEntries`, `resx.removeEntry`, and `resx.removeEntries`.  
> It defaults to `false` (no `.bak` is created). Set it to `true` to keep a `.bak` copy of the previous file.

> 💡 **Performance tip:** prefer `resx.setEntries` / `resx.removeEntries` when touching more than one key.  
> Each single-key call rewrites the whole file, while the bulk variants read once and write once.

---

## ⚠️ Installation Notice

Some users may try to install this project with:

```bash
gemini extensions install https://github.com/miaofalianhua/ResxMcp
```

⚠️ **Do NOT do this repeatedly!**  
This command triggers Google’s extension registry verification and may result in **rate limit errors (HTTP 429)** or **installation failure**.

👉 The correct way to use **ResxMcp** is as a **local MCP server**, not a regular Gemini extension.

---

### ✅ Recommended Installation

1️⃣ **Build the project**
```bash
dotnet publish -c Release -r win-x64 -p:PublishSingleFile=true -o ./publish
```

2️⃣ **Register with Gemini CLI**
```bash
gemini mcp add resx-tool "./publish/ResxMcp.exe"
```

3️⃣ **Verify installation**
```bash
gemini @resx-tool tools/list
```

You should see tools such as:  
`resx.read`, `resx.write`, `resx.setEntry`, and `resx.removeEntry`.

💡 *Tip:* If you wish to distribute it as an installable Gemini extension, use the included `gemini-extension.json` (v1.0.2). It wraps this MCP server for one-command installation when the registry supports MCP-only extensions.

---

## 🚀 Quick Start

1. Build your .NET project with localization resources.  
2. Use `resx.read` to inspect `.resx` content.  
3. Modify, translate, or generate `.resx` files automatically with your MCP tools.  
4. Use `resx.write` or `resx.setEntry` to update keys or values.


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
