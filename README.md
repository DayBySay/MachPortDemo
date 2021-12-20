# MachPortDemo
## Setup
```
$ make build
```

## Launch MachPort Server
```
$ make serve
2021-12-21 00:16:12.331 Server[95403:11318118] サーバー起動
```

## Send message using MachPort Client
```
$ make client MESSAGE=SOME_MESSAGE_TEXT
2021-12-21 00:17:00.636 Client[95841:11320858] response: SOME_MESSAGE_TEXT というメッセージ受信したよ
```
