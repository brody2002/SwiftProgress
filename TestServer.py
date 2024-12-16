from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/get-data', methods=['GET'])
def get_data():
    data = {
        "name": "Brody",
        "favoriteNumber": 711,
        "dog": "Scruffy",
        "girlfriend": "Sarah Graessley"
    }
    return jsonify(data)

if __name__ == '__main__':
        app.run(debug=True, host='0.0.0.0', port=5003)

