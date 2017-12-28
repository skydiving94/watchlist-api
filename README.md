# README

This is a mock Watchlist API which provides the following functionalities.

* Adding, editing, and removing of information of stocks which require login as administrator.

* Viewing the existing stock information which does not require authorization.

I am using httpie for testing in the example usage shown below. 

Example usage shown below.

```fish
$ http :3000/signup name=admin email=admin@admin.com password=admin password_confirmation=admin
Started POST "/signup" for 127.0.0.1 at 2017-12-28 15:30:52 -0600
Processing by AdministratorsController#create as HTML
  Parameters: {"name"=>"admin", "email"=>"admin@admin.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]", "administrator"=>{"name"=>"admin", "email"=>"admin@admin.com"}}
Unpermitted parameter: :administrator
   (0.1ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "administrators" ("name", "email", "password_digest", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "admin"], ["email", "admin@admin.com"], ["password_digest", "$2a$10$PiIE.FX4A.PUe7Gdqqd8me4fpj1Ziv83Q5yd6041okiXVTVl6oQR2"], ["created_at", "2017-12-28 21:30:52.540804"], ["updated_at", "2017-12-28 21:30:52.540804"]]
   (3.8ms)  commit transaction
  Administrator Load (0.1ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."email" = ? LIMIT ?  [["email", "admin@admin.com"], ["LIMIT", 1]]
  CACHE Administrator Load (0.0ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."email" = ? LIMIT ?  [["email", "admin@admin.com"], ["LIMIT", 1]]
Completed 201 Created in 175ms (Views: 0.2ms | ActiveRecord: 4.8ms)


HTTP/1.1 201 Created
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"31b1798fe73c9b70545698709cb0950f"
Transfer-Encoding: chunked
X-Request-Id: 54eaf605-8e53-43c6-82df-20213e6b7f9b
X-Runtime: 0.187804

{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbmlzdHJhdG9yX2lkIjoxLCJleHAiOjE1MTQ1ODMwNTJ9.GnjfZH_mKOgBTJt0_5Whr2-RTAAFMtNCcsB-qj2SfdE",
    "message": "Account created successfully"
}

$ http :3000/auth/login email=admin@admin.com password=admin
Started POST "/auth/login" for 127.0.0.1 at 2017-12-28 15:31:10 -0600
Processing by AuthenticationController#authenticate as HTML
  Parameters: {"email"=>"admin@admin.com", "password"=>"[FILTERED]", "authentication"=>{"email"=>"admin@admin.com", "password"=>"[FILTERED]"}}
Unpermitted parameter: :authentication
Unpermitted parameter: :authentication
  Administrator Load (0.1ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."email" = ? LIMIT ?  [["email", "admin@admin.com"], ["LIMIT", 1]]
  CACHE Administrator Load (0.0ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."email" = ? LIMIT ?  [["email", "admin@admin.com"], ["LIMIT", 1]]
Completed 200 OK in 109ms (Views: 0.2ms | ActiveRecord: 0.1ms)


HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"96e62bf33386096589368b25d4fab40b"
Transfer-Encoding: chunked
X-Request-Id: 003ea984-ebb7-442e-80dc-fdcccdbe571a
X-Runtime: 0.111946

{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbmlzdHJhdG9yX2lkIjoxLCJleHAiOjE1MTQ1ODMwNzB9.8Hz4vX48gwhsYV_I6hheAGs8xKMb3f6wXdKDDbHGKcc"
}

$ http :3000/stocks
Started GET "/stocks" for 127.0.0.1 at 2017-12-28 15:31:41 -0600
Processing by StocksController#index as */*
  Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks"
Completed 200 OK in 7ms (Views: 6.0ms | ActiveRecord: 0.4ms)


HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"6d05bfca57ab8c9962b24b742645c9bd"
Transfer-Encoding: chunked
X-Request-Id: ea8aedb8-1b8c-4807-9c2d-f9f61b6231c1
X-Runtime: 0.009354

[
    {
        "added_by": "1",
        "code": "MSFT",
        "created_at": "2017-12-28T20:13:55.688Z",
        "current": 30.0,
        "difference": 20.0,
        "highest": 400.0,
        "id": 1,
        "lowest": 10.0,
        "name": "Microsoft_Corp",
        "updated_at": "2017-12-28T21:21:38.418Z"
    }
]

$ http POST :3000/stocks/ code=ADS name=Adidas_AG highest=60.10 lowest=60.10 current=60.10 difference=0
Started POST "/stocks/" for 127.0.0.1 at 2017-12-28 15:33:16 -0600
Processing by StocksController#create as HTML
  Parameters: {"code"=>"ADS", "name"=>"Adidas_AG", "highest"=>"60.10", "lowest"=>"60.10", "current"=>"60.10", "difference"=>"0", "stock"=>{"code"=>"ADS", "name"=>"Adidas_AG", "highest"=>"60.10", "lowest"=>"60.10", "current"=>"60.10", "difference"=>"0"}}
Completed 422 Unprocessable Entity in 0ms (Views: 0.1ms | ActiveRecord: 0.0ms)


HTTP/1.1 422 Unprocessable Entity
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
X-Request-Id: a298fa87-f504-42b8-b0e4-f5231a4b8039
X-Runtime: 0.001547

{
    "message": "Missing token"
}

$ http POST :3000/stocks/ code=ADS name=Adidas_AG highest=60.10 lowest=60.10 current=60.10 difference=0 \
Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbmlzdHJhdG9yX2lkIjoxLCJleHAiOjE1MTQ1ODMwNzB9.8Hz4vX48gwhsYV_I6hheAGs8xKMb3f6wXdKDDbHGKcc'
Started POST "/stocks/" for 127.0.0.1 at 2017-12-28 15:33:39 -0600
Processing by StocksController#create as HTML
  Parameters: {"code"=>"ADS", "name"=>"Adidas_AG", "highest"=>"60.10", "lowest"=>"60.10", "current"=>"60.10", "difference"=>"0", "stock"=>{"code"=>"ADS", "name"=>"Adidas_AG", "highest"=>"60.10", "lowest"=>"60.10", "current"=>"60.10", "difference"=>"0"}}
  Administrator Load (0.1ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
Unpermitted parameter: :stock
   (0.0ms)  begin transaction
  SQL (0.6ms)  INSERT INTO "stocks" ("code", "name", "highest", "lowest", "current", "difference", "created_at", "updated_at", "added_by") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)  [["code", "ADS"], ["name", "Adidas_AG"], ["highest", 60.1], ["lowest", 60.1], ["current", 60.1], ["difference", 0.0], ["created_at", "2017-12-28 21:33:39.049995"], ["updated_at", "2017-12-28 21:33:39.049995"], ["added_by", "1"]]
   (4.6ms)  commit transaction
Completed 201 Created in 19ms (Views: 0.7ms | ActiveRecord: 5.3ms)


HTTP/1.1 201 Created
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"ddb9b20590eb119d785bd03d4f6862fb"
Transfer-Encoding: chunked
X-Request-Id: 7113e921-19c1-4a66-95ba-33b5dca6f210
X-Runtime: 0.020508

{
    "added_by": "1",
    "code": "ADS",
    "created_at": "2017-12-28T21:33:39.049Z",
    "current": 60.1,
    "difference": 0.0,
    "highest": 60.1,
    "id": 2,
    "lowest": 60.1,
    "name": "Adidas_AG",
    "updated_at": "2017-12-28T21:33:39.049Z"
}

$ http :3000/stocks
Started GET "/stocks" for 127.0.0.1 at 2017-12-28 15:33:59 -0600
Processing by StocksController#index as */*
  Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks"
Completed 200 OK in 1ms (Views: 1.0ms | ActiveRecord: 0.1ms)


HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"12b7a68ce5b55c23502b0f506b8a05a4"
Transfer-Encoding: chunked
X-Request-Id: f8455518-1bda-403a-9f8c-7546618c5858
X-Runtime: 0.002424

[
    {
        "added_by": "1",
        "code": "MSFT",
        "created_at": "2017-12-28T20:13:55.688Z",
        "current": 30.0,
        "difference": 20.0,
        "highest": 400.0,
        "id": 1,
        "lowest": 10.0,
        "name": "Microsoft_Corp",
        "updated_at": "2017-12-28T21:21:38.418Z"
    },
    {
        "added_by": "1",
        "code": "ADS",
        "created_at": "2017-12-28T21:33:39.049Z",
        "current": 60.1,
        "difference": 0.0,
        "highest": 60.1,
        "id": 2,
        "lowest": 60.1,
        "name": "Adidas_AG",
        "updated_at": "2017-12-28T21:33:39.049Z"
    }
]

$ http :3000/stocks/2
Started GET "/stocks/2" for 127.0.0.1 at 2017-12-28 15:34:02 -0600
Processing by StocksController#show as */*
  Parameters: {"id"=>"2"}
  Stock Load (0.1ms)  SELECT  "stocks".* FROM "stocks" WHERE "stocks"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
Completed 200 OK in 1ms (Views: 0.3ms | ActiveRecord: 0.1ms)


HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"ddb9b20590eb119d785bd03d4f6862fb"
Transfer-Encoding: chunked
X-Request-Id: ec861632-33fe-46d8-a969-e1f84401dd78
X-Runtime: 0.002277

{
    "added_by": "1",
    "code": "ADS",
    "created_at": "2017-12-28T21:33:39.049Z",
    "current": 60.1,
    "difference": 0.0,
    "highest": 60.1,
    "id": 2,
    "lowest": 60.1,
    "name": "Adidas_AG",
    "updated_at": "2017-12-28T21:33:39.049Z"
}

$ http PUT :3000/stocks/2 current=70.2
Started PUT "/stocks/2" for 127.0.0.1 at 2017-12-28 15:34:18 -0600
Processing by StocksController#update as HTML
  Parameters: {"current"=>"70.2", "id"=>"2", "stock"=>{"current"=>"70.2"}}
Completed 422 Unprocessable Entity in 0ms (Views: 0.1ms | ActiveRecord: 0.0ms)


HTTP/1.1 422 Unprocessable Entity
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
X-Request-Id: eb45a5f5-f043-4d8d-84bb-953b35d28908
X-Runtime: 0.001325

{
    "message": "Missing token"
}

$ http PUT :3000/stocks/2 current=70.2 \
                                          Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbmlzdHJhdG9yX2lkIjoxLCJleHAiOjE1MTQ1ODMwNzB9.8Hz4vX48gwhsYV_I6hheAGs8xKMb3f6wXdKDDbHGKcc'
Started PUT "/stocks/2" for 127.0.0.1 at 2017-12-28 15:34:27 -0600
Processing by StocksController#update as HTML
  Parameters: {"current"=>"70.2", "id"=>"2", "stock"=>{"current"=>"70.2"}}
  Administrator Load (0.1ms)  SELECT  "administrators".* FROM "administrators" WHERE "administrators"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Stock Load (0.0ms)  SELECT  "stocks".* FROM "stocks" WHERE "stocks"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
Unpermitted parameters: :id, :stock
   (0.0ms)  begin transaction
  SQL (0.1ms)  UPDATE "stocks" SET "current" = ?, "updated_at" = ? WHERE "stocks"."id" = ?  [["current", 70.2], ["updated_at", "2017-12-28 21:34:27.889513"], ["id", 2]]
   (4.3ms)  commit transaction
difference is 10.100000000000001
   (0.1ms)  begin transaction
  SQL (0.3ms)  UPDATE "stocks" SET "highest" = ?, "difference" = ?, "updated_at" = ? WHERE "stocks"."id" = ?  [["highest", 70.2], ["difference", 10.100000000000001], ["updated_at", "2017-12-28 21:34:27.896731"], ["id", 2]]
   (4.4ms)  commit transaction
Completed 204 No Content in 16ms (ActiveRecord: 9.2ms)


HTTP/1.1 204 No Content
Cache-Control: no-cache
X-Request-Id: 5702eee3-2a9c-42c5-8bae-6700e1a6bc53
X-Runtime: 0.017024



$ http :3000/stocks
Started GET "/stocks" for 127.0.0.1 at 2017-12-28 15:34:36 -0600
Processing by StocksController#index as */*
  Stock Load (0.1ms)  SELECT "stocks".* FROM "stocks"
Completed 200 OK in 1ms (Views: 0.9ms | ActiveRecord: 0.1ms)


HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"5d09356b45b8e954e301f416843ba201"
Transfer-Encoding: chunked
X-Request-Id: ecb6ae08-5500-4427-96d8-9706ed9aad3f
X-Runtime: 0.002088

[
    {
        "added_by": "1",
        "code": "MSFT",
        "created_at": "2017-12-28T20:13:55.688Z",
        "current": 30.0,
        "difference": 20.0,
        "highest": 400.0,
        "id": 1,
        "lowest": 10.0,
        "name": "Microsoft_Corp",
        "updated_at": "2017-12-28T21:21:38.418Z"
    },
    {
        "added_by": "1",
        "code": "ADS",
        "created_at": "2017-12-28T21:33:39.049Z",
        "current": 70.2,
        "difference": 10.100000000000001,
        "highest": 70.2,
        "id": 2,
        "lowest": 60.1,
        "name": "Adidas_AG",
        "updated_at": "2017-12-28T21:34:27.896Z"
    }
]
```
