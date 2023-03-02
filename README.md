# Oyasumi App (Good Night App)

## Background

We require some restful APIS to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

Implement the model, db migrations, and JSON API.
You can assume that there are only two fields on the users `id` and `name`.

## Getting Started

Please ensure you have installed Ruby in your machine. Then follow these steps:

1. Clone the repo

```
git clone git@github.com:absyah/oyasumi.git
```

2. Setup

   a. Run `bin/setup` to prepare the database, migration, dependencies installation

   b. Run `rails db:seed` to generate dummy `users` and `sleep_records`


3. Run `rails s` to start the server

4. Access the API endpoints throught http://localhost:3000

5. To run the test, simply run `rspec` from terminal.

## Authentication

User registration is not available in this application and the only user attributes that are stored are `id` and `name`. No passwords are stored. To enhance security, the application utilizes a simple authentication mechanism that necessitates the user to send their `id` and `name` through the API request.

Example: 

```
curl GET http://localhost:3000/api/v1/users/sleep_records -u "your_id:your_name"
```

For a successful response payload, every curl request necessitates the correct inclusion of -u "your_id:your_name". otherwise, an error response will be returned instead.

```
{
  "errors": [
    {
      "status": "unauthorized",
      "title": "Not Authorized",
      "detail": "You're not authorized to access this resource."
    }
  ]
}
```


## Endpoints

This application lets users record their sleep duration with the help of a few specific API endpoints to track of their sleep patterns.

### Clock In

#### [POST] /api/v1/clock_in

Create sleep record (clock-in). 

#### Response Payload Data Attributes

| Attributes  | Data Type | Note
| ------------- | ------------- | ------------- |
| `id`  | numeric  |               |
| `user_id`  | numeric  | Foreign key of user |
| `clock_in_at`  | timestamp  | Clock-in timestamp |
| `clock_out_at`  | timestamp  | Clock-out timestamp |
| `sleep_duration`  | numeric  | Sleep duration between clock-in and clock-out in second |
| `user`  | User Object  | User that associated with the sleep record |

#### Sample request

```
curl -X POST http://localhost:3000/api/v1/clock_in -u '1:Shondra Ortiz'
```


#### Sample response

```
{
  "data": {
    "id": "103",
    "type": "sleep_record",
    "attributes": {
      "id": 103,
      "user_id": 1,
      "clock_in_at": "2023-03-02T10:24:50.740Z",
      "clock_out_at": null,
      "sleep_duration": null,
      "user": {
        "id": 1,
        "name": "Shondra Ortiz",
        "created_at": "2023-03-02T07:40:06.143Z",
        "updated_at": "2023-03-02T07:40:06.143Z"
      }
    },
    "relationships": {
      "user": {
        "data": {
          "id": "1",
          "type": "user"
        }
      }
    }
  }
}
```

### Clock Out

Stop sleep record (clock-out). This endpoint calculates `sleep_duration` based on `clock_in_at` and `clock_out_at`

#### [POST] /api/v1/clock_out

#### Response Payload Data Attributes

| Attributes  | Data Type | Note
| ------------- | ------------- | ------------- |
| `id`  | numeric  |               |
| `user_id`  | numeric  | Foreign key of user |
| `clock_in_at`  | timestamp  | Clock-in timestamp |
| `clock_out_at`  | timestamp  | Clock-out timestamp |
| `sleep_duration`  | numeric  | Sleep duration between clock-in and clock-out in second |
| `user`  | User Object  | User that associated with the sleep record |


#### Sample request

```
curl -X POST http://localhost:3000/api/v1/clock_out -u '1:Shondra Ortiz'
```

#### Sample response

```
{
  "data": {
    "id": "103",
    "type": "sleep_record",
    "attributes": {
      "id": 103,
      "user_id": 1,
      "clock_in_at": "2023-03-02T10:24:50.740Z",
      "clock_out_at": "2023-03-02T10:25:48.046Z",
      "sleep_duration": 3600,
      "user": {
        "id": 1,
        "name": "Shondra Ortiz",
        "created_at": "2023-03-02T07:40:06.143Z",
        "updated_at": "2023-03-02T07:40:06.143Z"
      }
    },
    "relationships": {
      "user": {
        "data": {
          "id": "1",
          "type": "user"
        }
      }
    }
  }
}
```

### Sleep Records

#### [GET] api/v1/sleep_records

Returns all sleep records, ordered by created time.

#### Sample request

```
curl http://localhost:3000/api/v1/sleep_records -u '1:Shondra Ortiz'
```

#### Sample response

```
{
  "data": [
    {
      "id": "1",
      "type": "sleep_record",
      "attributes": {
        "id": 1,
        "user_id": 1,
        "clock_in_at": "2023-02-24T07:40:06.146Z",
        "clock_out_at": "2023-02-24T10:40:06.146Z",
        "sleep_duration": 10800,
        "user": {
          "id": 1,
          "name": "Shondra Ortiz",
          "created_at": "2023-03-02T07:40:06.143Z",
          "updated_at": "2023-03-02T07:40:06.143Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "1",
            "type": "user"
          }
        }
      }
    },
    {
      "id": "2",
      "type": "sleep_record",
      "attributes": {
        "id": 2,
        "user_id": 1,
        "clock_in_at": "2023-02-24T07:40:06.184Z",
        "clock_out_at": "2023-02-24T08:40:06.184Z",
        "sleep_duration": 3600,
        "user": {
          "id": 1,
          "name": "Shondra Ortiz",
          "created_at": "2023-03-02T07:40:06.143Z",
          "updated_at": "2023-03-02T07:40:06.143Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "1",
            "type": "user"
          }
        }
      }
    },
    ...
    {
      "id": "101",
      "type": "sleep_record",
      "attributes": {
        "id": 101,
        "user_id": 1,
        "clock_in_at": "2023-03-02T07:42:02.902Z",
        "clock_out_at": "2023-03-02T07:44:42.420Z",
        "sleep_duration": 160,
        "user": {
          "id": 1,
          "name": "Shondra Ortiz",
          "created_at": "2023-03-02T07:40:06.143Z",
          "updated_at": "2023-03-02T07:40:06.143Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "1",
            "type": "user"
          }
        }
      }
    }
  ]
}
```


### Follow User

#### [POST] /api/v1/users/:id/follow

This endpoint allows user to follow other users.

User `id` is required as identifier of the followees.

#### Response payload data attributes

| Attributes  | Data Type | Note
| ------------- | ------------- | ------------- |
| `id`  | numeric  |               |
| `name`  | string  |              |



#### Sample request

```
curl -X POST http://localhost:3000/api/v1/users/2/follow -u '1:Shondra Ortiz'
```



#### Sample response

```
{
  "data": {
    "id": "2",
    "type": "user",
    "attributes": {
      "id": 2,
      "name": "Ivory Greenfelder PhD"
    }
  }
}
```

### Unfollow User

#### [POST] api/v1/users/:id/unfollow

This endpoint allows user to unfollow other users.

User `id` is required as identifier of the followees.

#### Sample request

```
curl -X POST http://localhost:3000/api/v1/users/2/unfollow -u '1:Shondra Ortiz'
```

#### Sample response

```
{
  "data": {
    "id": "2",
    "type": "user",
    "attributes": {
      "id": 2,
      "name": "Ivory Greenfelder PhD"
    }
  }
}
```

### Followees Sleep Records


#### [GET] api/v1/users/sleep_records

Returns past weeks of sleep records from the followees, ordered by `sleep_duration`

#### Sample request

```
curl http://localhost:3000/api/v1/users/sleep_records -u '1:Shondra Ortiz'
```

#### Response Payload Data Attributes

The payload data is the array of sleep record objects.

| Attributes  | Data Type | Note
| ------------- | ------------- | ------------- |
| `id`  | numeric  |               |
| `user_id`  | numeric  | Foreign key of user |
| `clock_in_at`  | timestamp  | Clock-in timestamp |
| `clock_out_at`  | timestamp  | Clock-out timestamp |
| `sleep_duration`  | numeric  | Sleep duration between clock-in and clock-out in second |
| `user`  | User Object  | User that associated with the sleep record |

#### Sample response

```
{
  "data": [
    {
      "id": "16",
      "type": "sleep_record",
      "attributes": {
        "id": 16,
        "user_id": 2,
        "clock_in_at": "2023-02-24T07:40:06.309Z",
        "clock_out_at": "2023-02-24T09:40:06.309Z",
        "sleep_duration": 7200,
        "user": {
          "id": 2,
          "name": "Ivory Greenfelder PhD",
          "created_at": "2023-03-02T07:40:06.260Z",
          "updated_at": "2023-03-02T07:40:06.260Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "2",
            "type": "user"
          }
        }
      }
    },
    {
      "id": "17",
      "type": "sleep_record",
      "attributes": {
        "id": 17,
        "user_id": 2,
        "clock_in_at": "2023-03-01T07:40:06.317Z",
        "clock_out_at": "2023-03-01T09:40:06.317Z",
        "sleep_duration": 7200,
        "user": {
          "id": 2,
          "name": "Ivory Greenfelder PhD",
          "created_at": "2023-03-02T07:40:06.260Z",
          "updated_at": "2023-03-02T07:40:06.260Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "2",
            "type": "user"
          }
        }
      }
    },
    ...
    {
      "id": "19",
      "type": "sleep_record",
      "attributes": {
        "id": 19,
        "user_id": 2,
        "clock_in_at": "2023-02-25T07:40:06.338Z",
        "clock_out_at": "2023-02-25T14:40:06.338Z",
        "sleep_duration": 25200,
        "user": {
          "id": 2,
          "name": "Ivory Greenfelder PhD",
          "created_at": "2023-03-02T07:40:06.260Z",
          "updated_at": "2023-03-02T07:40:06.260Z"
        }
      },
      "relationships": {
        "user": {
          "data": {
            "id": "2",
            "type": "user"
          }
        }
      }
    }
  ]
}
```





