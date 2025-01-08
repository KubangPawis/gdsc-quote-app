import json
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate("D:/College/MockDev/gdsc-quote-app/backend/json-files/service_key.json")
firebase_admin.initialize_app(cred)

# Connect to Firestore
db = firestore.client()

# Load JSON file
with open("D:/College/MockDev/gdsc-quote-app/backend/json-files/updated_quotes.json", "r") as file:
    data = json.load(file)

# Upload quotes to Firestore
for entry in data["quotes"]:
    # Add each quote to a collection called "quotes"
    try:
        db.collection("quotes").add(entry)
    except Exception as e:
        print(f"Error uploading entry: {entry}, Error: {e}")

print("Quotes successfully uploaded to Firestore!")