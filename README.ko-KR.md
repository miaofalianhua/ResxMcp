# 🌐 ResxMcp
<p align="right">🌏 <a href="README.md">English</a> | <a href="README.zh-CN.md">中文</a> | <a href="README.ko-KR.md">한국어</a></p>

> `.resx` 다국어 리소스 파일을 관리하는 가벼운 **MCP 프로토콜 서버**입니다.  
> **MCP 호환 클라이언트**(Gemini CLI, Claude Desktop, Cursor 등)에서 모두 사용할 수 있습니다.

<p align="center">
  <img src="https://img.shields.io/badge/.NET-8.0-blue?logo=dotnet&logoColor=white" alt=".NET" />
  <img src="https://img.shields.io/badge/MCP-Compatible-success?logo=protocols.io" alt="MCP Compatible" />
  <img src="https://img.shields.io/badge/Platform-Windows-green?logo=windows" alt="Windows" />
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License" />
</p>

---

## 🎬 시각적 데모
**Gemini CLI + ResxMcp 로 다국어 `.resx` 파일 편집하기**

**1단계 — `Strings.resx` 업데이트(중립/영어):**  
![Step 1](docs/images/resxmcp-step1-write-en.png)

**2단계 — `Strings.zh-CN.resx` 업데이트(중국어 간체):**  
![Step 2](docs/images/resxmcp-step2-write-zhCN.png)

**3단계 — `Strings.ja-JP.resx` 업데이트(일본어):**  
![Step 3](docs/images/resxmcp-step3-write-jaJP.png)

**✅ 4단계 — 최종 다국어 결과:**  
아래 이미지는 동기화 완료 후의 다국어 대조표입니다.  
![Final](docs/images/resxmcp-localization-example.png)

---

---

## 🧭 프로젝트 소개

**ResxMcp** 는 **MCP(Model Context Protocol)** 기반의 가벼운 도구 서버로,  
`.resx` 리소스 파일을 안전하게 **읽고, 쓰고, 수정**할 수 있습니다.  
**JSON-RPC(stdio)** 로 통신하며, MCP 를 지원하는 모든 클라이언트와 호환됩니다.

---

## ⚙️ 기능 특징

✅ `.resx` 파일을 UTF-8 텍스트로 읽기  
✅ 원자 쓰기, 선택적 `.bak` 백업 지원(기본값 꺼짐)  
✅ 키의 추가·수정·삭제 지원  
✅ 모든 MCP 클라이언트 호환  
✅ 비교(diff) 에 유리한 결정적 출력

---

## 🧰 사용 가능한 도구

| 도구 | 설명 | 매개변수 |
|------|------|----------|
| `resx.read` | `.resx` 파일 내용 읽기 | `{ "file": "경로" }` |
| `resx.write` | `.resx` 파일 쓰기(선택 백업) | `{ "file": "경로", "content": "<xml>", "backup": false }` |
| `resx.setEntry` | 키 추가 또는 갱신 | `{ "file": "경로", "name": "Key", "value": "Value", "comment": "선택", "backup": false }` |
| `resx.setEntries` | 여러 키 **일괄** 추가·갱신(읽기 1회 + 쓰기 1회) | `{ "file": "경로", "entries": [{ "name": "K1", "value": "V1", "comment": "선택" }, ...], "backup": false }` |
| `resx.removeEntry` | 지정한 키 삭제 | `{ "file": "경로", "name": "Key", "backup": false }` |
| `resx.removeEntries` | 여러 키 **일괄** 삭제(읽기 1회 + 쓰기 1회) | `{ "file": "경로", "names": ["K1", "K2"], "backup": false }` |

> `backup` 매개변수는 `resx.write`, `resx.setEntry`, `resx.setEntries`, `resx.removeEntry`, `resx.removeEntries` 모두에서 **선택**입니다.  
> 기본값은 `false`(백업 생성 안 함) 이며, `true` 로 설정하면 이전 파일의 `.bak` 사본을 남깁니다.

> 💡 **성능 팁:** 여러 키를 한 번에 처리할 때는 `resx.setEntries` / `resx.removeEntries` 를 우선 사용하세요.  
> 단일 키 도구는 호출할 때마다 파일 전체를 다시 쓰지만, 벌크 도구는 한 번만 읽고 한 번만 씁니다.

---

## ⚠️ 설치 안내

일부 사용자가 다음 명령으로 설치를 시도할 수 있습니다:

```bash
gemini extensions install https://github.com/miaofalianhua/ResxMcp
```

⚠️ **이 명령을 반복해서 실행하지 마세요!**  
Google 확장 레지스트리 확인 절차가 트리거되어 **속도 제한 오류(HTTP 429)** 또는 **설치 실패**가 발생할 수 있습니다.

👉 올바른 방법은 **ResxMcp** 를 일반 Gemini 확장이 아닌, 로컬 **MCP 서버**로 사용하는 것입니다.

---

### ✅ 권장 설치 방법

1️⃣ **프로젝트 빌드**
```bash
dotnet publish -c Release -r win-x64 -p:PublishSingleFile=true -o ./publish
```

2️⃣ **Gemini CLI 에 등록**
```bash
gemini mcp add resx-tool "./publish/ResxMcp.exe"
```

3️⃣ **연결 확인**
```bash
gemini @resx-tool tools/list
```

출력에 다음 도구들이 포함되어야 합니다:  
`resx.read`, `resx.write`, `resx.setEntry`, `resx.removeEntry`.

💡 *팁:*  
Gemini 확장으로 패키징하려면 첨부된 `gemini-extension.json`(v1.0.2)을 사용하세요.  
이 파일은 MCP 서버를 확장 형태로 감싸며, CLI 가 MCP 전용 확장을 지원하면 한 번에 설치할 수 있습니다.

---

## 🚀 빠른 시작

1. 다국어 리소스를 포함한 .NET 프로젝트를 빌드합니다.  
2. `resx.read` 로 `.resx` 내용을 확인합니다.  
3. MCP 도구로 `.resx` 파일을 자동 생성하거나 번역합니다.  
4. `resx.write` 또는 `resx.setEntry` 로 키/값을 갱신합니다.

---

## 🖥️ 사용 예시
```bash
gemini @resx-tool tools/call resx.setEntry --arguments '{"file":"lang.zh-CN.resx","name":"App.Title","value":"Triad Controls"}'
```

---

## 🧩 연동
ResxMcp 는 **stdio(JSON-RPC)** 로 통신하므로,  
MCP 표준을 따르는 모든 최신 **AI 보조 개발 도구** 또는 **자동화 파이프라인**에서 사용할 수 있습니다.

호환 예시:  
- 🪄 Gemini CLI  
- 🧠 Claude Desktop  
- 🧰 Cursor IDE  
- ⚙️ MCP 기반 커스텀 자동화 워크플로

---

## 🪶 라이선스
본 프로젝트는 [MIT License](LICENSE) 로 공개됩니다.

---

## ✨ 저자

**斌哥 (Miaofalianhua)**  
🌍 GitHub: [@miaofalianhua](https://github.com/miaofalianhua)  
💬 분야: C#, 국제화, 다국어 리소스 처리, AI 협업 개발  

> 💡 *ResxMcp 는 전통적인 .NET 로컬라이제이션과 최신 AI 워크플로를 매끄럽게 연결합니다 — 간결하고, 안전하고, 개방적으로.*
