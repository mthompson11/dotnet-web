FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY *.sln .
COPY WebApplication/*.csproj ./WebApplication/
RUN dotnet restore

COPY WebApplication/. ./WebApplication/

WORKDIR /src/WebApplication

RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT [ "dotnet", "WebApplication.dll" ]