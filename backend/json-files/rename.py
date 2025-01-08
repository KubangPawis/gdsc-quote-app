import json

with open("quote.json", "r") as file:
    data = json.load(file)

for entry in data["quotes"]:
    entry["quote"] = entry.pop("q")
    entry["author"] = entry.pop("a")
    entry["html_blockquote"] = entry.pop("h")

    entry.pop("c", None)  

with open("updated_quotes.json", "w") as file:
    json.dump(data, file, indent=4)

print("Keys renamed, character count removed, and updated JSON saved as 'updated_quotes.json'.")
