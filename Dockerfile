# setup build environment
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine3.10
ARG Version
WORKDIR /app

# copy everything and build the project
COPY src ./

RUN dotnet test
RUN dotnet publish dockerapi/dockerapi.csproj -c Release -o ./out --no-restore

# build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine3.11
WORKDIR /app

#https://stackoverflow.com/questions/61518512/aws-elastic-beanstalk-docker-does-not-support-multi-stage-build/62031810#62031810
COPY --from=0 /app/out ./

ENV ASPNETCORE_URLS http://+:80

EXPOSE 80
ENTRYPOINT ["dotnet", "dockerapi.dll"]
