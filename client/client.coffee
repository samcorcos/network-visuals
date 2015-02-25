Template.registerHelper "capitalize", (string) ->
  lower = string.slice(1, string.length)
  upper = string[0].toUpperCase()
  capital = upper + lower
  return capital