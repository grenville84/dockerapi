# setup build environment
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine3.10 AS build-env
ARG Version
WORKDIR /app

# copy everything and build the project
COPY src ./
RUN dotnet publish dummy-api.csproj -c Release -o ./out --no-restore

# build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine3.11
WORKDIR /app
COPY --from=build-env /app/out ./

ENV ASPNETCORE_URLS http://+:5000

EXPOSE 5000
ENTRYPOINT ["dotnet", "dummy-api.dll"]