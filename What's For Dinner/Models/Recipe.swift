//
//  Recipe.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 17.04.2022.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    var isFavorite: Bool = false
    
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions: [Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    // Another intitializer for empty recipes for user to edit later:
    init() {
        self.init(mainInformation: MainInformation(name: "", description: "", author: "", category: .breakfast),
                  ingredients: [],
                  directions: [])
      }
    
    var isVaid: Bool {
        mainInformation.isValid && !ingredients.isEmpty && !directions.isEmpty
    }
}

struct MainInformation {
    var name: String
    var description: String
    var author: String
    var category: Category
    
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !author.isEmpty
    }
}

struct Ingredient: RecipeComponent {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuantity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) of \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) of \(name)"
            }
        }
    }
    
    enum Unit: String, CaseIterable {
        case g = "Grams"
        case oz = "Ounces"
        case cups = "🥛 Cups"
        case tbs = "🥄 Tablespoons"
        case tsp = "🥄 Teaspoons"
        case none = "No units"
        
        var singularName: String {
            String(rawValue.dropLast())
        }
    }
    
    init(name: String, quantity: Double, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    // Another intitializer for empty recipes to edit later:
    init() {
        self.init(name: "", quantity: 1, unit: .none)
    }
    
}

struct Direction: RecipeComponent {
    var description: String
    var isOptional: Bool
    
    init(description: String, isOptional: Bool) {
        self.description = description
        self.isOptional = isOptional
    }
    
    // Another intitializer for empty recipes to edit later:
    init() {
        self.init(description: "", isOptional: false)
    }
}



// Test recipes:

extension Recipe {
  static let testRecipes: [Recipe] = [
    Recipe(mainInformation: MainInformation(name: "Dad's Mashed Potatoes",
                                            description: "Buttery salty mashed potatoes!",
                                            author: "Josh",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Potatoes", quantity: 454, unit: .g),
            Ingredient(name: "Butter", quantity: 1, unit: .tbs),
            Ingredient(name: "Milk", quantity: 0.5, unit: .cups),
            Ingredient(name: "Salt", quantity: 2, unit: .tsp)
           ],
           directions:  [
            Direction(description: "Put peeled potatoes in water and bring to boil ~15 min (once you can cut them easily", isOptional: false),
            Direction(description: "In the meantime, Soften the butter by heading in a microwave for 30 seconds", isOptional: false),
            Direction(description: "Drain the now soft potatoes", isOptional: false),
            Direction(description: "Mix vigorously with milk, salt, and butter", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Beet and Apple Salad",
                                            description: "Light and refreshing summer salad made of beets, apples and fresh mint",
                                            author: "Deb Szajngarten",
                                            category: .lunch),
           ingredients: [
            Ingredient(name: "Large beets chopped into a large dice", quantity: 3, unit: .none),
            Ingredient(name: "Large apples chopped into a large dice", quantity: 2, unit: .none),
            Ingredient(name: "Lemon zest", quantity: 0.5, unit: .tbs),
            Ingredient(name: "Lemon juice", quantity: 1.5, unit: .tbs),
            Ingredient(name: "Olive Oil", quantity: 1, unit: .tsp),
            Ingredient(name: "Salt and Pepper to taste", quantity: 1, unit: .none)
           ],
           directions:  [
            Direction(description: "Cook the beets", isOptional: false),
            Direction(description: "Sous vide the beets - To accomplish this, add beets to food safe plastic storage bags with apples, tsp of course stal and teaspoon of ground black pepper", isOptional: true),
            Direction(description: "Then vacuum seal the bag of beets and submerge into 185F water until tender; if no vacuum seal, weigh them down so they submerge", isOptional: true),
            Direction(description: "Alternately, you can steam the beets until tender or roast them in a 400F oven until tender", isOptional: false),
            Direction(description: "Once cooked, the skins will come off quite easily (gloves are preferred)", isOptional: false),
            Direction(description: "Wait until cooled completely, then cut beets into a medium dice", isOptional: false),
            Direction(description: "Peel and medium dice the apples", isOptional: false),
            Direction(description: "Chiffonade the mint", isOptional: false),
            Direction(description: "Combine all ingredients with lemon juice and olive oil and serve", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Braised Beef Brisket",
                                            description: "Slow cooked brisket in a savory braise that makes an amazing gravy.",
                                            author: "Deb Szajngarten",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Brisket", quantity: 1815, unit: .g),
            Ingredient(name: "Large red onion", quantity: 1, unit: .none),
            Ingredient(name: "Garlic, minced", quantity: 6, unit: .none),
            Ingredient(name: "Large Carrot", quantity: 1, unit: .none),
            Ingredient(name: "Parsnip", quantity: 1, unit: .none),
            Ingredient(name: "Stalks Celery", quantity: 3, unit: .none),
            Ingredient(name: "Caul, Duck, or Chicken Fat", quantity: 3, unit: .tbs),
            Ingredient(name: "Bay Leaves", quantity: 2, unit: .none),
            Ingredient(name: "Apple Cider Vinegar", quantity: 0.33, unit: .cups),
            Ingredient(name: "Red Wine", quantity: 1, unit: .cups),
            Ingredient(name: "Jar/Can of Tomato Paste", quantity: 1, unit: .none),
            Ingredient(name: "Spoonful of Honey", quantity: 1, unit: .none),
            Ingredient(name: "Chicken Stock", quantity: 30, unit: .oz),
           ],
           directions:  [
            Direction(description: "In a small bowl, combine the honey, tomato paste and wine, and mix into paste", isOptional: false),
            Direction(description: "In an oval dutch oven, melt the fat over a medium to high heat.", isOptional: false),
            Direction(description: "Sear the brisket on both side then remove the heat", isOptional: false),
            Direction(description: "Add a bit more fat or vegetable oil and sear the vegetables until the onions become translucent", isOptional: false),
            Direction(description: "Add the wine mixture, return the beef to the pot, add the chicken stock until it come 1/2 way up the beef", isOptional: false),
            Direction(description: "Close the lid and bake at 250 until fork tender (4-6 hrs)", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Best Brownies Ever",
                                            description: "Five simple ingredients make these brownies easy to make and delicious to consume!",
                                            author: "Pam Broda",
                                            category: .dessert),
           ingredients: [
            Ingredient(name: "Condensed Milk", quantity: 14, unit: .oz),
            Ingredient(name: "Crushed Graham Crackers", quantity: 2.5, unit: .cups),
            Ingredient(name: "Bag of Chocolate Chips (Semi-Sweet)", quantity: 12, unit: .oz),
            Ingredient(name: "Vanilla Extract", quantity: 1, unit: .tsp),
            Ingredient(name: "Milk", quantity: 2, unit: .tbs)
           ],
           directions:  [
            Direction(description: "Preheat oven to 350 degrees F", isOptional: false),
            Direction(description: "Crush graham cracker in large mixing bowl with clean hands, not in food processor! (Make sure pieces are chunky)", isOptional: false),
            Direction(description: "Smei-melt the chocolate chips, keep some in tact", isOptional: false),
            Direction(description: "Stir in rest of ingredients (vanilla, milk)", isOptional: false),
            Direction(description: "Grease an 8x8 in. pan with butter and pour in brownie mix", isOptional: false),
            Direction(description: "Bake for 23-25min - DO NOT OVERBAKE", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Omelet and Greens",
                                            description: "Quick, crafty omelet with greens!",
                                            author: "Taylor Murray",
                                            category: .breakfast),
           ingredients: [
            Ingredient(name: "Olive Oil", quantity: 3, unit: .tbs),
            Ingredient(name: "Onion, finely chopped", quantity: 1, unit: .none),
            Ingredient(name: "Large Eggs", quantity: 8, unit: .none),
            Ingredient(name: "Kosher Salt", quantity: 1, unit: .none),
            Ingredient(name: "Unsalted Butter", quantity: 2, unit: .tbs),
            Ingredient(name: "Parmesan, finely grated", quantity: 1, unit: .oz),
            Ingredient(name: "Fresh Lemon Juice", quantity: 2, unit: .tbs),
            Ingredient(name: "Baby Spinach", quantity: 3, unit: .oz)
           ],
           directions:  [
            Direction(description: "Heat 1 tbsp olive oil in large non stick skillet on medium heat", isOptional: false),
            Direction(description: "Add onions until tender, about 6 minutes then transfer to a small bowl", isOptional: false),
            Direction(description: "In a different bowl, whisk eggs, 1 tbs water, and 0.5 tsp salt", isOptional: false),
            Direction(description: "Return skillet to medium heat and butter", isOptional: false),
            Direction(description: "Add eggs, constantly stirring until eggs partially set", isOptional: false),
            Direction(description: "Turn heat to low and cover", isOptional: false),
            Direction(description: "Continue cooking till eggs are just set, 4-5min", isOptional: false),
            Direction(description: "Top with parmesan and onions, fold in half", isOptional: true),
            Direction(description: "In a medium bowl, whisk lemon juice, 2 tbs olive oil, toss with spinach and serve with omelet", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Vegetarian Chili",
                                            description: "Warm, comforting, and filling vegetarian chili",
                                            author: "Makeinze Gore",
                                            category: .lunch),
           ingredients: [
            Ingredient(name: "Onions, Chopped", quantity: 1, unit: .none),
            Ingredient(name: "Red Bell Pepper, Chopped", quantity: 1, unit: .none),
            Ingredient(name: "Carrots, peeled and finely chopped", quantity: 1, unit: .none),
            Ingredient(name: "Cloves Garlic, Minced", quantity: 3, unit: .none),
            Ingredient(name: "Jalapeno, finely chopped", quantity: 1, unit: .none),
            Ingredient(name: "Tomato Paste", quantity: 2, unit: .tbs),
            Ingredient(name: "Can of Pinto Beans, Drained and Rinsed", quantity: 1, unit: .none),
            Ingredient(name: "Can of Black Beans, Drained and Rinsed", quantity: 1, unit: .none),
            Ingredient(name: "Can of Kidney Beans, Drained and Rinsed", quantity: 1, unit: .none),
            Ingredient(name: "Can of Fire Roasted Tomatoes", quantity: 1, unit: .none),
            Ingredient(name: "Vegetable Broth", quantity: 3, unit: .cups),
            Ingredient(name: "Chili Powder", quantity: 2, unit: .tbs),
            Ingredient(name: "Cumin", quantity: 1, unit: .tbs),
            Ingredient(name: "Oregano", quantity: 2, unit: .tsp),
            Ingredient(name: "Kosher Salt", quantity: 1, unit: .none),
            Ingredient(name: "Ground Black Pepper", quantity: 1, unit: .none),
            Ingredient(name: "Shredded Cheddar", quantity: 1, unit: .none),
            Ingredient(name: "Sour Cream", quantity: 1, unit: .none),
            Ingredient(name: "Cilantro", quantity: 1, unit: .none)
           ],
           directions:  [
            Direction(description: "In a large pot over medium heat, heat olive oil then add onions, bell peppers and carrots", isOptional: false),
            Direction(description: "Saute until soft - about 5 min", isOptional: false),
            Direction(description: "Add garlic and jalapeno and cool until fragrant - about 1 min", isOptional: false),
            Direction(description: "Add tomato paste and stir to coat vegetables", isOptional: false),
            Direction(description: "Add tomatoes, beans, broth, and seasonings", isOptional: false),
            Direction(description: "Season with salt and pepper to desire", isOptional: false),
            Direction(description: "Bring to a boil then reduce heat and let simmer for 30min", isOptional: false),
            Direction(description: "Serve with cheese, sour cream, and cilantro", isOptional: true)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Classic Shrimp Scampi",
                                            description: "Simple, delicate shrimp bedded in a delicious set of pasta that will melt your tastebuds!",
                                            author: "Sarah Taller",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Kosher Salt", quantity: 1, unit: .none),
            Ingredient(name: "Linguine", quantity: 12, unit: .oz),
            Ingredient(name: "Large shrimp, peeled", quantity: 20, unit: .oz),
            Ingredient(name: "Extra-virgin olive oil", quantity: 0.33, unit: .cups),
            Ingredient(name: "Cloves garlic, minced", quantity: 5, unit: .none),
            Ingredient(name: "Red pepper flakes", quantity: 0.5, unit: .tsp),
            Ingredient(name: "White Wine", quantity: 0.33, unit: .cups),
            Ingredient(name: "Lemons Squeezed + Wedges", quantity: 0.5, unit: .none),
            Ingredient(name: "Unsalted butter, cut into pieces", quantity: 4, unit: .tbs),
            Ingredient(name: "Finely Chopped Fresh Parsley", quantity: 0.25, unit: .cups)
           ],
           directions:  [
            Direction(description: "Bring large pot of salt water to a boil", isOptional: false),
            Direction(description: "Add the linguini and cook as label directs", isOptional: false),
            Direction(description: "Reserve 1 cup cooking water, then drain", isOptional: false),
            Direction(description: "Season shrimp with salt", isOptional: false),
            Direction(description: "Heat olive oil in large skillet over medium-heat", isOptional: false),
            Direction(description: "Add garlic and red pepper flakes and cook until garlic is golden, 30sec-1min", isOptional: false),
            Direction(description: "Add shrimp and cook, stirring occasionally, until pink and just cooked through: 1-2min per side", isOptional: false),
            Direction(description: "Remove shrimp from plate", isOptional: false),
            Direction(description: "Add the wine and lemon juice to skillet and simmer slightly reduced, 2 min", isOptional: false),
            Direction(description: "Return shrimp and any juices from place to skillet alongside linguine, butter, and a 0.5 cup of cooking water", isOptional: false),
            Direction(description: "Continue to cook, tossing, until the butter is melted and the shrimp is hot, about 2 min", isOptional: false),
            Direction(description: "Add water as needed", isOptional: false),
            Direction(description: "Season with salt, stir in parsley", isOptional: false),
            Direction(description: "Serve with lemon wedges!", isOptional: true)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Chocolate Billionaires",
                                            description: "Chocolate and caramel candies that are to die for!",
                                            author: "Jack B",
                                            category: .dessert),
           ingredients: [
            Ingredient(name: "1 package of caramels", quantity: 14, unit: .oz),
            Ingredient(name: "Water", quantity: 3, unit: .tbs),
            Ingredient(name: "Chopped Pecans", quantity: 1.25, unit: .cups),
            Ingredient(name: "Rice Krispies", quantity: 1, unit: .cups),
            Ingredient(name: "Milk Chocolate Chips", quantity: 3, unit: .cups),
            Ingredient(name: "Shortening", quantity: 1.25, unit: .tsp)
           ],
           directions:  [
            Direction(description: "Line 2 baking sheets with waxed paper", isOptional: false),
            Direction(description: "Grease paper and set aside", isOptional: false),
            Direction(description: "In a large heavy saucepan, combine caramel and water", isOptional: false),
            Direction(description: "Cook and stir over low heat until smooth", isOptional: false),
            Direction(description: "Stir in pecans and cereal until coated", isOptional: false),
            Direction(description: "Drops teaspoons onto prepared pans", isOptional: false),
            Direction(description: "Refrigerate for 10 mins or until firm", isOptional: false),
            Direction(description: "Melt chocolate chips and shortening", isOptional: false),
            Direction(description: "Stir until smooth", isOptional: false),
            Direction(description: "Dip candy into chocolate, coating all sides", isOptional: false),
            Direction(description: "Allow excess to drip off", isOptional: false),
            Direction(description: "Place on prepared pans and refrigerate until set", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Mac & Cheese",
                                            description: "Macaroni & Cheese",
                                            author: "Travis B",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Elbow Macaroni", quantity: 12, unit: .oz),
            Ingredient(name: "Butter, divided", quantity: 2, unit: .tbs),
            Ingredient(name: "Small onion, chopped", quantity: 1, unit: .none),
            Ingredient(name: "Milk, divided", quantity: 4, unit: .cups),
            Ingredient(name: "Flour", quantity: 0.33, unit: .cups),
            Ingredient(name: "Bay Leaves", quantity: 2, unit: .none),
            Ingredient(name: "Thyme", quantity: 0.5, unit: .tsp),
            Ingredient(name: "Pepper", quantity: 1, unit: .tsp),
            Ingredient(name: "Salt", quantity: 1, unit: .tsp),
            Ingredient(name: "Shredded Sharp Cheddar", quantity: 1, unit: .cups)
           ],
           directions:  [
            Direction(description: "Heat oven to 375. Lightly coat 13 x 9 baking dish with vegetable cooking spray", isOptional: false),
            Direction(description: "Start to cook pasta", isOptional: false),
            Direction(description: "Meanwhile, melt 1 tablespoon butter in a saucepan over medium heat. Add onion, and cook until softened, about 3 min.", isOptional: false),
            Direction(description: "Whisk together 1/2 cup milk and flour until smooth", isOptional: false),
            Direction(description: "Add milk texture to onion, then whisk in remaining 3.5 cups milk, bay leaves, thyme, salt, and pepper.", isOptional: false),
            Direction(description: "Cook over medium-low heat 10-12min, stirring occasionally, until slight thickened", isOptional: false),
            Direction(description: "With slotted spoon, remove bay leaves. Stir in cheese until melted", isOptional: false),
            Direction(description: "Drain pasta and stir into cheese mixture", isOptional: false),
            Direction(description: "Drain pasta and stir into cheese mixture. Pour into prepared dish and bake for 35 minutes, or until cheese is bubbly", isOptional: false),
            Direction(description: "Eat!", isOptional: true)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Veggie Soup",
                                            description: "Vegetable Soup",
                                            author: "Travis B",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Yellow Onion, diced", quantity: 1, unit: .none),
            Ingredient(name: "Cloves Garlic, minced", quantity: 4, unit: .none),
            Ingredient(name: "Stock Celery, diced", quantity: 1, unit: .none),
            Ingredient(name: "Carrots, shredded", quantity: 1, unit: .cups),
            Ingredient(name: "Broccoli florets", quantity: 1, unit: .cups),
            Ingredient(name: "Zucchini, cubed", quantity: 1, unit: .none),
            Ingredient(name: "Spinach", quantity: 3, unit: .cups),
            Ingredient(name: "Potato skinned and cubed", quantity: 1, unit: .none),
            Ingredient(name: "Can of Kidney Beans", quantity: 1, unit: .none),
            Ingredient(name: "Box Vegetable Stock", quantity: 1, unit: .none),
            Ingredient(name: "Can Diced Tomatoes", quantity: 1, unit: .none)
           ],
           directions:  [
            Direction(description: "Cook onion and garlic on high heat until onion is translucent, about 5 min", isOptional: false),
            Direction(description: "Add celery, carrots, parsley, and cook for 5-7min", isOptional: false),
            Direction(description: "Add can diced tomatoes, vegetable stock, and potato. Bring to boil and let simmer for 45min", isOptional: false),
            Direction(description: "Add broccoli, zucchini, and kidney beans. Bring back to boil and then let simmer for 15 more min", isOptional: false),
            Direction(description: "Serve with spinach and parmesan cheese", isOptional: true)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "White Clam Sauce",
                                            description: "A simple recipe for quick comfort food",
                                            author: "Henry Minden",
                                            category: .dinner),
           ingredients: [
            Ingredient(name: "Cans of Clams", quantity: 4, unit: .none),
            Ingredient(name: "Cloves of Garlic", quantity: 8, unit: .none),
            Ingredient(name: "Onion", quantity: 1, unit: .none),
            Ingredient(name: "Salt and Pepper", quantity: 1, unit: .none),
            Ingredient(name: "White Wine", quantity: 2, unit: .tbs),
            Ingredient(name: "Butter", quantity: 4, unit: .tbs)
           ],
           directions:  [
            Direction(description: "Chop garlic and onions", isOptional: false),
            Direction(description: "Saute garlic and onions in olive oil", isOptional: false),
            Direction(description: "Add clams and 1/2 juice in cans", isOptional: false),
            Direction(description: "Add butter, wine, and salt pepper to taste", isOptional: false),
            Direction(description: "Simmer for 15min until sauce deduces 1/2", isOptional: false),
            Direction(description: "Serve over favorite pasta", isOptional: false)
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Granola Bowl",
                                            description: "A dense and delicious breakfast",
                                            author: "Ben",
                                            category: .breakfast),
           ingredients: [
            Ingredient(name: "Granola", quantity: 0.5, unit: .cups),
            Ingredient(name: "Banana", quantity: 1, unit: .none),
            Ingredient(name: "Peanut Butter", quantity: 2, unit: .tbs),
           ],
           directions:  [
            Direction(description: "Slice the banana", isOptional: false),
            Direction(description: "Combine all ingredients in a bowl", isOptional: false),
            Direction(description: "Add chocolate chips", isOptional: true),
           ]
    ),
    Recipe(mainInformation: MainInformation(name: "Banana Bread",
                                            description: "Easy to put together, and a family favorite!",
                                            author: "Lisbeth",
                                            category: .dessert),
           ingredients: [
            Ingredient(name: "Ripe bananas", quantity: 3, unit: .none),
            Ingredient(name: "Sugar", quantity: 1, unit: .cups),
            Ingredient(name: "Egg", quantity: 1, unit: .none),
            Ingredient(name: "Flour", quantity: 1.5, unit: .cups),
            Ingredient(name: "Melted Butter", quantity: 0.25, unit: .cups),
            Ingredient(name: "Baking Soda", quantity: 1, unit: .tsp),
            Ingredient(name: "Salt", quantity: 1, unit: .tsp),
            Ingredient(name: "Chocolate Chips", quantity: 1, unit: .cups)
           ],
           directions:  [
            Direction(description: "Preheat oven to 325", isOptional: false),
            Direction(description: "Mash banana with fork", isOptional: false),
            Direction(description: "Stir in sugar, egg, flour, melted butter, soda, and salt", isOptional: false),
            Direction(description: "Stir in chocolate chips", isOptional: false),
            Direction(description: "Pour in buttered loaf and bake 1 hour or until knife inserted comes out clean", isOptional: false)
           ]
    )
  ]
}
