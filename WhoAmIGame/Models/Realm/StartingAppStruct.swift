//
//  StartingAppStruct.swift
//  WhoAmIGame
//
//  Created by Richard on 12.01.2023.
//

import Foundation

struct StartingDatabase{
    
    private var realm : RealmGuess
    private var data: Data
    var readyData : [NormalQuestionPack] = []
    
    init(realm:RealmGuess){
        self.realm = realm
        self.data = Data(jsonData.utf8)
#if DEBUG
        self.data = Data(libaryUploadJSON.utf8)
#endif
        getJSON()
        
    }
    
    mutating func getJSON(){
        let decoder = JSONDecoder()

        do {
               let packs = try decoder.decode([NormalQuestionPack].self, from: data)
               readyData = packs
               addToDatabase()
           } catch DecodingError.dataCorrupted(let context) {
               print("Data corrupted: \(context.debugDescription)")
           } catch DecodingError.keyNotFound(let key, let context) {
               print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
           } catch DecodingError.typeMismatch(let type, let context) {
               print("Type '\(type)' mismatch: \(context.debugDescription)")
           } catch DecodingError.valueNotFound(let type, let context) {
               print("Value of type '\(type)' not found: \(context.debugDescription)")
           } catch {
               print("Unknown error: \(error.localizedDescription)")
           }
    }
    
    func addToDatabase(){
        for pack in readyData{
            realm.addToDatabase(pack: pack)
        }
    }
    
}

let jsonData = """
[
{
     "name" : "Sports",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "sports",
     "names": [
        "Soccer",
        "Basketball",
        "Tennis",
        "Baseball",
        "Golf",
        "Boxing",
        "Cycling",
        "Formula 1",
        "Ice Hockey",
        "Wrestling",
        "Skiing",
        "Snowboarding",
        "Table Tennis",
        "Surfing",
        "Badminton"
     ]
   },
    {
         "name" : "Marvel",
         "author" : "Richie",
         "isFavourite": false,
         "imageStr": "comics",
         "names": [
            "Iron man",
            "Hulk",
            "Black widow",
            "Ant-man",
            "Hawkeye",
            "Captain America",
            "Doctor Strange",
            "Scarlet Witch",
            "The Falcon",
            "The Vision",
            "Quicksilver",
            "Wolverine",
            "Spider-man",
            "Star Lord",
            "Gamora",
            "Drax",
            "Groot",
            "Rocket",
            "Yondu",
            "She Hulk",
            "Shang-chi",
            "Red Skull",
            "Vulture",
            "Loki",
            "Ultron",
            "Black Panther",
            "Mysterio",
            "The Winter Soldier",
            "War machine",
            "Nick Fury",
            "Wong",
            "Thanos",
            "Moon Knight",
            "Proffesor X",
            "Deadpool",
            "Magneto",
            "Mystique",
            "Beast",
            "Blade",
            "Venom",
            "Thor"
         ]
       },{
     "name" : "Movies",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "cinema",
     "names": [
        "Interstellar",
        "Shawshank Redemption",
        "Pulp Fiction",
        "Titanic",
        "Avatar",
        "Great Gatsby",
        "The Grandhotel Budapest",
        "The Godfather",
        "The Dark Knight",
        "Schindlers list",
        "Lord of the rings",
        "Forrest Gump",
        "Fight Club",
        "The Matrix",
        "Seven",
        "The Silence of the Lambs",
        "Saving private Ryan",
        "Back to the future",
        "Psycho",
        "Pianist",
        "Parasite",
        "Untouchable",
        "Toy story",
        "Alien",
        "WALL-E",
        "The Shining",
        "American Beauty",
        "Amadeus",
        "Joker",
        "2001: Space Odyssey",
        "Star wars",
        "Top Gun",
        "Full metal jacket",
        "UP",
        "Die hard",
        "1917",
        "Indiana Jones",
        "The Kid",
        "Truman Show",
        "Jurrasic Park",
        "Intern",
     ]
   },{
     "name" : "Singers",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "celebrit",
     "names": [
        "Michael Jackson",
        "Beyoncé",
        "Adele",
        "Justin Bieber",
        "Ed Sheeran",
        "Taylor Swift",
        "Billie Eilish",
        "The Weeknd",
        "Shawn Mendes",
        "Katty Perry",
        "Lady Gaga",
        "Rihanna",
        "Curt Cobain",
        "Olivia Rodrigo",
        "Harry Styles",
        "Charlie Puth",
        "Shakira",
        "Sia",
        "P!nk",
        "Madonna",
        "Britney Spears",
        "Elvis Presley",
        "Whitney Houston",
        "Elton John",
        "Bob Dylan",
        "Frank Sinatra",
        "Prince",
        "Tom Odell",
        "Marshmello",
        "Alan Walker",
        "Avicii",
        "Ariana Grande",
        "David Bowie",
        "Freddie Mercury",
        "Snoop Dogg",
        "Dr. Dre",
        "Eminem"
     ]
   },{
     "name" : "Cities",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "city",
     "names": [
        "Prague",
        "New York",
        "Paris",
        "London",
        "Rome",
        "Berlin",
        "Los Angeles",
        "San Francisco",
        "Kyjiv",
        "Tokyo",
        "Rio De Janero",
        "Istanbul",
        "Budapest",
        "Moscow",
        "Hong Kong",
        "Madrid",
        "Barcelona",
        "Venice",
        "Dublin",
        "Brussels",
        "Sydney",
        "Bratislava",
        "Mexico city",
        "Las Vegas",
        "Amsterdam",
        "Dubai",
        "Ottawa",
        "Vienna",
        "Warsaw",
        "Bern",
        "Athens",
        "Stockholm",
        "Oslo",
        "Helsinki",
        "Copenhagen"
     ]
   },{
     "name" : "Animals",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "animals",
     "names": [
        "Dog",
        "Cat",
        "Bat",
        "Cow",
        "Duck",
        "Frog",
        "Eagle",
        "Elephant",
        "Giraffe",
        "Panda",
        "Rabbit",
        "Racoon",
        "Tiger",
        "Lion",
        "Wolf",
        "Bear",
        "Snake",
        "Coyote",
        "Shark",
        "Monkey",
        "Donkey",
        "Crocodile",
        "Aligator",
        "Fox",
        "Crab",
        "Mouse",
        "Pig",
        "Chicken",
        "Turkey",
        "Goat",
        "Owl",
        "Sparrow",
        "Zebra"
     ]
   },{
     "name" : "Actors",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "celebrit",
     "names": [
        "Leonardo DiCaprio",
        "Florence Pugh",
        "Morgan Freeman",
        "Denzel Washington",
        "Keanu Reeves",
        "Tom Hanks",
        "Harrison Ford",
        "Julia Roberts",
        "Anthony Hopkins",
        "Sandra Bullock",
        "Jack Nicholson",
        "Bruce Willis",
        "Anne Hathaway",
        "Jackie Chan",
        "Hugh Jackman",
        "Robert De Niro",
        "Halle Berry",
        "Kate Winslet",
        "Zoe Saldana",
        "Mark Wahlberg",
        "Marilyn Monroe",
        "Nicolas Cage",
        "Adam Sandler",
        "George Clooney",
        "Sylvester Stallone",
        "Michelle Pfeiffer",
        "Michael J. Fox",
        "Merryl Streep",
        "Jennifer Lawrence",
        "Bill Murray",
        "Demi Moore",
        "Jennifer Aniston",
        "Brad Pitt",
        "Cameron Diaz",
        "Christian Bale",
        "Matthew McConaughey",
        "Scarlett Johansson",
        "Steve Carell",
        "Winona Ryder",
        "Angelina Jolie",
        "Jim Carrey",
        "Ben Affleck",
        "Emma Watson",
        "Natalie Portman",
        "Willem Dafoe",
        "Charlie Chaplin",
        "Chuck Norris"
     ]
   },{
     "name" : "Bands",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "bands",
     "names": [
        "Nirvana",
        "AC/DC",
        "One Republic",
        "Coldplay",
        "Maroon 5",
        "The Rolling Stones",
        "The Beatles",
        "The Goo Goo Dolls",
        "Imagine Dragons",
        "Queen",
        "One direction",
        "Oasis",
        "Led Zeppelin",
        "U2",
        "Red Hot Chilli Peppers",
        "The Police",
        "Metalicca",
        "Black Sabbath",
        "Guns N'Roses",
        "Lynyrd Skynyrd",
        "Bon Jovi",
        "Foo Fighters",
        "Green Day",
        "Linkin Park",
        "ABBA",
        "The Doors",
        "The Who",
        "The Beach Boys",
        "Pink Floyd",
        "John Lennon",
        "Twenty one pilots",
        "Arctic Monkeys",
        "Rammstein",
        "Bee Gees",
        "Green Day"
     ]
   }
]
"""
let libaryUploadJSON = """
[
   {
     "name" : "Fictional Characters",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "celebrit",
     "names": [
        "Harry Potter",
        "Sherlock Holmes",
        "Darth Vader",
        "Spider-Man",
        "Batman",
        "Superman",
        "Wonder Woman",
        "The Joker",
        "Frodo Baggins",
        "Hannibal Lecter",
        "Willy Wonka",
        "Indiana Jones",
        "Mickey Mouse",
        "Homer Simpson",
        "Lara Croft"
     ]
   },
   {
     "name" : "Mythology",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "fantasy",
     "names": [
        "Zeus",
        "Thor",
        "Hercules",
        "Medusa",
        "Anubis",
        "Poseidon",
        "Aphrodite",
        "Loki",
        "Odin",
        "Persephone",
        "Ra",
        "Fenrir",
        "Hades",
        "Achilles",
        "Minotaur"
     ]
   },
   {
     "name" : "Video Game Characters",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "art",
     "names": [
        "Mario",
        "Luigi",
        "Link",
        "Master Chief",
        "Kratos",
        "Solid Snake",
        "Pikachu",
        "Lara Croft",
        "Geralt of Rivia",
        "Samus Aran",
        "Pac-Man",
        "Nathan Drake",
        "Ezio Auditore",
        "Sonic the Hedgehog",
        "Steve (Minecraft)"
     ]
   },
   {
     "name" : "Sports Legends",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "sports",
     "names": [
        "Michael Jordan",
        "Muhammad Ali",
        "Cristiano Ronaldo",
        "Lionel Messi",
        "Serena Williams",
        "Roger Federer",
        "Usain Bolt",
        "LeBron James",
        "Kobe Bryant",
        "Tom Brady",
        "Pele",
        "Tiger Woods",
        "Diego Maradona",
        "Simone Biles",
        "Lewis Hamilton"
     ]
   },{
     "name" : "Cartoon Characters",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "cartoon",
     "names": [
        "Bugs Bunny",
        "Scooby-Doo",
        "Tom (Tom & Jerry)",
        "Jerry (Tom & Jerry)",
        "Donald Duck",
        "Goofy",
        "SpongeBob SquarePants",
        "Patrick Star",
        "Dexter (Dexter's Laboratory)",
        "Johnny Bravo",
        "Finn (Adventure Time)",
        "Jake (Adventure Time)",
        "Rick Sanchez",
        "Morty Smith",
        "Shaggy (Scooby-Doo)"
     ]
   },
   {
     "name" : "Scientists & Inventors",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "discovery",
     "names": [
        "Albert Einstein",
        "Isaac Newton",
        "Nikola Tesla",
        "Marie Curie",
        "Stephen Hawking",
        "Galileo Galilei",
        "Leonardo da Vinci",
        "Charles Darwin",
        "Alan Turing",
        "Thomas Edison",
        "Benjamin Franklin",
        "Alexander Graham Bell",
        "Johannes Kepler",
        "Carl Sagan",
        "James Watt"
     ]
   },
   {
     "name" : "Superheroes & Villains",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "cinema",
     "names": [
        "Superman",
        "Batman",
        "Wonder Woman",
        "The Flash",
        "Green Lantern",
        "Aquaman",
        "Doctor Doom",
        "Lex Luthor",
        "The Riddler",
        "Harley Quinn",
        "Green Goblin",
        "Doctor Octopus",
        "Black Adam",
        "Captain Marvel",
        "Venom"
     ]
   },
   {
     "name" : "TV Show Characters",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "films",
     "names": [
        "Walter White (Breaking Bad)",
        "Jesse Pinkman (Breaking Bad)",
        "Tony Soprano",
        "Michael Scott (The Office)",
        "Dwight Schrute (The Office)",
        "Chandler Bing (Friends)",
        "Ross Geller (Friends)",
        "Rachel Green (Friends)",
        "Joey Tribbiani (Friends)",
        "Ted Mosby (How I Met Your Mother)",
        "Barney Stinson (How I Met Your Mother)",
        "Daenerys Targaryen (Game of Thrones)",
        "Jon Snow (Game of Thrones)",
        "Arya Stark (Game of Thrones)",
        "Tyrion Lannister (Game of Thrones)"
     ]
   },
   {
     "name" : "Famous Authors",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "literature",
     "names": [
        "William Shakespeare",
        "J.K. Rowling",
        "George R.R. Martin",
        "J.R.R. Tolkien",
        "Agatha Christie",
        "Stephen King",
        "Mark Twain",
        "Jane Austen",
        "Ernest Hemingway",
        "Charles Dickens",
        "Leo Tolstoy",
        "Harper Lee",
        "Oscar Wilde",
        "Edgar Allan Poe",
        "H.P. Lovecraft"
     ]
   },
   {
     "name" : "Fantasy Creatures",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "fantasy",
     "names": [
        "Dragon",
        "Unicorn",
        "Phoenix",
        "Mermaid",
        "Werewolf",
        "Vampire",
        "Griffin",
        "Troll",
        "Elf",
        "Orc",
        "Fairy",
        "Goblin",
        "Kraken",
        "Minotaur",
        "Centaur"
     ]
   }
,
   {
     "name" : "US Presidents",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "presidents",
     "names": [
        "JFK",
        "Ronald Reagan",
        "Barrack Obama",
        "Joe Biden",
        "George W.Bush",
        "Woodrow Wilson",
        "George Washington",
        "Theodor Roosevelt",
        "Thomas Jefferson",
        "Richard Nixon",
        "Abraham Lincoln",
        "F. D. Roosevelt",
        "Dwight Eisenhower",
        "Gerald Ford",
        "Jimmy Carter",
        "Bill Clinton"
     ]
   },
   {
     "name" : "Video Games",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "games",
     "names": [
        "Minecraft",
        "Fortnite",
        "The Legend of Zelda",
        "Super Mario",
        "Call of Duty",
        "League of Legends",
        "World of Warcraft",
        "Halo",
        "Counter-Strike",
        "Grand Theft Auto",
        "Elden Ring",
        "The Witcher 3",
        "Among Us",
        "Pac-Man",
        "Tetris"
     ]
   },
   {
     "name" : "Science & Space",
     "author" : "Richie",
     "isFavourite": false,
     "imageStr": "science",
     "names": [
        "Albert Einstein",
        "Isaac Newton",
        "Galileo Galilei",
        "Marie Curie",
        "Stephen Hawking",
        "Nikola Tesla",
        "Charles Darwin",
        "NASA",
        "Apollo 11",
        "Hubble Telescope",
        "Black Hole",
        "Mars Rover",
        "The Big Bang",
        "Neutron Star"
     ]
   }
]
"""
