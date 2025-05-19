## See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

## This stage is used when running from VS in fast mode (Default for Debug configuration)
#FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base
#USER $APP_UID
#WORKDIR /app

#ENV LD_LIBRARY_PATH="/app/clidriver/lib/"
#mkdir -p /var/lib/apt/lists/partial
#RUN apt-get -y update && apt-get install -y libxml2

## This stage is used to build the service project
#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#ARG BUILD_CONFIGURATION=Release
#WORKDIR /src
#COPY ["OCTest.csproj", "."]
#RUN dotnet restore "./OCTest.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "./OCTest.csproj" -c $BUILD_CONFIGURATION -o /app/build

## This stage is used to publish the service project to be copied to the final stage
#FROM build AS publish
#ARG BUILD_CONFIGURATION=Release
#RUN dotnet publish "./OCTest.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

## This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "OCTest.dll"]
#ENV PATH=$PATH:/app/clidriver/lib:/app/clidriver/adm
#CMD tail -f /dev/null


FROM mcr.microsoft.com/dotnet/runtime:8.0 AS base

WORKDIR /app

ENV LD_LIBRARY_PATH="/app/clidriver/lib/"

RUN apt-get -y update && apt-get install -y libxml2

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY ["OCTest.csproj", "."]

RUN dotnet restore "./OCTest.csproj"

COPY . .

WORKDIR "/src/."

RUN dotnet build "OCTest.csproj" -c Release -o /app/build

FROM build AS publish

RUN dotnet publish "OCTest.csproj" -c Release -o /app/publish

FROM base AS final

WORKDIR /app

COPY --from=publish /app/publish .

ENV PATH=$PATH:/app/clidriver/lib:/app/clidriver/adm
#ENV LD_DEBUG=true
CMD tail -f /dev/null
