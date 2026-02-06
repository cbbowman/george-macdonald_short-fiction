
#!/bin/bash

set +H  # Disable history expansion to avoid issues with ! in titles

# Loop over all XHTML files (adjust the pattern if needed)
for file in *.xhtml; do
    # Check if the file exists and is readable
    if [ -f "$file" ]; then
        # Use perl to replace all titles in one pass
        perl -i -0777 -pe 's/<p epub:type="title">([^<]+)<\/p>/"<p epub:type=\"title\">" . `se titlecase "$1" -n` . "<\/p>"/ge' "$file"
        
        # Check if any replacements were made (optional, but for feedback)
        if grep -q '<p epub:type="title">' "$file"; then
            echo "Updated titles in $file"
        else
            echo "No titles found in $file"
        fi
    fi
done
