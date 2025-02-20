#!/bin/bash

# Defina a consulta de pesquisa
QUERY="arquivo+filetype%3Apdf"

# Baixe a página de resultados
curl -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36" "https://www.buscador.com/search?q=$QUERY" -o resultados.html

# Extraia os links de PDFs
grep -o 'https://[^"]*\.pdf' resultados.html > links.txt

# Baixe os PDFs
while read -r url; do
    curl -O "$url"
done < links.txt

# Limpeza (opcional)
rm resultados.html links.txt
