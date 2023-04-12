#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS base
WORKDIR /app
ENV ASPNETCORE_HTTP_PORT=https://+:5001
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY ["DotNetWebApp/DotNetWebApp.csproj", "."]
RUN dotnet restore "./DotNetWebApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DotNetWebApp/DotNetWebApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotNetWebApp/DotNetWebApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

RUN adduser -D testuser 
USER testuser

ARG GetMyUsername 
RUN echo ${GetMyUsername}
RUN mkdir -p /home/${GetMyUsername}

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "DotNetWebApp.dll"]