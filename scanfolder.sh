NPM=package.json
for file in *; do
    if [ -d "$file" ]; then
        if test -f "$file"/"$NPM"; then
            echo "$file"/"$NPM"
            ls
            npm run test --prefix "$file"
        fi
    fi
done