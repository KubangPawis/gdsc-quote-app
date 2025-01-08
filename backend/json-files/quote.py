import requests
import json

api_url = "https://zenquotes.io/api/quotes"

response = requests.get(api_url)

if response.status_code == 200:

    quotes = response.json()
    print(quotes)
    
    with open("quote.json", "w") as file:
        json.dump({"quotes": quotes}, file, indent=4)
else:
    print("Failed to fetch the quote. Error:", response.status_code)