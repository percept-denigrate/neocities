INPUT_DIR=source
OUTPUT_DIR=public

# Remove previous HTML files
find "$OUTPUT_DIR" -name '*.html' -delete

# Find all .md files inside source/
find "$INPUT_DIR" -type f -name '*.md' | while read -r file; do
    # Get path relative to INPUT_DIR
    relpath="${file#$INPUT_DIR/}"

    # Remove .md extension
    outpath="$OUTPUT_DIR/${relpath%.md}.html"

    # Ensure the output directory exists
    mkdir -p "$(dirname "$outpath")"

    # Convert markdown → html
    pandoc "$file" \
        --template=template.html \
        -o "$outpath"
done

# Copy any non-md files and directories (optional)
rsync -av --exclude='*.md' "$INPUT_DIR/" "$OUTPUT_DIR/"

# Upload
neocities push --prune public/

