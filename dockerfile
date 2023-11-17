# Estágio de construção
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copiar arquivos necessários
COPY . ./
# Restaurar dependências e publicar
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Estágio de runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
# Copiar artefatos do estágio de construção
COPY --from=build-env /App/out .
# Definir ponto de entrada para o aplicativo
ENTRYPOINT ["dotnet", "dockerImages.dll"]

