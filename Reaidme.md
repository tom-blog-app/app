### Create a new module

```
go mod init github.com/tom-blog-app/service-name
```

### Generate proto files
```
$ protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative logs/logs.proto
```