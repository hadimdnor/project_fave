require 'pg'

def run_sql(sql) 
    db =PG.connect(dbname: 'planets_db')
    planets = db.exec(sql)
    db.close
    return planets
end

get '/' do
    planets = run_sql("SELECT * FROM planets ORDER BY id") 
  
    erb :index, locals: {
      planets: planets
    }
  end
  
  
  
  get '/planets/new' do
    erb :new
  end
  
  post "/planets" do
    planets_name = params["name"]
    planets_image = params["image_url"]
    planets_diameter = params["diameter"]
    planets_distance = params["distance"]
    planets_mass = params["mass"]
    planets_moon = params["moon_count"]
  
    run_sql("INSERT INTO planets (name, image_url, diameter, distance, mass, moon_count) VALUES ('#{planets_name}','#{planets_image}','#{planets_diameter}','#{planets_distance}','#{planets_mass}','#{planets_moon}')")
  
    redirect '/'
  
  end