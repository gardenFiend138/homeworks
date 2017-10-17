# All corrections made in comments; Definitely did not come close for most
# of them...

#  ***************   ORM == 'Object Relational Mapping'   **************

require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Playwright
  attr_accessor :id, :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("Select * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  #Looked to plays.rb for this template; do we still use the condition @id?
  # Do we only pass in @name and @birth_year? I couldn't get the methods
  # to work in pry...This is just like the solution, so I'm not sure why
  # it's not working...
  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?);
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?;
    SQL
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?;
    SQL
    return nil unless !person.empty?

    Playwright.new(person, first)
  end

  # def find_by_name(name)
  #   @name = name
  #   raise "#{self} not in database" unless @name
  #   PlayDBConnection.instance.execute(<<-SQL, @name)
  #     SELECT
  #       name
  #     FROM
  #       playwrights
  #     WHERE
  #       name = ?;
  #   SQL
  # end

  def get_plays(name)
    raise "#{self} not in databse" unless @id
    plays = PlayDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        plays
      WHERE
        id = ?;
    SQL
    plays.map { |play| Play.new(play) }
  end
  # def get_plays(name)
  #   @name = name
  #   raise "#{self} not in database" unless @name
  #   PlayDBConnection.instance.execute(<<-SQL, @name)
  #     SELECT
  #       title
  #     FROM
  #      plays
  #     JOIN playwrights
  #     ON plays.playwright_id = playwrights.id
  #     WHERE
  #       @name = name;
  #   SQL
  # end

end
