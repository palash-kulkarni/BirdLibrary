How to run this application :
- Take clone : git clone git@github.com:palash-kulkarni/BirdLibrary.git
- cd BirdLibrary
- Install all dependencies : bundle
- Start server : RACK_ENV=development rackup

How to run test suit :
- ruby test_suite.rb --verbose

BirdLibrary APIs :
- List all birds :
  - Request : GET /birds
  -  Response :
    - status : 200
    [
      {
        "id": {
          "$oid": "592af8f0e3a974178b7ed3db"
        },
        "name": "Palash",
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true
      },
      {
        "id": {
          "$oid": "592af8fbe3a974178b7ed3dc"
        },
        "name": "Palash",
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true
      }
    ]

- Add a new bird :
  - Request : POST /birds
    body :
      {
        "name": "Palash",
        "continents": ["US"],
        "family" : "Kulkarni",
        "added": "1993/03/15",
        "visible": true
      }
  - Response :
    - If there is no error :
      - status : 201
      {
        "id": {
          "$oid": "592afaede3a974178b7ed3dd"
        },
        "name": "Palash",
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true
      }

    - If there is error :
      - status : 400
      {
        "id": {
          "$oid": "592afb0ae3a974178b7ed3de"
        },
        "name": null,
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true,
        "errors": {
          "name": [
            "can't be blank"
          ]
        }
      }

- Get details on a specific bird :
  - Request : GET /birds/{id}
  - Response :
    - If record found :
      - status : 200
      {
        "id": {
          "$oid": "592afaede3a974178b7ed3dd"
        },
        "name": "Palash",
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true
      }

    - If record not found :
      - status : 404

- Delete a bird by id :
  - Request : DELETE /birds/{id}
  - Response :
    - If record found :
      - status : 200
      {
        "id": {
          "$oid": "592afc55e3a974178b7ed3e0"
        },
        "name": "Palash",
        "family": "Kulkarni",
        "continents": [
          "US"
        ],
        "added": "1993-03-15",
        "visible": true
      }

    - If record not found :
      - status : 404
