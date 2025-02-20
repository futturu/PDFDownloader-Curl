#!/bin/bash

# Defina a consulta de pesquisa
QUERY="arquivo+filetype%3apdf"

# Defina o número máximo de páginas para buscar
MAX_PAGES=5

# Loop para iterar pelas páginas
for PAGE in $(seq 1 $MAX_PAGES); do
    # Calcula o deslocamento para a página atual (exemplo: Bing usa &first=)
    OFFSET=$(( ($PAGE - 1) * 10 + 1 ))

    echo "Buscando na página $PAGE (offset=$OFFSET)..."

    # Baixe a página de resultados do buscador
    curl -A "Mozilla/5.0" "https://www.buscadordepreferencia.com/search?q=$QUERY&first=$OFFSET" -o "resultados_pagina_$PAGE.html"

    # Extraia os links de PDFs
    grep -o 'https://[^"]*\.pdf' "resultados_pagina_$PAGE.html" >> links.txt
done

# Remova duplicatas dos links extraídos
sort -u links.txt -o links.txt

# Baixe os PDFs
while read -r url; do
    echo "Baixando $url..."
    curl -O "$url"
done < links.txt

# Limpeza (opcional)
rm resultados_pagina_*.html links.txt
