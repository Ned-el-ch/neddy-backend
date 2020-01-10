# categories = [

# 	{
# 		type: "Engineering"
# 		sub_categories: ["Chemical", "Biochemical", "Mechanical", "architecture", "Electrical", "Environmental", "Civil"]
# 	},
# 	{
# 		type: "Science"
# 		sub_categories: ["Biology", "Physics", "Chemistry", "Astronomy", "Space", "Maths", "Computer Science", "Data Science", "Statistics", "Medicine", "Dentistry", "Botany", "Zoology", "Meteorology", "Oceanography", "Ecology", "Geology"]
# 	},
# 	{
# 		type: "Politics"
# 		sub_categories: ["World", "Europe", "Asia", "Africa", "North America", "South America","Australia",  "Western", "Eastern", "Middle East"]
# 	},
# 	{
# 		type: "Game Development"
# 		sub_categories: ["Game Design", "Unity 3D", "Clickteam Fusion 2.5", "Godot", "Indie", "AAA"]
# 	},
# 	{
# 		type: "Programming"
# 		sub_categories: ["JavaScript", "Java", "React", "Ruby on Rails", "APIs", "OOP", "TDD", "BDD", "Netcode", ".NET", "C#", "Redux", "Python", "SQL", "PostreSQL", "Databases", "Frontend", "Backend"]
# 	},

# ]

# categories.each do |category|

# 	Category.create(title: category.type)
# 	puts category.type

# 	category.sub_categories.each do |sub_category|

# 		Category.create(title: sub_category)
# 		puts sub_category

# 	end

# end

categories = ["Science", "Engineering", "Programming", "Art", "Lifestyle", "Politics", "Game Development"]

categories.each do |title|

	Category.create(title: title)

end