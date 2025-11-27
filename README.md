# microlicoes

Projeto Flutter.

## Como executar o projeto

Existem três formas principais de executar este aplicativo: pelo VS Code, pelo terminal e usando o modo “attach”.

---

## 1) Executar pelo VS Code (Run and Debug)

O VS Code utiliza as configurações definidas em `.vscode/launch.json`.

Para executar:

1. Abra o menu Run and Debug (Ctrl+Shift+D).
2. Escolha uma configuração, como:
   - microlicoes (debug)
   - microlicoes (release)
   - Attach
3. Clique em Start Debugging (F5).

---

## 2) Executar pelo Terminal

### Rodar no dispositivo/emulador:
```
flutter run -d <device>
```

Exemplo:
```
flutter run -d emulator-5554
```

### Rodar com flavor:
```
flutter run -d <device> --flavor <flavor> -t lib/main_<flavor>.dart
```

Exemplo:
```
flutter run -d emulator-5554 --flavor dev -t lib/main_dev.dart
```

### Rodar com variáveis usando --dart-define:
```
flutter run --dart-define KEY=VALUE
```

Exemplo:
```
flutter run --dart-define API_URL=https://api.dev
```

---

## 3) Attach (conectar debugger a um app já em execução)

### Pelo terminal:
```
flutter attach
```

### Pelo VS Code:
Use a configuração do tipo "request": "attach" presente em `launch.json`.

---

## Hot Reload e Hot Restart

### Pelo Terminal:
- r → hot reload  
- R → hot restart

### Pelo VS Code:
- Botão de hot reload (ícone de raio)
- Botão de hot restart

---

## Listar dispositivos conectados
```
flutter devices
```

## Diagnóstico do Flutter
```
flutter doctor -v
```
