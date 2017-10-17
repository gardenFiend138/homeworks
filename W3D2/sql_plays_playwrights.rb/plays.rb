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

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  # Did not call method on self; created unnecessary instance variable;
  # did not save playdbconnection as play; raised unnecessary(?) error
  def self.find_by_title(title)
    # @title = title
    raise "#{self} not in database" unless @title
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?;
    SQL
    #Did not do either of these two things below...
    return nil unless !play.empty?

    Play.new(play.first)
  end

  def find_by_playwright(name)
    # @name = name
    playwright = Playwright.find_by_name(name)
    raise "#{self} not in database" unless playwright
      plays = PlayDBConnection.instance.execute(<<-SQL, @name)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?

      -- SELECT
      --   title
      -- FROM
      --   plays
      -- JOIN playwrights
      -- ON plays.playwright_id = playwrights.id
      -- WHERE
      --   name = ?;
      SQL

      plays,map { |play| Play.new(play) }
  end
end
