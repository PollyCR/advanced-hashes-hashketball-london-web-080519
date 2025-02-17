def game_hash
  {    home: 
  { team_name: 'Brooklyn Nets',
            colors: %w[Black White],
            players: [
              { player_name: 'Alan Anderson',
                number: 0,
                shoe: 16,
                points: 22,
                rebounds: 12,
                assists: 12,
                steals: 3,
                blocks: 1,
                slam_dunks: 1 },
              { player_name: 'Reggie Evans',
                number: 30,
                shoe: 14,
                points: 12,
                rebounds: 12,
                assists: 12,
                steals: 12,
                blocks: 12,
                slam_dunks: 7 },
              { player_name: 'Brook Lopez',
                number: 11,
                shoe: 17,
                points: 17,
                rebounds: 19,
                assists: 10,
                steals: 3,
                blocks: 1,
                slam_dunks: 15 },
              { player_name: 'Mason Plumlee',
                number: 1,
                shoe: 19,
                points: 26,
                rebounds: 11,
                assists: 6,
                steals: 3,
                blocks: 8,
                slam_dunks: 5 },
              { player_name: 'Jason Terry',
                number: 31,
                shoe: 15,
                points: 19,
                rebounds: 2,
                assists: 2,
                steals: 4,
                blocks: 11,
                slam_dunks: 1 }
            ] }, 
away: { team_name: 'Charlotte Hornets',
        colors: %w[Turquoise Purple],
        players: [
              { player_name: 'Jeff Adrien',
                number: 4,
                shoe: 18,
                points: 10,
                rebounds: 1,
                assists: 1,
                steals: 2,
                blocks: 7,
                slam_dunks: 2 },
              { player_name: 'Bismack Biyombo',
                number: 0,
                shoe: 16,
                points: 12,
                rebounds: 4,
                assists: 7,
                steals: 22,
                blocks: 15,
                slam_dunks: 10 },
              { player_name: 'DeSagna Diop',
                number: 2,
                shoe: 14,
                points: 24,
                rebounds: 12,
                assists: 12,
                steals: 4,
                blocks: 5,
                slam_dunks: 5 },
              { player_name: 'Ben Gordon',
                number: 8,
                shoe: 15,
                points: 33,
                rebounds: 3,
                assists: 2,
                steals: 1,
                blocks: 1,
                slam_dunks: 0 },
              { player_name: 'Kemba Walker',
                number: 33,
                shoe: 15,
                points: 6,
                rebounds: 12,
                assists: 12,
                steals: 7,
                blocks: 5,
                slam_dunks: 12 }
            ] }
  }
end

def num_points_scored(name)
  #iterate through game hash created above. 
  game_hash.each do |place, team|
    #iterate through team hash 
    team.each do |attribute, data|
      #keep looking until player is found in hash. Data is what's inside  
      next unless attribute == :players
      data.each do |player|
        #Found player -- ask to return player's point score once the name value matches given argument
        return player[:points] if player[:player_name] == name
      end
    end
  end
end

def shoe_size(name)
  #iterate through hash to look for matching value
  game_hash.each do |place, team|
    #iterate through team hash to find player
    team.each do |attribute, data|
      #stop once player name matches
      next unless attribute == :players
#iterate through player data
      data.each do |player|
        #found player - return player's shoe size once name value matches given argument 
        return player[:shoe] if player[:player_name] == name
      end
    end
  end
end

def team_colors(team_name)
    #iterate through hash to look for matching value
  game_hash.each do |place, team|
     #found team - return team colours once name value matches given argument 
    return game_hash[place][:colors] if team[:team_name] == team_name
  end
end

def team_names
  game_hash.collect do |place, team|
    team[:team_name]
  end
end

def player_numbers(team_name) 
  #create new array to store numbers
  nums = []
  #work through game hash to find team name 
  game_hash.each do |place, team|
    next unless team[:team_name] == team_name
#work through team hash to find players hash 
    team.each do |attribute, data|
      next unless attribute == :players
#work through data hash 
      data.each do |data|
        #shovel each player number into new array
        nums << data[:number]
      end
    end
  end
  nums
end

def player_stats(name)
  #create new hash to store player stats 
  stats_hash = {}
  #collect applies the block of code to all items and returns the new array
  game_hash.collect do |place, team|
    #searches through team hash to find players hash 
    team.each do |attribute, data|
      next unless attribute == :players
#searches through players hash to find individual player
      game_hash[place][attribute].each do |player|
        next unless player[:player_name] == name
#populates stats hash with player key/value pairs for which code evaluates to true
        stats_hash = player.delete_if do |key, value|
          key == :player_name
        end
      end
    end
  end
  stats_hash
end

def big_shoe_rebounds
  #set baseline values 
  biggest_shoe = 0
  num_rebounds = 0
#iterate through game hash to find player data 
  game_hash.each do |team, game_data|
    game_data[:players].each do |player|
      #searches each player's shoe size value in turn. If the shoe size being evaluated is larger than baseline, sets new value to that. For subsequent iterations, if the shoe size being evaluated is larger than the previous value, changes the value again. 
      if player[:shoe] > biggest_shoe
        biggest_shoe = player[:shoe]
        num_rebounds = player[:rebounds]
      end
    end
  end

  num_rebounds
end

#bonus method to refactor iterating through players to evaluate highest stat. 
def player_iterator(name, stat)
  #iterate through game hash
  game_hash.each do |team, game_data|
    #iterate through team hash to find player data
    game_data[:players].each do |player|
      return player[stat] if player[:player_name] == name
    end
  end
end

def player_with_most_of(stat)
  #set baseline values 
  player_name = nil
  stat_value = 0
#iterate through game hash 
  game_hash.each do |team, game_data|
    #iterate through team hash to find player hash 
    game_data[:players].each do |player|
      if player[stat].is_a? String
        #iterate through player names and evaluates them against stat value OR player name length, then changes value if current one is higher
        if player[stat].length > stat_value
          stat_value = player[stat].length
          player_name = player[:player_name]
        end
      elsif player[stat] > stat_value
        stat_value = player[stat]
        player_name = player[:player_name]
      end
    end
  end

  player_name
end

#employs the player_with_most_of method to find the :points key and return player with highest number of points
def most_points_scored
  player_with_most_of(:points)
end

def winning_team
# Create new hash to store scores 

  scores = { 'Brooklyn Nets' => 0, 'Charlotte Hornets' => 0 }

#iterate through game hash 
  game_hash.each do |team, game_data|
    #iterate through player hash 
    game_data[:players].each do |player|
      #adds to specific branch of nested hash according to team name and uses player iterator to add number of points to that key as a value 
      scores[game_data[:team_name]] += player_iterator(player[:player_name], :points)
    end
  end

  scores.max_by { |key, value| value }.first
end

def player_with_longest_name
  player_with_most_of(:player_name)
end

# # Super Bonus Question

def long_name_steals_a_ton?
  #asks whether the player who the player_with_most_of method returns as having the highest number of steals is equal to the player returned as having the longest name
  player_with_most_of(:steals) == player_with_most_of(:player_name)
end