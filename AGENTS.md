# AGENTS.md

This repository contains multiple microservices in Go, Python, Java, C#, and Node.js. Follow these guidelines for agentic coding:

## Build, Lint, and Test Commands
- **Go:**
  - Build: `go build`
  - Test all: `go test ./...`
  - Test single: `go test -run <TestName>`
- **Python:**
  - Install: `pip install -r requirements.txt`
  - Test: Use `pytest` or `python -m unittest` (service-dependent)
  - Test single: `pytest <file>::<TestClass>::<test_func>`
- **Java (AdService):**
  - Build: `./gradlew build`
  - Format: `./gradlew googleJavaFormat`
  - Test: `./gradlew test`
- **C# (CartService):**
  - Build: `dotnet build`
  - Test: `dotnet test`
  - Test single: `dotnet test --filter FullyQualifiedName~<TestName>`
- **Node.js:**
  - Install: `npm install`
  - Test: `npm test` (if tests exist)

## Code Style Guidelines
- **Formatting:**
  - Use `.editorconfig` rules: spaces (2 for most, 4 for C#/Dockerfile/Java/Python), tabs for Go.
  - Trim trailing whitespace, insert final newline.
- **Imports:**
  - Group by standard, third-party, local. Remove unused imports.
- **Naming:**
  - Use descriptive, camelCase for variables/functions (Go: mixedCaps, Python: snake_case, Java/C#: PascalCase for classes).
- **Types:**
  - Prefer explicit types. Use type hints in Python.
- **Error Handling:**
  - Handle errors explicitly. Log errors with context. Avoid silent failures.
- **General:**
  - Write clear, maintainable code. Add comments for complex logic. Follow language idioms.

No Cursor or Copilot rules are present. For more details, see service-specific README files.