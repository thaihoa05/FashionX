# Sử dụng image .NET SDK để build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# copy csproj và restore
COPY *.sln .
COPY DuAnTotNghiep_Qlycuahangquanao/*.csproj DuAnTotNghiep_Qlycuahangquanao/
RUN dotnet restore

# copy toàn bộ source và build
COPY . .
WORKDIR /src/DuAnTotNghiep_Qlycuahangquanao
RUN dotnet publish -c Release -o /app/publish

# runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DuAnTotNghiep_Qlycuahangquanao.dll"]
