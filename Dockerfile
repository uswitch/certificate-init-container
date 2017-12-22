FROM golang as builder

WORKDIR /go/src/github.com/uswitch/certificate-init-container
COPY . /go/src/github.com/uswitch/certificate-init-container/
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM alpine
ADD start.sh /start.sh
COPY --from=builder /go/src/github.com/uswitch/certificate-init-container/certificate-init-container /certificate-init-container
ENTRYPOINT ["/start.sh"]
