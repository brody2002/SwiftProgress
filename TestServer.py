from flask import Flask, jsonify, request

app = Flask(__name__)

# Define the data globally
data = {
    "name": "Brody",
    "favoriteNumber": 711,
    "dog": "Scruffy",
    "girlfriend": "Sarah Graessley"
}

@app.route('/get-data', methods=['GET'])
def get_data():
    return jsonify(data)

@app.route('/update-number', methods=['PUT'])
def update_number():
    try:
        # Parse JSON payload from the request
        req_data = request.get_json()
        if 'favoriteNumber' not in req_data:
            return jsonify({"error": "Missing 'favoriteNumber' in request"}), 400

        # Validate the new number
        new_number = req_data['favoriteNumber']
        if not isinstance(new_number, int):
            return jsonify({"error": "'favoriteNumber' must be an integer"}), 400

        # Update the favorite number
        data['favoriteNumber'] = new_number
        return jsonify({"message": "Favorite number updated successfully", "updatedData": data}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5003)

