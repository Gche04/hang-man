require 'yaml'


class HangMan
    def initialize(player_name, player_password)
        @computer_selection = ""
        @status = ""
        @count = 0
        @player_name = player_name
        @player_password = player_password
    end

    def start_game
        computer_word
        create_dash
        to_load if File.exist?("/home/gche/repos/hang-man/#{@player_name}#{@player_password}.yml")
        
        puts "status >> #{@status}"
        puts "tries remaining --> #{@count}"
        puts ""

        until @count < 1 || !@status.include?("-")
            puts "guess a letter between a - z"
            puts "to save progess type 'save'"
            puts ""

            user_pick = gets.chomp.downcase
            until user_pick.match? /\A[a-zA-Z'-]*\z/
                puts "guess a letter between a - z"
                user_pick = gets.chomp.downcase
            end

            if user_pick == "save"
                save_progress
                next
            end

            puts ""
            update_status(user_pick)
            
            @count -= 1
            puts "status >> #{@status}"
            puts "tries remaining --> #{@count}"
        end

        if @count < 1
            puts "You lose, you get hanged!!"
            puts "hidden word is #{@computer_selection}"
        else
            puts "You win!!, you are safe!"
        end
        delete_file
    end


    private
    def delete_file
        data = "/home/gche/repos/hang-man/#{@player_name}#{@player_password}.yml"
        File.delete(data) if File.exist?(data) 
    end
    
    def to_load
        puts "to load progess type 'load'"
        reply = gets.chomp.downcase
        load_progress if reply == 'load'
    end

    def save_progress
        game_state = {:computer_selection => @computer_selection,
            :status => @status,
            :count => @count}

        File.open("/home/gche/repos/hang-man/#{@player_name}#{@player_password}.yml", "w") { |file|
            file.write(game_state.to_yaml)
        }
    end

    def load_progress
        dir = "/home/gche/repos/hang-man/#{@player_name}#{@player_password}.yml"
        data = YAML.load(File.read(dir))
        
        @computer_selection = data[:computer_selection]
        @status = data[:status]
        @count = data[:count]
    end

    def computer_word
        dic = "/home/gche/repos/hang-man/google-10000-english-no-swears.txt"
        array = []

        IO.foreach(dic) do |word|
            if word.length > 5 && word.length <= 12
                array << word
            end
        end
        @computer_selection = array.sample
    end

    def create_dash
        for i in 1..@computer_selection.length-1 do
            @status += '-'
        end
        @count = @computer_selection.length + 6
    end

    def update_status(letter)
        for i in 0..@computer_selection.length-1 do
            @status[i] = letter if @computer_selection[i] == letter
        end
    end
end

name = "gche"
pw = "0000"

p = HangMan.new(name, pw)
p.start_game

=begin
class A
    def initialize(string, num)
        @string = string
        @num = num
        @val = ''
    end

    def do
        @val = "#{@string} #{@num}" 
        @num += 1
    end

    def outpt
        puts @val
    end

    def to_s
        "#{@string} #{@num} #{@val}"        
    end

    def ser
        #YAML.dump ({
            #:string => @string,
            #:num => @num,
            #:val => @val
        #})
        ym = {:string => @string, :num => @num}
        File.open("/home/gche/repos/hang-man/#{@string}#{@num}.yml", "w") { |file|
            file.write(ym.to_yaml)
        }

        #File.write("#{@string}#{@num}.txt", ym)
    end

    def self.de_ser
        dr = "/home/gche/repos/hang-man/#{@string}#{@num}.yml"
        data = YAML.load(File.read(dr))
        #p data
        self.new(data[:string], data[:num])
    end
end
=end