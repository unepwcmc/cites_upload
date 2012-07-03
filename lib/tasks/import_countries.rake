namespace :import do

  desc 'Import countries from CSV to countries table'
  task :countries => :environment do
    puts "Importing countries..."
    ActiveRecord::Base.connection.execute('CREATE TABLE tmp_countries(name varchar);')
    psql = <<-PSQL
\\COPY tmp_countries (name)
      FROM '#{Rails.root}/lib/assets/files/countries.csv'
      WITH DELIMITER ','
      CSV HEADER;

      INSERT INTO countries(name, created_at, updated_at)
      SELECT DISTINCT name, current_date, current_date
      FROM tmp_countries;
    PSQL
    db_conf = YAML.load(File.open(Rails.root+ "config/database.yml"))[Rails.env]
    system("export PGPASSWORD=#{db_conf['password']} && psql -h #{db_conf["host"]||"localhost"} -U#{db_conf["username"]} -c \"#{psql}\" #{db_conf["database"]}")
    puts "Countries have been imported"
    ActiveRecord::Base.connection.execute('DROP TABLE tmp_countries;')
  end
end
