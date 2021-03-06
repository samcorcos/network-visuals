Meteor.startup ->

  # Seeding with admin account
  if Meteor.users.find().count() is 0
    Accounts.createUser
      username: 'admin'
      password: 'adminpassword'
      profile:
        roles: ['admin']

  # Seeding people with json data
  if People.find().count() is 0
    nodes = [
      {"name": "Abby", "occupation": "media", "location": "IL", "gender": "female", "marital_status": "single", "interests": ["hiking", "running"]},
      {"name": "Adam", "occupation": "law", "location": "NY", "gender": "male", "marital_status": "single", "interests": ["boating", "crepes"]},
      {"name": "Aleksandra", "occupation": "entrepreneur", "location": "NY", "gender": "female", "marital_status": "single", "interests": ["poker", "running"]},
      {"name": "Alexander", "occupation": "finance", "location": "IL", "gender": "female", "marital_status": "single", "interests": ["hiking", "running"]},
      {"name": "Alex", "occupation": "finance", "location": "VA", "gender": "male", "marital_status": "single", "interests": ["hockey", "poker"]},
      {"name": "Alice", "occupation": "finance", "location": "CA", "gender": "female", "marital_status": "single", "interests": ["boating", "crepes"]},
      {"name": "Amy", "occupation": "media", "location": "IL", "gender": "female", "marital_status": "single", "interests": ["hiking", "running"]},
      {"name": "Allison", "occupation": "finance", "location": "NY", "gender": "female", "marital_status": "married", "interests": ["hiking", "cooking"]},
      {"name": "Hugo", "occupation": "technology", "location": "NY", "gender": "male", "marital_status": "married", "interests": ["hockey", "poker"]},
      {"name": "Ben", "occupation": "technology", "location": "NY", "gender": "male", "marital_status": "single", "interests": ["poker", "running"]},
      {"name": "Brad", "occupation": "finance", "location": "NY", "gender": "male", "marital_status": "single", "interests": ["boating", "running"]},
      {"name": "Maxine", "occupation": "media", "location": "NY", "gender": "female", "marital_status": "single", "interests": ["hiking", "boating"]},
      {"name": "Nathan", "occupation": "technology", "location": "CA", "gender": "male", "marital_status": "single", "interests": ["cooking", "cooking"]},
      {"name": "Erin", "occupation": "law", "location": "CA", "gender": "female", "marital_status": "married", "interests": ["crepes", "running"]},
      {"name": "Gertrude", "occupation": "finance", "location": "TX", "gender": "female", "marital_status": "single", "interests": ["hockey", "running"]},
      {"name": "Leon", "occupation": "finance", "location": "HI", "gender": "male", "marital_status": "single", "interests": ["poker", "crepes"]},
      {"name": "Stanley", "occupation": "finance", "location": "AK", "gender": "male", "marital_status": "single", "interests": ["hockey", "poker"]},
      {"name": "Courtney", "occupation": "finance", "location": "FL", "gender": "female", "marital_status": "single", "interests": ["hockey", "poker"]},
      {"name": "Elvira", "occupation": "finance", "location": "SC", "gender": "female", "marital_status": "single", "interests": ["hockey", "poker"]},
      {"name": "Dave", "occupation": "law", "location": "TN", "gender": "male", "marital_status": "married", "interests": ["hockey", "running"]},
      {"name": "Johnny", "occupation": "finance", "location": "CT", "gender": "male", "marital_status": "single", "interests": ["hockey", "running"]},
      {"name": "Fred", "occupation": "technology", "location": "TX", "gender": "male", "marital_status": "single", "interests": ["boating", "running"]},
      {"name": "Francis", "occupation": "entrepreneur", "location": "FL", "gender": "male", "marital_status": "married", "interests": ["cooking", "hiking"]},
      {"name": "April", "occupation": "fish_monger", "location": "FL", "gender": "female", "marital_status": "single", "interests": ["cooking", "running"]},
      {"name": "Sherry", "occupation": "media", "location": "MA", "gender": "female", "marital_status": "single", "interests": ["cooking", "running"]},
      {"name": "Kayla", "occupation": "retail", "location": "TX", "gender": "female", "marital_status": "single", "interests": ["poker", "running"]},
      {"name": "Clint", "occupation": "retail", "location": "CA", "gender": "male", "marital_status": "single", "interests": ["hockey", "crepes"]},
      {"name": "Zach", "occupation": "retail", "location": "MN", "gender": "male", "marital_status": "single", "interests": ["hiking", "hockey"]},
      {"name": "Nancy", "occupation": "retail", "location": "LA", "gender": "female", "marital_status": "single", "interests": ["hiking", "crepes"]},
      {"name": "Albert", "occupation": "retail", "location": "AR", "gender": "male", "marital_status": "married", "interests": ["hiking", "cooking"]},
      {"name": "Eleanor", "occupation": "finance", "location": "CO", "gender": "female", "marital_status": "single", "interests": ["hiking", "cooking"]},
      {"name": "Kim", "occupation": "finance", "location": "IL", "gender": "female", "marital_status": "single", "interests": ["hiking", "running"]},
      {"name": "Matthew", "occupation": "finance", "location": "NY", "gender": "male", "marital_status": "married", "interests": ["crepes", "running"]},
      {"name": "Olivia", "occupation": "finance", "location": "CA", "gender": "female", "marital_status": "single", "interests": ["boating", "running"]},
      {"name": "Mario", "occupation": "finance", "location": "CA", "gender": "male", "marital_status": "single", "interests": ["hiking", "running"]}
    ]
    nodes.forEach (node) ->
      People.insert node
