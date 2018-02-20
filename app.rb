require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("pg")

# DB = PG.connect({:dbname => "office"}) #connect to NON-TEST db

DB = PG.connect({:dbname => "office_test"})
