FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine3.8 AS builder
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN apk add --no-cache git

RUN git clone https://github.com/zkSNACKs/WalletWasabi.git --recursive /WalletWasabi
WORKDIR /WalletWasabi/WalletWasabi.Gui
RUN dotnet build

RUN dotnet publish --output /app/ --configuration Release


FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-alpine3.8

RUN mkdir -p /root/.walletwasabi/client/Wallets

COPY glibc-2.29-r0.apk glibc-2.29-r0.apk
COPY glibc-bin-2.29-r0.apk glibc-bin-2.29-r0.apk
COPY ssh.rsa.pub /etc/apk/keys/ssh.rsa.pub

RUN apk add --update --no-cache glibc-2.29-r0.apk glibc-bin-2.29-r0.apk \
 && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
 && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
 && rm -rf glibc-2.29-r0.apk glibc-bin-2.29-r0.apk


ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
#RUN apk add --no-cache icu-libs
RUN apk add --no-cache expect libevent

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

COPY --from=builder /app /app
WORKDIR /app

COPY docker-entrypoint.sh docker-entrypoint.sh
COPY start.sh start.sh


ENTRYPOINT ["/app/docker-entrypoint.sh"]