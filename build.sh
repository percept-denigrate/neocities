INPUT_DIR=source
OUTPUT_DIR=public

rm "$OUTPUT_DIR"/*.html

for file in "$INPUT_DIR"/*.md; do
    filename=$(basename "$file" .md)
    pandoc "$file" \
        --template=template.html \
        -o "$OUTPUT_DIR/$filename.html"
done

neocities push --prune public/
