FROM alpine:3.6

# http://mirror1.hs-esslingen.de/Mirrors
#RUN sed -i "s|http://dl-cdn.alpinelinux.org|https://mirrors.ustc.edu.cn|g" /etc/apk/repositories; \
#    apk add --no-cache ca-certificates
#RUN apk add --no-cache ca-certificates

ARG port=9999
EXPOSE ${port}
ENV GOMAXPROCS=1 PORT=${port}

# docker run --rm -it -p 9999:9999 empirefoxit/remote-exec -loglever=error
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
