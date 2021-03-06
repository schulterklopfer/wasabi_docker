FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine3.8 AS builder
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN apk add --no-cache git

RUN git clone --recursive https://github.com/schulterklopfer/WalletWasabi.git /WalletWasabi
COPY WalletGenerator /WalletGenerator

WORKDIR /WalletGenerator

RUN dotnet restore
RUN dotnet build -c Release -o /app/ -r linux-x64
RUN dotnet publish --output /app/ -c Release --disable-parallel --no-cache /p:DebugType=none /p:DebugSymbols=false /p:ErrorReport=none

WORKDIR /WalletWasabi/WalletWasabi.Gui

RUN dotnet restore
RUN dotnet build -c Release -o /app/ -r linux-x64
RUN dotnet publish --output /app/ -c Release --disable-parallel --no-cache /p:DebugType=none /p:DebugSymbols=false /p:ErrorReport=none

# remove unused files
#RUN rm /app/TorDaemons/tor-osx64.zip /app/TorDaemons/tor-win32.zip
RUN rm -rf /app/TorDaemons
RUN rm -rf /app/runtimes/osx /app/runtimes/tizen-armel /app/runtimes/tizen-x86 /app/runtimes/win /app/runtimes/win-x64 /app/runtimes/win--x86
RUN rm -rf /app/Hwi/Software/hwi-osx64.zip /app/Hwi/Software/hwi-win64

FROM mcr.microsoft.com/dotnet/core/runtime:2.2-alpine3.8

ENV APPDATA=/root/.walletwasabi/client

RUN apk add --no-cache expect tor icu

COPY --from=builder /app /app

WORKDIR /app

COPY docker-entrypoint.sh docker-entrypoint.sh
COPY checkWalletPassword.sh checkWalletPassword.sh
COPY startWasabiWallet.sh startWasabiWallet.sh
COPY generateWallet.sh generateWallet.sh
COPY startWasabiWalletWithPassword.sh startWasabiWalletWithPassword.sh
COPY torrc /etc/tor/torrc


ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENTRYPOINT ["/app/docker-entrypoint.sh"]
