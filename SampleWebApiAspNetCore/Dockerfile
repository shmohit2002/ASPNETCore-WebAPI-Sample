FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
 
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
 
COPY ["SampleWebApiAspNetCore.csproj", "."]
RUN dotnet restore "./SampleWebApiAspNetCore.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "SampleWebApiAspNetCore.csproj" -c Release -o /app/build
 
FROM build AS publish
RUN dotnet publish "SampleWebApiAspNetCore.csproj" -c Release -o /app/publish
 
FROM base AS final
WORKDIR /app
EXPOSE 80
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]