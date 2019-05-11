FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine3.8 AS builder
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN apk add --no-cache git clang

RUN git clone https://github.com/zkSNACKs/WalletWasabi.git --recursive /WalletWasabi
WORKDIR /WalletWasabi/WalletWasabi.Gui
RUN git checkout tags/v1.1.4

RUN dotnet restore
RUN dotnet build -c Release -o /app/ -r linux-x64
RUN dotnet publish --output /app/ -c Release --disable-parallel --no-cache /p:DebugType=none /p:DebugSymbols=false /p:ErrorReport=none

# remove unused files
RUN rm /app/TorDaemons/tor-osx64.zip /app/TorDaemons/tor-win32.zip
RUN rm -rf /app/runtimes/osx /app/runtimes/tizen-armel /app/runtimes/tizen-x86 /app/runtimes/win /app/runtimes/win-x64 /app/runtimes/win--x86
RUN rm -rf /app/Hwi/Software/hwi-osx64.zip /app/Hwi/Software/hwi-win64

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-alpine3.8

RUN mkdir -p /root/.walletwasabi/client/Wallets

ENV GLIBC_VERSION 2.29-r0
ENV GLIBC_SHA256 be14d25cf96c1c4fc44b6bd3dcec3227db4e227f89a2148e859b1e95eea81ad2
ENV GLIBCBIN_SHA256 930f534acae9012911b13f734a292a051321ba1b5a0b16a06cbec0bd1c69ef85

RUN wget -O /etc/apk/keys//cyphernode@satoshiportal.com.rsa.pub https://github.com/SatoshiPortal/alpine-pkg-glibc/releases/download/2.29-r0/cyphernode@satoshiportal.com.rsa.pub \
 && wget -O glibc.apk "https://github.com/SatoshiPortal/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}-x86_64.apk" \
 && echo "$GLIBC_SHA256  glibc.apk" | sha256sum -c - \
 && wget -O glibc-bin.apk "https://github.com/SatoshiPortal/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}-x86_64.apk" \
 && echo "$GLIBCBIN_SHA256  glibc-bin.apk" | sha256sum -c - \
 && apk add --update --no-cache glibc-bin.apk glibc.apk \
 && apk add --no-cache expect \
 && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
 && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
 && rm -rf glibc.apk glibc-bin.apk

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

COPY --from=builder /app /app
WORKDIR /app

COPY docker-entrypoint.sh docker-entrypoint.sh
COPY start.sh start.sh


ENTRYPOINT ["/app/docker-entrypoint.sh"]
