# Use uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve.
FROM python:3.10-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Atualiza o pip para a versão mais recente
RUN pip install --no-cache-dir --upgrade pip

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker
COPY requirements.txt .

# Instala as dependências da aplicação
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação usando Uvicorn
# --host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]