require_relative('../db/sql_runner.rb')

class Artist
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def albums()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album)  }
  end

  def save()
    sql = "INSERT INTO artists (
    name
    )
    VALUES(
      $1
      )
      RETURNING *;
      "
      values = [@name]
      results = SqlRunner.run(sql, values)
      @id = results[0]['id'].to_i
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    results = SqlRunner.run(sql)
    return results.map {|artist| Artist.new(artist)}
  end
end
