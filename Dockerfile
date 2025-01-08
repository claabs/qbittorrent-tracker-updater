FROM alpine:latest

WORKDIR /usr/src/app

RUN apk --no-cache add jq curl tini supercronic tzdata

COPY *.sh ./

# backwards compat entrypoint
RUN ln -s /usr/src/app/docker-entrypoint.sh / 

RUN addgroup --system updater && adduser --system updater --ingroup updater

USER updater

ENTRYPOINT ["tini", "--", "./docker-entrypoint.sh"]